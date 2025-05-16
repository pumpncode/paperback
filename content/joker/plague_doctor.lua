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

  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.jokers and not context.blueprint then
      local to_apostle = context.scoring_hand[1]
      if context.scoring_name == 'High Card' and to_apostle:get_id() ~= SMODS.Ranks['paperback_Apostle'].id then
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
      end
    end

    if context.individual and context.cardarea == G.hand and not context.end_of_round then
      if context.other_card:get_id() == SMODS.Ranks['paperback_Apostle'].id then
        if context.other_card.debuff then
          return {
            message = localize(k_debuffed),
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
