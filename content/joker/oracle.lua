SMODS.Joker {
  key = "oracle",
  config = {
    extra = {
      Xmult_mod = 0.15,
      Xmult = 1
    }
  },
  rarity = 1,
  pos = { x = 15, y = 9 },
  atlas = 'jokers_atlas',
  cost = 6,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  paperback = {
    requires_minor_arcana = true
  },

  loc_vars = function(self, info_queue, card)
    card.ability.extra.Xmult = 1 + (PB_UTIL.count_used_consumables("paperback_minor_arcana", false))
        * card.ability.extra.Xmult_mod
    return {
      vars = {
        card.ability.extra.Xmult_mod,
        card.ability.extra.Xmult
      }
    }
  end,

  calculate = function(self, card, context)
    card.ability.extra.Xmult = 1 + (PB_UTIL.count_used_consumables("paperback_minor_arcana", false))
        * card.ability.extra.Xmult_mod

    if context.joker_main then
      return {
        x_mult = card.ability.extra.Xmult,
      }
    end

    if context.using_consumeable and context.consumeable.ability.set == 'paperback_minor_arcana' and G.GAME.consumeable_usage[context.consumeable.config.center_key].count == 1 then
      return {
        message = localize('k_upgrade_ex')
      }
    end
  end,

  joker_display_def = function(JokerDisplay)
    return {
      text = {
        {
          border_nodes = {
            { text = 'X' },
            { ref_table = 'card.ability.extra', ref_value = 'Xmult' }
          }
        }
      },
    }
  end
}
