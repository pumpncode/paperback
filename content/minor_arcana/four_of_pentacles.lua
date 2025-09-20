PB_UTIL.MinorArcana {
  key = 'four_of_pentacles',
  atlas = 'minor_arcana_atlas',
  pos = { x = 3, y = 6 },
  config = {
    min_highlighted = 4,
    max_highlighted = 4
  },

  loc_vars = function(self, info_queue, card)
    return { vars = {
      card.ability.max_highlighted
    } }
  end,

  use = function(self, card, area)
    local cards = {}

    for _, v in ipairs(G.hand.cards) do
      if not v.highlighted then cards[#cards + 1] = v end
    end

    PB_UTIL.use_consumable_animation(card, nil, function()
      SMODS.destroy_cards(cards)
    end)
  end
}
