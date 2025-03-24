SMODS.Joker {
  key = "autumn_leaves",
  config = {
    extra = {
      xMult = 1.05,
      xMult_gain = 0.05,
      xMult_base = 1.05,
      suit = "Diamonds",
    }
  },
  rarity = 1,
  pos = { x = 0, y = 4 },
  atlas = "jokers_atlas",
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(card.ability.extra.suit, 'suits_plural'),
        card.ability.extra.xMult_base,
        card.ability.extra.xMult_gain,
        localize(card.ability.extra.suit, 'suits_singular')
      }
    }
  end,

  calculate = function(self, card, context)
    return PB_UTIL.panorama_logic(card, context)
  end,

  joker_display_def = function(JokerDisplay)
    return {
      text = {
        {
          border_nodes = {
            { text = "X" },
            { ref_table = "card.joker_display_values", ref_value = "xMult", retrigger_type = "exp" },
          }
        }
      },

      reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.SUITS["Diamonds"] },
        { text = ")" },
      },

      calc_function = function(card)
        PB_UTIL.panorama_joker_display_logic(card, JokerDisplay)
      end,
    }
  end,
}
