SMODS.Joker {
  key = "shadowmantle",
  config = {
    extra = {
      odds = 15,
      suit = 'paperback_Stars'
    }
  },
  rarity = 3,
  pos = { x = 18, y = 6 },
  atlas = "jokers_atlas",
  cost = 8,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  paperback = {
    requires_stars = true
  },

  in_pool = function(self, args)
    -- Only in pool if you have a Star or if a Spectrum has been played
    return PB_UTIL.has_suit_in_deck(self.config.extra.suit, false)
  end,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_negative

    return {
      vars = {
        localize(card.ability.extra.suit, 'suits_plural'),
        G.GAME.probabilities.normal,
        card.ability.extra.odds,
        colours = {
          G.C.SUITS[card.ability.extra.suit] or G.C.PAPERBACK_STARS_LC
        }
      }
    }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
      if pseudorandom('shadowmantle') < G.GAME.probabilities.normal / card.ability.extra.odds then
        PB_UTIL.add_tag("tag_negative", true)
      end
    end
  end
}
