-- Talisman compatibility
to_big = to_big or function(n)
  return n
end

to_number = to_number or function(n)
  return n
end

-- Load modded suits
if (SMODS.Mods["Bunco"] or {}).can_load then
  local prefix = SMODS.Mods["Bunco"].prefix

  table.insert(PB_UTIL.light_suits, prefix .. '_Fleurons')
  table.insert(PB_UTIL.dark_suits, prefix .. '_Halberds')
end

if JokerDisplay then
  local calculate_card_triggers_ref = JokerDisplay.calculate_card_triggers
  JokerDisplay.calculate_card_triggers = function(card, scoring_hand, held_in_hand)
    local triggers = calculate_card_triggers_ref(card, scoring_hand, held_in_hand)

    -- Return 0 if the card is debuffed
    if triggers == 0 then
      return 0
    end

    -- If card has a black paperclip
    if PB_UTIL.has_paperclip(card) and card.ability.paperback_black_clip then
      -- Store the scoring_hand for quick lookup
      local scoring_hand_set = {}
      for _, v in pairs(scoring_hand) do
        scoring_hand_set[v] = true
      end

      -- Check for paperclips in scoring_hand (excluding current card)
      for k, v in pairs(scoring_hand) do
        if v ~= card and PB_UTIL.has_paperclip(v) then
          triggers = triggers + 1
          break -- Stop after finding one
        end
      end

      -- Check for paperclips held in hand (without iterating over scoring_hand again)
      if G.hand and G.hand.cards then
        for _, v in pairs(G.hand.cards) do
          if not scoring_hand_set[v] and PB_UTIL.has_paperclip(card) then
            triggers = triggers + 1
            break -- Stop after finding one
          end
        end
      end
    end

    return triggers
  end
end
