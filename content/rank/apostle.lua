SMODS.Rank {
  key = 'Apostle',
  card_key = 'APOSTLE',
  shorthand = 'T',

  lc_atlas = 'ranks_lc',
  hc_atlas = 'ranks_hc',
  pos = { x = 0 },

  straight_edge = true,
  next = { 'Ace' },
  nominal = 12,
  face = true,

  suit_map = {
    Hearts = 0,
    Clubs = 1,
    Diamonds = 2,
    Spades = 3,
    paperback_Stars = 4,
    paperback_Crowns = 5,
    bunc_Fleurons = 6,
    bunc_Halberds = 7
  },

  in_pool = function(self, args)
    -- Hardcoded Dreamer sleeve able to spawn Apostles for now, since
    -- I can't figure out a better way
    if args and args.initial_deck then
      local deck = (G.GAME.selected_back or {}).name
      local sleeve = G.GAME.selected_sleeve

      if deck == 'b_paperback_dreamer' and sleeve == 'sleeve_paperback_dreamer' then
        return true
      end
    end

    return false
  end
}

-- Ace adjustments to allow for straights with Apostle
SMODS.Rank:take_ownership('Ace',
  {
    next = { '2', 'paperback_Apostle' },
    straight_edge = false
  }
)
