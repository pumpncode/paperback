SMODS.Joker {
  key = "reference_card",
  config = {
    extra = {
      x_mult = 1,
      x_mult_mod = 2
    }
  },
  rarity = 2,
  pos = { x = 3, y = 2 },
  atlas = "jokers_atlas",
  cost = 6,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  paperback = {
    extra_button = {
      text = 'paperback_ui_info',
      colour = G.C.PAPERBACK_MAIN_COLOR,
      click = function(self, card)
        card.paperback_show_hands = not card.paperback_show_hands
        self.text = card.paperback_show_hands and 'paperback_ui_info_expanded' or 'paperback_ui_info'
      end,
      should_show = function(self, card)
        return card.area == G.jokers
      end
    }
  },

  loc_vars = function(self, info_queue, card)
    local x_mult = card.ability.extra.x_mult_mod * G.GAME.paperback.reference_card_ct + card.ability.extra.x_mult

    local hand_columns = {
      [1] = {},
      [2] = {},
      [3] = {}
    }

    for i, hand in ipairs(PB_UTIL.base_poker_hands) do
      local current_hand = G.GAME.hands[hand]

      if current_hand.played <= G.GAME.paperback.reference_card_ct then
        table.insert(hand_columns[((i - 1) % 3) + 1], {
          n = G.UIT.R,
          config = { align = 'cm', padding = 0.1, emboss = 0.04, r = 0.02, colour = G.C.UI.BACKGROUND_DARK },
          nodes = {
            {
              n = G.UIT.T,
              config = {
                text = localize(hand, 'poker_hands'),
                scale = 0.3,
                colour = G.C.UI.TEXT_LIGHT,
              }
            }
          }
        })
      end
    end

    return {
      vars = {
        card.ability.extra.x_mult_mod,
        x_mult
      },
      main_end = card.paperback_show_hands and {
        {
          n = G.UIT.C,
          config = { align = 'cm', padding = 0.05 },
          nodes = {
            {
              n = G.UIT.R,
              config = { align = 'cm' },
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = localize('paperback_ui_remaining_hands'),
                    scale = 0.4,
                    colour = G.C.CHIPS
                  }
                }
              }
            },
            {
              n = G.UIT.R,
              config = { align = 'cm' },
              nodes = {
                #hand_columns[1] > 0 and {
                  n = G.UIT.C,
                  config = { align = 'cm', padding = 0.1 },
                  nodes = hand_columns[1]
                } or nil,
                #hand_columns[2] > 0 and {
                  n = G.UIT.C,
                  config = { align = 'cm', padding = 0.1 },
                  nodes = hand_columns[2]
                } or nil,
                #hand_columns[3] > 0 and {
                  n = G.UIT.C,
                  config = { align = 'cm', padding = 0.1 },
                  nodes = hand_columns[3]
                } or nil
              }
            }
          }
        }
      }
    }
  end,

  calculate = function(self, card, context)
    if context.before then
      PB_UTIL.calculate_highest_shared_played(card)
      if card.ability.extra.message_flag then
        card.ability.extra.message_flag = nil
        SMODS.calculate_effect({
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
        }, card)
      end
    end

    -- Gives the xMult during play
    if context.joker_main then
      local x_mult = card.ability.extra.x_mult_mod * G.GAME.paperback.reference_card_ct + card.ability.extra.x_mult

      if x_mult ~= 1 then
        return {
          x_mult = x_mult,
          card = card
        }
      end
    end
  end,

  joker_display_def = function(JokerDisplay)
    return {
      text = {
        {
          border_nodes = {
            { text = "X" },
            { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
          }
        }
      },
      calc_function = function(card)
        card.joker_display_values.x_mult = card.ability.extra.x_mult_mod * G.GAME.paperback.reference_card_ct +
            card.ability.extra.x_mult
      end,
    }
  end,
}

-- Update global information for Reference Card.
-- See solar_system.lua
function PB_UTIL.calculate_highest_shared_played(card)
  local old = G.GAME.paperback.reference_card_ct
  local hands = G.GAME.hands

  -- Finds the mininum played hand in G.GAME.hands in all base poker hands

  local min_played = hands[PB_UTIL.base_poker_hands[1]].played

  for _, hand in ipairs(PB_UTIL.base_poker_hands) do
    local current_hand = hands[hand]

    if current_hand.played < min_played then
      min_played = current_hand.played
    end
  end

  -- set global to minimum played
  G.GAME.paperback.reference_card_ct = min_played
  if old < G.GAME.paperback.reference_card_ct then
    for _, v in ipairs(SMODS.find_card('j_paperback_reference_card')) do
      v.ability.extra.message_flag = true
    end
  end
end
