PB_UTIL.EGO_Gift {
  key = 'coffee_and_cranes',
  config = {
    sin = 'lust',
    max = 10,
    dollars = 1,
    threshold = 5,
  },

  atlas = 'ego_gift_atlas',
  pos = { x = 1, y = 0 },
  soul_pos = { x = 1, y = 3 },
  ego_loc_vars = function(self, info_queue, card)
    local dollar_bonus = math.min(card.ability.max,
      math.max(0,
        card.ability.dollars * math.floor(G.GAME.dollars / card.ability.threshold)))
    return {
      card.ability.threshold,
      card.ability.dollars,
      card.ability.max,
      dollar_bonus
    }
  end,

  calc_dollar_bonus = function(self, card)
    local dollar_bonus = math.min(card.ability.max,
      math.max(0,
        card.ability.dollars * math.floor(G.GAME.dollars / card.ability.threshold)))
    return dollar_bonus
  end
}
