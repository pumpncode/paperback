SMODS.Joker {
  key = "burning_pact",
  config = {
    extra = {
      required_cards = 1,
      cards = 2,
      active = false
    }
  },
  rarity = 2,
  pos = { x = 10, y = 3 },
  atlas = "jokers_atlas",
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  paperback_credit = {
    coder = { 'srockw' }
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.required_cards,
        card.ability.extra.cards
      }
    }
  end,

  calculate = function(self, card, context)
    if context.pre_discard and (#context.full_hand == card.ability.extra.required_cards) and not context.blueprint then
      card.ability.extra.active = true
    end

    if context.drawing_cards and card.ability.extra.active and not context.blueprint then
      card.ability.extra.active = false
      return {
        modify = card.ability.extra.cards + context.amount
      }
    end
  end
}
