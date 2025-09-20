PB_UTIL.MinorArcana {
  key = 'queen_of_pentacles',
  atlas = 'minor_arcana_atlas',
  pos = { x = 0, y = 8 }, -- change to x = 5, y = 7 when art is added
  config = {
    min_highlighted = 2,
    max_highlighted = 3,
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.max_highlighted,
      }
    }
  end,

  can_use = function(self, card)
    if #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted >= card.ability.min_highlighted then
      local cards = PB_UTIL.get_sorted_by_position(G.hand)
      local source = cards[1]
      local has_rank = not SMODS.has_no_rank(source)
      local has_suit = not SMODS.has_no_suit(source)
      return has_rank or has_suit
    end
  end,

  use = function(self, card)
    local cards = PB_UTIL.get_sorted_by_position(G.hand)
    local source = cards[1]
    local rank = (not SMODS.has_no_rank(source) and source.base.value) or nil
    local suit = (not SMODS.has_no_suit(source) and source.base.suit) or nil

    if rank or suit then
      PB_UTIL.use_consumable_animation(card, cards, function()
        for i = 2, #cards do
          SMODS.change_base(cards[i], suit, rank)
        end
      end)
    end
  end
}
