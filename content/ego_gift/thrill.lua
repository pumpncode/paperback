PB_UTIL.EGO_Gift {
  key = 'thrill',
  config = {
    sin = 'gluttony',
    a_xmult = 0.5,
  },
  atlas = 'ego_gift_atlas',
  pos = { x = 3, y = 0 },
  soul_pos = { x = 3, y = 3 },

  ego_loc_vars = function(self, info_queue, card)
    return {
      card.ability.a_xmult,
      card.ability.a_xmult * (2 + G.GAME.current_round.discards_used),
    }
  end,

  ego_gift_calc = function(self, card, context)
    if context.pre_discard and G.GAME.current_round.hands_played <= 0 then
      return {
        message = localize {
          type = 'variable',
          key = 'a_xmult',
          vars = { card.ability.a_xmult * (3 + G.GAME.current_round.discards_used) }
        },
        colour = G.C.MULT
      }
    end

    if context.joker_main then
      if G.GAME.current_round.hands_played <= 0 then
        return {
          xmult = card.ability.a_xmult * (2 + G.GAME.current_round.discards_used)
        }
      end
    end
  end,
}
