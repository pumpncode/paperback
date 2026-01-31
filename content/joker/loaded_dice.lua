SMODS.Joker {
  key = "loaded_dice",
  config = {
    extra = {
      odds = 1,
      triggered = nil
    }
  },
  rarity = 1,
  pos = { x = 25, y = 6 },
  atlas = "jokers_atlas",
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  paperback_credit = {
    coder = { 'thermo' }
  },
  paperback = {
    requires_custom_suits = true
  },

  loc_vars = function(self, info_queue, card)
    local n, d = PB_UTIL.chance_vars(nil, nil, 1, 3)     -- example
    if not G.jokers then
      -- outside game, manually modify
      n = n + 1
    end
    return { vars = { card.ability.extra.dollars, n, d } }
  end,

  calculate = function(self, card, context)
    if context.mod_probability and not context.blueprint then
      if G.GAME.paperback.hand_cointained_crown then
        card.ability.extra.triggered = true
        return {
          numerator = context.numerator + 1,
        }
      end
    end
    if context.after and card.ability.extra.triggered then
      card.ability.extra.triggered = nil
      G.GAME.paperback.hand_cointained_crown = false
    end
  end
}
