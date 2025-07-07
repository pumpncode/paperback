SMODS.Consumable {
  key = 'apostle_of_wands',
  config = {
    extra = {
      delta = -1
    }
  },
  set = "Spectral",
  atlas = 'spectral_atlas',
  pos = { x = 0, y = 0 },

  hidden = true,
  soul_set = "paperback_minor_arcana",
  soul_rate = 0.001,

  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.delta }
    }
  end,

  can_use = function(self, card)
    return #G.jokers.cards < G.jokers.config.card_limit
  end,

  use = function(self, card, area, copier)
    local other_card = G.hand.highlighted[1]

    PB_UTIL.use_consumable_animation(card, nil, function()
      if #G.jokers.cards < G.jokers.config.card_limit then
        G.SETTINGS.paused = true
        G.FUNCS.overlay_menu {
          config = { no_esc = true },
          definition = SMODS.jest_no_back_card_collection_UIBox(
            G.P_CENTER_POOLS.Joker,
            { 5, 5, 5 },
            {
              no_materialize = true,
              modify_card = function(card, center)
                card.sticker = get_joker_win_sticker(center)
                local owned_jokers = {}
                local owned = false
                for k, v in ipairs(G.jokers.cards) do
                  table.insert(owned_jokers, v.config.center.key)
                end
                if card.config.center.discovered and card.config.center.rarity ~= 4 then
                  for k, v in ipairs(owned_jokers) do
                    if card.config.center.key == v then
                      owned = true
                    end
                  end
                  if not owned then jest_create_select_card_ui(card, G.jokers) end
                end
              end,
              h_mod = 1.05,
            }
          ),
        }
      end
    end)
  end
}
