SMODS.Joker {
  key = "stout",
  config = {
    extra = {
      xchips = 1,
      a_xchips = 0.1,
      suit = "Spades",
      req = 5
    }
  },
  rarity = 3,
  pos = { x = 23, y = 8 },
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
        localize(card.ability.extra.suit, 'suits_plural'),
        card.ability.extra.xchips,
        card.ability.extra.a_xchips,
        card.ability.extra.req,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.before and not context.blueprint and PB_UTIL.suit_drink_logic(card, context, true) then
      return PB_UTIL.suit_drink_logic(card, context, false)
    end

    if context.before and not context.blueprint then
      local spades = 0
      for _, v in ipairs(context.scoring_hand) do
        if v:is_suit(card.ability.extra.suit, false, true) then
          spades = spades + 1
        end
      end
      if spades >= card.ability.extra.req then
        card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.a_xchips
        return {
          message = localize {
            type = 'variable',
            key = 'a_xchips',
            vars = { card.ability.extra.xchips }
          },
        }
      end
    end

    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit(card.ability.extra.suit) then
        return {
          xchips = card.ability.extra.xchips,
        }
      end
    end
  end,
}
