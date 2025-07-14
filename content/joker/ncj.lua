SMODS.Joker {
  key = "ncj",
  rarity = 1,
  pos = { x = 15, y = 5 },
  atlas = "jokers_atlas",
  config = {
    extra = {
      scaling = 8
    }
  },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  loc_vars = function(self, info_queue, card)
    local in_shop = card.area and card.area.config.type == 'shop'
    local sell_cost = in_shop and card.sell_cost or 0

    if G.jokers then
      for _, v in ipairs(G.jokers.cards) do
        sell_cost = sell_cost + v.sell_cost
      end
    end

    return {
      vars = {
        card.ability.extra.scaling,
        math.max(0, sell_cost * card.ability.extra.scaling)
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local sell_cost = 0

      for _, v in ipairs(G.jokers.cards) do
        sell_cost = sell_cost + v.sell_cost
      end

      return {
        chips = math.max(0, sell_cost * card.ability.extra.scaling)
      }
    end
  end
}
