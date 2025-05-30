SMODS.Joker {
  key = "plague_doctor",
  config = {
    extra = {
      xMult = 1.25
    }
  },
  rarity = 2,
  pos = { x = 8, y = 4 },
  atlas = "jokers_atlas",
  cost = 7,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  paperback = {
    requires_ranks = true
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.xMult
      }
    }
  end,

  add_to_deck = function(self, card, from_debuff)
    local apostleCount = 0
    for _, v in ipairs(G.playing_cards) do
      if v:get_id() == SMODS.Ranks['paperback_Apostle'].id then
        apostleCount = apostleCount + 1
      end
    end
    if apostleCount >= 12 then
      G.GAME.pool_flags.plague_doctor_can_spawn = false
      G.E_MANAGER:add_event(Event({
        func = function()
          card.getting_sliced = true
          card:start_dissolve()
          SMODS.add_card({
            set = 'Joker',
            key = 'j_paperback_white_night',
            stickers = { "eternal" }
          })
          return true
        end
      }))
    end
  end,

  in_pool = function(self, args)
    return G.GAME.pool_flags.plague_doctor_can_spawn
  end,

  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.jokers and not context.blueprint then
      local apostleCount = 0
      for _, v in ipairs(G.playing_cards) do
        if v:get_id() == SMODS.Ranks['paperback_Apostle'].id then
          apostleCount = apostleCount + 1
        end
      end

      local to_apostle = context.scoring_hand[1]
      if context.scoring_name == 'High Card' and to_apostle:get_id() ~= SMODS.Ranks['paperback_Apostle'].id then
        apostleCount = apostleCount + 1
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
            to_apostle:flip()
            play_sound('card1', 1)
            to_apostle:juice_up(0.3, 0.3)
            return true
          end
        }))
        delay(0.2)
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.1,
          func = function()
            assert(SMODS.change_base(to_apostle, nil, 'paperback_Apostle'))
            return true
          end
        }))
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
            to_apostle:flip()
            play_sound('tarot2', 1, 0.6)
            to_apostle:juice_up(0.3, 0.3)
            return true
          end
        }))

        local quote = math.random(12)
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.1,
          func = function()
            plague_quote({
              text = localize('paperback_plague_quote_' .. quote .. '_1'),
              colour = G.C.RED,
              major = G.play,
              hold = 4*G.SETTINGS.GAMESPEED,
              offset = { x = 0, y = -3 },
              scale = 0.6
            })
            plague_quote({
              text = localize('paperback_plague_quote_' .. quote .. '_2'),
              colour = G.C.RED,
              major = G.play,
              hold = 4*G.SETTINGS.GAMESPEED,
              offset = { x = 0, y = -2.2 },
              scale = 0.6
            })
            return true
          end
        }))
      end

      if apostleCount >= 12 then
        G.GAME.pool_flags.plague_doctor_can_spawn = false
        G.E_MANAGER:add_event(Event({
          func = function()
            card.getting_sliced = true
            card:start_dissolve()
            SMODS.add_card({
              set = 'Joker',
              key = 'j_paperback_white_night',
              stickers = { "eternal" }
            })
            return true
          end
        }))
      end
    end

    if context.individual and context.cardarea == G.hand and not context.end_of_round then
      if context.other_card:get_id() == SMODS.Ranks['paperback_Apostle'].id then
        if context.other_card.debuff then
          return {
            message = localize('k_debuffed'),
            colour = G.C.RED
          }
        else
          return {
            x_mult = card.ability.extra.xMult
          }
        end
      end
    end
  end
}

-- text display function for plague doctor's quotes
-- adapted from vanilla attention_text()
function plague_quote(args)
  args = args or {}
  args.text = args.text or 'test'
  args.scale = args.scale or 1
  args.colour = copy_table(args.colour or G.C.WHITE)
  args.hold = (args.hold or 0) + 0.1*(G.SPEEDFACTOR)

  args.cover_colour = copy_table(G.C.CLEAR)

  args.uibox_config = {
    align = 'cm',
    offset = args.offset or { x = 0, y = 0 },
    major = args.major or nil
  }

  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0,
    blockable = false,
    blocking = true,
    func = function()
      args.AT = UIBox{
        T = {0, 0, 0, 0},
        definition = {
          n = G.UIT.ROOT, config = {
            align = 'cm',
            minw = 0.001,
            minh = 0.001,
            padding = 0.03,
            r = 0.1,
            emboss = nil,
            colour = args.cover_colour
          }, nodes = {
            { n = G.UIT.O, config = { draw_layer = 1, object = DynaText({scale = args.scale, string = args.text, maxw = args.maxw, colours = {args.colour}, float = true, shadow = true, silent = true, args.scale, pop_in = 0, pop_in_rate = 1, rotate = nil})}},
          }
        },
        config = args.uibox_config
      }
      args.AT.attention_text = true
      args.text = args.AT.UIRoot.children[1].config.object
      return true
    end
  }))

  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = args.hold,
    blockable = false,
    blocking = true,
    func = function()
      args.start_time = G.TIMERS.TOTAL
      args.text:pop_out(3)
      return true
    end
  }))
end
