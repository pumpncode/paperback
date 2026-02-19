SMODS.Joker {
  key = "nigori",
  config = {
    extra = {
      chips = 50,
      a_chips = 5,
      suit = "paperback_Stars",
    }
  },
  rarity = 3,
  pos = { x = 24, y = 1 },
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
    requires_stars = true,
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
        card.ability.extra.chips,
        card.ability.extra.a_chips,
      }
    }
  end,
  calculate = function(self, card, context)
    if context.before and not context.blueprint and PB_UTIL.suit_drink_logic(card, context, true) then
      return PB_UTIL.suit_drink_logic(card, context, false)
    end

    if context.paperback and context.paperback.xchips_scored then
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.a_chips
      return {
        message = localize {
          type = 'variable',
          key = 'a_chips',
          vars = { card.ability.extra.chips }
        },
      }
    end

    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit(card.ability.extra.suit) then
        return {
          chips = card.ability.extra.chips,
        }
      end
    end
  end,
}
