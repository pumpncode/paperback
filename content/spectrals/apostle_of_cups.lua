SMODS.Consumable {
  key = 'apostle_of_cups',
  config = {
    extra = {
      delta = -1
    }
  },
  set = "Spectral",
  atlas = 'spectral_atlas',
  pos = { x = 0, y = 0 },

  hidden = true,
  soul_set = "paperback_minor_arcana",

  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.delta }
    }
  end,

  can_use = function(self, card)
    return G.jokers
        and #G.jokers.cards < G.jokers.config.card_limit
        and #G.jokers.highlighted == 1
        and not G.jokers.highlighted[1].edition
  end,

  use = function(self, card, area, copier)
    local joker = G.jokers.highlighted[1]

    PB_UTIL.use_consumable_animation(card, nil, function()
      joker:set_edition('e_negative')

      G.jokers:change_size(card.ability.extra.delta)
    end)
  end
}
