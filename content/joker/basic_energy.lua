SMODS.Joker {
  key = "basic_energy",
  config = {
    extra = {
      odds = 4
    }
  },
  rarity = 2,
  pos = { x = 1, y = 6 },
  atlas = 'jokers_atlas',
  cost = 6,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  soul_pos = nil,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        G.GAME.probabilities.normal,
        card.ability.extra.odds
      }
    }
  end,

  calculate = function(self, card, context)
    -- Check that the card being consumed is not a copy made by this joker
    if context.using_consumeable and not context.consumeable.ability.paperback_energized then
      if pseudorandom("basic_energy") < G.GAME.probabilities.normal / card.ability.extra.odds then
        if PB_UTIL.can_spawn_card(G.consumeables, true) then
          return {
            -- Display a copy message, using the color of the set of the card being copied if possible
            message = localize("paperback_copy_ex"),
            colour = G.C.SECONDARY_SET[context.consumeable.ability.set] or G.C.GREEN,
            func = function()
              G.E_MANAGER:add_event(Event({
                func = function()
                  -- Copy the card and mark it as a copy of this joker
                  local copy = copy_card(context.consumeable)
                  copy:add_sticker('paperback_energized', true)
                  copy:add_to_deck()
                  G.consumeables:emplace(copy)
                  G.GAME.consumeable_buffer = 0
                  return true
                end
              }))
            end
          }
        end
      end
    end
  end,

  joker_display_def = function(JokerDisplay)
    return {
      extra = {
        {
          { text = "(" },
          { ref_table = 'card.joker_display_values', ref_value = 'odds' },
          { text = ")" }
        }
      },
      extra_config = {
        colour = G.C.GREEN,
        scale = 0.3,
      },

      calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = 'jdis_odds', vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
      end,
    }
  end
}
