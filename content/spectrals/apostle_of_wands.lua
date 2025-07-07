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
    PB_UTIL.use_consumable_animation(card, nil, function()
      if #G.jokers.cards < G.jokers.config.card_limit then
        G.SETTINGS.paused = true

        local selectable_jokers = {}

        for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
          if v.rarity ~= 4 and not next(SMODS.find_card(v.key)) then
            selectable_jokers[#selectable_jokers + 1] = v
          end
        end

        G.FUNCS.overlay_menu {
          config = { no_esc = true },
          definition = PB_UTIL.apostle_of_wands_collection_UIBox(
            selectable_jokers,
            { 5, 5, 5 },
            {
              no_materialize = true,
              modify_card = function(other_card, center)
                other_card.sticker = get_joker_win_sticker(center)
                PB_UTIL.create_select_card_ui(other_card, G.jokers)
              end,
              h_mod = 1.05,
            }
          ),
        }
      end
    end)
  end
}
