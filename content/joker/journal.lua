SMODS.Joker {
  key = "journal",
  config = {
    extra = {
      prev_chips = 0
    }
  },
  paperback_credit = {
    coder = { 'thermo' }
  },
  rarity = 2,
  pos = { x = 5, y = 11 },
  atlas = "jokers_atlas",
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.prev_chips
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chips = card.ability.extra.prev_chips
      }
    end
    if context.final_scoring_step then
      card.ability.extra.prev_chips = hand_chips - card.ability.extra.prev_chips
    end
  end
}
