SMODS.Enhancement {
  key = "sleeved",
  atlas = "jokers_atlas",   -- TEMPORARY
  pos = { x = 18, y = 8 },  -- ONLY UNTIL THE ART IS MADE
  config = { extra = {
    money = 5
  } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,

  calculate = function(self, card, context)
    if context.stay_flipped and context.other_card == card then
      return { prevent_stay_flipped = true }
    end

    if context.remove_playing_cards then
      for _, removed in ipairs(context.removed) do
        if removed == card then return { dollars = card.ability.extra.money } end
      end
    end
  end
}
