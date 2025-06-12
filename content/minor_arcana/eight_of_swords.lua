PB_UTIL.MinorArcana {
  key = 'eight_of_swords',
  config = {
    max_highlighted = 3,
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 0, y = 5 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.max_highlighted,
      }
    }
  end,

  use = function(self, card, area)
    PB_UTIL.use_consumable_animation(card, G.hand.highlighted, function()
      for _, v in ipairs(G.hand.highlighted) do
        local clip = pseudorandom_element(PB_UTIL.ENABLED_PAPERCLIPS, pseudoseed('eight_of_swords'))
        clip = string.sub(clip, 1, #clip - 5)
        PB_UTIL.set_paperclip(v, clip)
      end
    end)
  end
}
