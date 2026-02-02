SMODS.Joker {
  key = "grenadine",
  config = {
    extra = {
      xmult = 1.25,
      a_xmult = 0.025,
      suit = "Hearts",
    }
  },
  rarity = 3,
  pos = { x = 23, y = 10 },
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
    coder = { 'dowfrin' },
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
        localize(card.ability.extra.suit, 'suits_plural'),
        card.ability.extra.xmult,
        card.ability.extra.a_xmult,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.before and not context.blueprint and PB_UTIL.suit_drink_logic(card, context, true) then
      return PB_UTIL.suit_drink_logic(card, context, false)
    end

    if context.pseudorandom_result and not context.result then
      card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.a_xmult
      return {
        message = localize {
          type = 'variable',
          key = 'a_xmult',
          vars = { card.ability.extra.xmult }
        },
      }
    end

    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit(card.ability.extra.suit) then
        return {
          xmult = card.ability.extra.xmult,
        }
      end
    end
  end,
}
