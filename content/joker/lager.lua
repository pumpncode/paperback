SMODS.Joker {
  key = "lager",
  config = {
    extra = {
      a_slots = 1,
      slots = 1,
      suit = "paperback_Crowns",
      req = 5,
    }
  },
  rarity = 3,
  pos = { x = 24, y = 2 },
  atlas = "jokers_atlas",
  cost = 9,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = false,
  soul_pos = nil,
  pools = {
    Food = true
  },
  paperback = {
    requires_crowns = true,
    suit_drink = true,

  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.slots,
        card.ability.extra.a_slots,
        card.ability.extra.req,
        card.ability.extra.suit,
      }
    }
  end,
  calculate = function(self, card, context)
    if context.before and not context.blueprint and PB_UTIL.suit_drink_logic(card, context, true) then
      return PB_UTIL.suit_drink_logic(card, context, false)
    end

    if context.before and not context.blueprint then
      local crowns = 0
      for _, c in ipairs(context.scoring_hand) do
        if c:is_suit(card.ability.extra.suit) then
          crowns = crowns + 1
        end
      end
      if crowns >= card.ability.extra.req then
        card.ability.extra.slots = card.ability.extra.slots + card.ability.extra.a_slots
        G.consumeables:change_size(card.ability.extra.a_slots)
        return {
          message = localize {
            type = 'variable',
            key = 'paperback_a_plus_consumable_slot',
            colour = G.C.SUITS[card.ability.extra.suit],
            vars = { card.ability.extra.slots }
          }
        }
      end
    end
  end,

  add_to_deck = function(self, card, from_debuff)
    G.consumeables:change_size(card.ability.extra.slots)
  end,

  remove_from_deck = function(self, card, from_debuff)
    G.consumeables:change_size(-card.ability.extra.slots)
  end,
}
