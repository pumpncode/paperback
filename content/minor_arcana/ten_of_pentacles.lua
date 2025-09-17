PB_UTIL.MinorArcana {
  key = 'ten_of_pentacles',
  atlas = 'minor_arcana_atlas',
  pos = { x = 2, y = 7 },

  config = { extra = {
    cost = 25
  } },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_investment
    return { vars = { card.ability.extra.cost } }
  end,

  can_use = function(self, card)
    return G.GAME.dollars >= card.ability.extra.cost
  end,

  use = function(self, card)
    ease_dollars(-card.ability.extra.cost)
    PB_UTIL.use_consumable_animation(card, nil, function()
      PB_UTIL.add_tag('tag_investment')
      PB_UTIL.add_tag('tag_investment')
    end)
  end
}
