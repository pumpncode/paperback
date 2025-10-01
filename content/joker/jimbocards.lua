SMODS.Joker {
  key = "jimbocards",
  config = {
    extra = {
      num_to_gen = 7,
      hands_to_death = 3,
      hands_reset = 3,
    }
  },
  rarity = 1,
  pos = { x = 8, y = 7 },
  atlas = "jokers_atlas",
  cost = 13,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,

  add_to_deck = function(self, card, from_debuff)
    -- Destroy all Jokers currently in possession (not itself)
    G.E_MANAGER:add_event(Event {
      trigger = 'immediate',
      func = function()
        for _, v in ipairs(G.jokers.cards) do
          if v ~= card then
            PB_UTIL.destroy_joker(v)
          end
        end
        return true
      end,
    })

    -- Generate the random negative Jokers
    G.E_MANAGER:add_event(Event {
      trigger = 'immediate',
      func = function()
        for i = 1, card.ability.extra.num_to_gen do
          SMODS.add_card({
            set = 'Joker',
            area = G.jokers,
            edition = 'e_negative',
            key_append = '_jimbocards',
          })
        end
        return true
      end,
    })
  end,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {

      }
    }
  end,

  calculate = function(self, card, context)

  end
}
