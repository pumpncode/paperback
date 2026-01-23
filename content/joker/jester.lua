SMODS.Joker {
  key = "jester",
  rarity = 2,
  pos = { x = 13, y = 11 },
  atlas = "jokers_atlas",
  cost = 7,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  paperback_credit = {
    coder = 'thermo'
  },

  calculate = function(self, card, context)
    if context.remove_playing_cards then
      local cards_to_destroy = {}
      local count = math.min(#context.removed, #G.playing_cards)
      for i = 1, count, 1 do
        cards_to_destroy[i] = pseudorandom_element(G.playing_cards, "jester")
      end
      SMODS.destroy_cards(cards_to_destroy)
      return {
        message = "killed :)"
      }
    end
  end
}
