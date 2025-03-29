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
  discovered = false,
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
  end,

  joker_display_def = function(JokerDisplay)
    return {
      reminder_text = {
        { text = '(' },
        { ref_table = 'card.ability.extra', ref_value = 'rank', colour = G.C.IMPORTANT, scale = 0.35 },
        { text = ')' },
      },

      extra = {
        {
          { text = '(' },
          { ref_table = 'card.joker_display_values', ref_value = 'odds' },
          { text = ')' }
        },
      },
      extra_config = {
        colour = G.C.GREEN,
        scale = 0.3
      },

      calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = 'jdis_odds', vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
      end
    }
  end
}
