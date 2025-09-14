SMODS.Joker {
  key = "black_forest_cake",
  config = {
    extra = {
      mult = 2,
      a_mult = 2
    }
  },
  rarity = 1,
  pos = { x = 13, y = 10 },
  atlas = "jokers_atlas",
  cost = 3,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = false,
  soul_pos = nil,
  pools = {
    Food = true
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult,
        card.ability.extra.a_mult,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.mult > 0 then
      return {
        mult = card.ability.extra.mult,
      }
    end

    if not context.blueprint and context.end_of_round and context.main_eval then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
      return {
        message = localize('k_upgrade_ex'),
        card = card,
        colour = G.C.MULT,
      }
    end

    if not context.blueprint and (
      context.remove_playing_cards and context.removed and #context.removed > 0
      or context.paperback and context.paperback.destroying_joker and card ~= context.paperback.destroyed_joker
    ) then
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card.T.r = -0.2
          card:juice_up(0.3, 0.4)
          card.states.drag.is = true
          card.children.center.pinch.x = true
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
            func = function()
              G.jokers:remove_card(card)
              card:remove()
              card = nil
            return true; end}))
          return true
        end
      }))
      return {
        message = localize('k_eaten_ex'),
        colour = G.C.FILTER
      }
    end
  end
}
