SMODS.Joker {
  key = "boundary_of_death",
  config = {
    extra = {
      odds = 4,
      rank = 4,
      retriggers = 4
    }
  },
  rarity = 3,
  pos = { x = 11, y = 2 },
  atlas = "jokers_atlas",
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(PB_UTIL.get_rank_from_id(card.ability.extra.rank).key, 'ranks'),
        G.GAME.probabilities.normal,
        card.ability.extra.odds,
        card.ability.extra.retriggers
      }
    }
  end,

  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play and context.other_card:get_id() == card.ability.extra.rank then
      if pseudorandom('boundary_of_death') < G.GAME.probabilities.normal / card.ability.extra.odds then
        return {
          repetitions = card.ability.extra.retriggers
        }
      end
    end
  end
}
