SMODS.Joker {
  key = "ncj",
  rarity = 1,
  pos = { x = 15, y = 5 },
  atlas = "jokers_atlas",
  config = {
    extra = {
      chips = 0,
      scaling = 8
    }
  },
  cost = 5,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,


  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.scaling,
        card.ability.extra.chips
      }
    }
  end,
  calculate = function(self, card, context)
    if G.jokers then
      local sell_cost = 0
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] ~= card then
          sell_cost = sell_cost + G.jokers.cards[i].sell_cost
        end
      end
      card.ability.extra.chips = sell_cost * card.ability.extra.scaling
    end

    if context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
  end
}
