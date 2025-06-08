SMODS.Enhancement {
  key = 'stained',
  atlas = 'enhancements_atlas',
  pos = { x = 5, y = 0 },
  config = {
    extra = {
      mult_mod = 1,
      held = false
    }
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult_mod
      }
    }
  end,

  update = function(self, card, dt)
    if G.hand then
      for k, v in pairs(G.hand.cards) do
        if v == card then
          card.ability.extra.held = true
          break
        end
        card.ability.extra.held = false
      end
    end
  end,


  calculate = function(self, card, context)
    if context.paperback and context.paperback.playing_card_scored then
      if context.paperback.other_card and card.ability.extra.held then
        context.paperback.other_card.ability.perma_mult = (context.paperback.other_card.ability.perma_mult or 0) +
            card.ability.extra.mult_mod
        return {
          card = context.paperback.other_card,
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
        }
      end
    end
  end
}
