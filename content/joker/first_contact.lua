SMODS.Joker {
  key = "first_contact",
  config = {
    extra = {
      required = 17,
      current = 0
    }
  },

  paperback_credit = {
    coder = 'thermo'
  },

  rarity = 3,
  pos = { x = 22, y = 9 },
  atlas = "jokers_atlas",
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = PB_UTIL.suit_tooltip('dark')
    return {
      vars = {
        card.ability.extra.required,
        card.ability.extra.required - card.ability.extra.current
      }
    }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if PB_UTIL.is_suit(context.other_card, 'dark') and not context.blueprint then
        card.ability.extra.current = card.ability.extra.current + 1
      end
      if card.ability.extra.current >= card.ability.extra.required then
        card.ability.extra.current = 0
        if PB_UTIL.try_spawn_card { set = 'Spectral' } then
          return {
            message = localize('k_plus_spectral'),
            colour = G.C.SPECTRAL,
            card = context.blueprint_card or card,
            message_card = context.blueprint_card or card
          }
        end
      end
    end
  end
}
