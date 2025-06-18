SMODS.Joker {
  key = "clippy",
  rarity = 2,
  pos = { x = 15, y = 6 },
  soul_pos = { x = 16, y = 6 },
  atlas = "jokers_atlas",
  cost = 7,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  paperback = {
    requires_paperclips = true
  },

  calculate = function(self, card, context)
    if context.setting_blind then
      local count = 0
      local _card
      repeat
        _card = pseudorandom_element(G.playing_cards, pseudoseed("clippy" .. count))
        count = count + 1
      until not PB_UTIL.has_paperclip(_card) or count > #G.playing_cards
      PB_UTIL.set_paperclip(_card, PB_UTIL.poll_paperclip "clippy")
      juice_card(card)
    end
  end
}
