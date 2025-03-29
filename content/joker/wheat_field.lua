SMODS.Joker {
  key = "wheat_field",
  config = {
    extra = {
      xMult = 1.075,
      xMult_gain = 0.075,
      xMult_base = 1.075,
      suit = "paperback_Crowns",
    }
  },
  rarity = 1,
  pos = { x = 3, y = 10 },
  atlas = "jokers_atlas",
  cost = 6,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  paperback = {
    requires_crowns = true,
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(card.ability.extra.suit, 'suits_plural'),
        tostring(card.ability.extra.xMult_base),
        tostring(card.ability.extra.xMult_gain),
        localize(card.ability.extra.suit, 'suits_singular')
      }
    }
  end,

  calculate = PB_UTIL.panorama_logic,
  joker_display_def = PB_UTIL.panorama_joker_display_def
}
