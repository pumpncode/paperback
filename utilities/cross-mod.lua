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

    -- Return 0 if the card is debuffed (calculate_card_triggers returns 0)
    if triggers == 0 then
      return 0
    end

    -- If card has a black paperclip
    if PB_UTIL.has_paperclip(card) and card.ability.paperback_black_clip then
      -- Loop through scoring_hand and look for other clips
      for k, v in pairs(scoring_hand) do
        -- Only look for a clip on this card if it is not the scoring card
        if v ~= card then
          -- If it has a paperclip, add a trigger
          if PB_UTIL.has_paperclip(v) then
            triggers = triggers + 1
            break
          end
        end
      end

      -- Loop through cards held in hand and check for paperclips
      if G.hand and G.hand.cards then
        -- Loop through G.hand.cards
        for k, v in pairs(G.hand.cards) do
          local valid_card = true
          -- Loop through scoring_hand and make sure the current card is not in the scoring_hand
          for l, w in pairs(scoring_hand) do
            if w == v then
              valid_card = false
              break
            end
          end

          -- If it is held in hand, check if it has a paperclip and add a trigger
          if valid_card then
            if PB_UTIL.has_paperclip(v) then
              triggers = triggers + 1
              break
            end
          end
        end
      end
    end

    return triggers
  end
end
