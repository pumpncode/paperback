SMODS.Joker {
  key = "aperol",
  config = {
    extra = {
      a_mult = 2,
      req = 5,
      suit = "Diamonds",
    }
  },
  rarity = 3,
  pos = { x = 24, y = 0 },
  atlas = "jokers_atlas",
  cost = 9,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = false,
  soul_pos = nil,
  pools = {
    Food = true
  },
  paperback = {
    suit_drink = true
  },
  paperback_credit = {
    coder = { 'dowfrin' }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = {
      set = 'Other',
      key = 'paperback_suit_drink',
      vars = {
        localize(card.ability.extra.suit, 'suits_plural'),
        colours = { G.C.SUITS[card.ability.extra.suit] }
      }
    }

    return {
      vars = {
        card.ability.extra.a_mult,
        card.ability.extra.req,
        localize(card.ability.extra.suit, 'suits_plural'),
        math.max(math.floor(G.GAME.dollars / card.ability.extra.req), 0) * card.ability.extra.a_mult,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.before and not context.blueprint and PB_UTIL.suit_drink_logic(card, context, true) then
      return PB_UTIL.suit_drink_logic(card, context, false)
    end

    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit(card.ability.extra.suit) then
        return {
          mult = card.ability.extra.a_mult * (math.max(math.floor(G.GAME.dollars / card.ability.extra.req), 0)),
        }
      end
    end
  end,
}
