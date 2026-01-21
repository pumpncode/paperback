SMODS.Joker {
  key = "cast_iron",
  config = {
    extra = {
      divisor = 3,
      hand_size = 0,
      max = 5
    }
  },
  paperback_credit = {
    coder = { 'thermo' }
  },
  rarity = 2,
  pos = { x = 12, y = 11 },
  atlas = "jokers_atlas",
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel

    local steel_tally = 0
    if G.playing_cards then
      for _, playing_card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(playing_card, 'm_steel') then steel_tally = steel_tally + 1 end
      end
    end
    return {
      vars = {
        card.ability.extra.add_hands,
        card.ability.extra.divisor,
        localize {
          type = 'name_text',
          set = 'Enhanced',
          key = 'm_steel'
        },
        math.floor(steel_tally / card.ability.extra.divisor),
        card.ability.extra.max
      }
    }
  end,

  add_to_deck = function(self, card, from_debuff)
    local steel_tally = 0
    if G.playing_cards then
      for _, playing_card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(playing_card, 'm_steel') then steel_tally = steel_tally + 1 end
      end
    end
    local hands = math.floor(steel_tally / card.ability.extra.divisor)
    if hands ~= 0 then
      G.hand:change_size(hands)
    end
  end,

  remove_from_deck = function(self, card, from_debuff)
    local steel_tally = 0
    if G.playing_cards then
      for _, playing_card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(playing_card, 'm_steel') then steel_tally = steel_tally + 1 end
      end
    end
    local hands = math.floor(steel_tally / card.ability.extra.divisor)
    if hands ~= 0 then
      G.hand:change_size(-hands)
    end
  end,

  update = function(self, card, dt)
    if G.playing_cards then
      local steel_tally = 0
      for _, playing_card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(playing_card, 'm_steel') then steel_tally = steel_tally + 1 end
      end
      local new_handsize = math.min(math.floor(steel_tally / card.ability.extra.divisor))

      if card.added_to_deck or card.removed or card.modified then
        local change = new_handsize - card.ability.extra.hand_size
        if change ~= 0 then
          G.consumeables:change_size(change)
        end
      end
      card.ability.extra.hand_size = new_handsize

    end
  end,


  in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_steel'`
    for _, playing_card in ipairs(G.playing_cards or {}) do
      if SMODS.has_enhancement(playing_card, 'm_steel') then
        return true
      end
    end
    return false
  end
}
