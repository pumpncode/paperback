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
      return joker.config.center.eternal_compat or joker.ability.eternal
    end
  end,

  keep_on_use = function(self, card)
    return G.jokers.highlighted[1].config.center.key == "j_paperback_white_night"
  end,

  use = function(self, card)
    local joker = G.jokers.highlighted[1]

    if joker.config.center.key == "j_paperback_white_night" then
      G.P_CENTERS[card.config.center.key].shatters = true
      SMODS.destroy_cards(card)
      G.P_CENTERS[card.config.center.key].shatters = false
    else
      PB_UTIL.use_consumable_animation(card, joker, function()
        if joker.ability.eternal then
          joker:set_eternal(false)
        else
          if joker.ability.perishable then
            joker.ability.perishable = nil
            joker.ability.perish_tally = nil
            SMODS.recalc_debuff(joker)
          end
          joker:set_eternal(true)
        end
      end)
    end
  end
}
