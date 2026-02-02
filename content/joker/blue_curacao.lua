SMODS.Joker {
  key = "blue_curacao",
  config = {
    extra = {
      xmult = 1,
      a_xmult = 0.1,
      suit = "Clubs",
      req = 3
    }
  },
  rarity = 3,
  pos = { x = 23, y = 9 },
  atlas = "jokers_atlas",
  cost = 9,
  unlocked = true,
  perishable_compat = false,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = false,
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
        localize(card.ability.extra.suit, 'suits_plural'),
        card.ability.extra.xmult,
        card.ability.extra.a_xmult,
        card.ability.extra.req,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.before and not context.blueprint and PB_UTIL.suit_drink_logic(card, context, true) then
      return PB_UTIL.suit_drink_logic(card, context, false)
    end

    if context.before and not context.blueprint then
      local clubs = 0
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit(card.ability.extra.suit, false, true) then
          clubs = clubs + 1
        end
      end
      if clubs >= card.ability.extra.req then
        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.a_xmult
        return {
          message = localize {
            type = 'variable',
            key = 'a_xmult',
            vars = { card.ability.extra.xmult }
          },
        }
      end
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
