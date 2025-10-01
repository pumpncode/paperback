SMODS.Joker {
  key = "milk_tea",
  config = {
    extra = {
      percent = 50,
      reduction = 10
    }
  },
  rarity = 2,
  pos = { x = 16, y = 3 },
  atlas = "jokers_atlas",
  cost = 6,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  pools = {
    Food = true
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.percent,
        card.ability.extra.reduction
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      PB_UTIL.apply_plasma_effect(context.blueprint_card or card, false, card.ability.extra.percent / 100)

      -- Apply reduction if mult ended up greater than chips
      if mult > hand_chips and not context.blueprint then
        card.ability.extra.percent = card.ability.extra.percent - card.ability.extra.reduction

        if card.ability.extra.percent <= 0 then
          PB_UTIL.destroy_joker(card)

          return {
            message = localize('paperback_consumed_ex'),
            colour = G.C.MULT
          }
        end

        G.E_MANAGER:add_event(Event {
          delay = 0.4,
          func = function()
            SMODS.calculate_effect({
              message = localize('paperback_reduced_ex'),
              colour = G.C.MULT
            }, card)

            return true
          end
        })
      end

      return nil, true
    end
  end
}
