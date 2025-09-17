PB_UTIL.MinorArcana {
  key = 'two_of_pentacles',
  atlas = 'minor_arcana_atlas',
  pos = { x = 1, y = 6 },

  in_pool = function(self, args)
    return G.GAME.modifiers.enable_eternals_in_shop
  end,

  can_use = function(self, card)
    if G.jokers and #G.jokers.highlighted == 1 then
      local joker = G.jokers.highlighted[1]

      -- checks for non-compatible jokers that have eternal anyway
      -- just in case :P
      return (joker.config.center.eternal_compat or joker.ability.eternal) and not joker.ability.perishable
    end
  end,

  use = function(self, card)
    local joker = G.jokers.highlighted[1]

    PB_UTIL.use_consumable_animation(card, joker, function()
      if joker.ability.eternal then
        joker:set_eternal(false)
      else
        joker:set_eternal(true)
      end
    end)
  end
}
