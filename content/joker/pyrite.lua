SMODS.Joker {
  key = 'pyrite',
  config = {
    extra = {
      min_money = -1,
      max_money = 3
    }
  },
  rarity = 2,
  pos = { x = 2, y = 9 },
  atlas = 'jokers_atlas',
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  paperback = {
    requires_crowns = true
  },
  unlocked = false,

  check_for_unlock = function(self, args)
    if args.type == 'modify_deck' then
      local crowns = 0

      for _, v in ipairs(G.playing_cards) do
        if v:is_suit('paperback_Crowns') then
          crowns = crowns + 1
        end
      end

      return crowns >= 20
    end
  end,

  locked_loc_vars = function(self, info_queue, card)
    return {
      vars = { 20 }
    }
  end,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.min_money,
        card.ability.extra.max_money
      }
    }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit('paperback_Crowns') then
        local dollars = pseudorandom("pyrite", card.ability.extra.min_money, card.ability.extra.max_money)

        if dollars ~= 0 then
          return {
            dollars = dollars
          }
        end
      end
    end
  end
}
