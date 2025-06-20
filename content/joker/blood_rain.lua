SMODS.Joker {
  key = "blood_rain",
  rarity = 3,
  pos = { x = 17, y = 6 },
  atlas = "jokers_atlas",
  cost = 8,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  paperback = {
    requires_enhancements = true
  },

  in_pool = function(self, args)
    for _, v in ipairs(G.playing_cards or {}) do
      if SMODS.has_enhancement(v, 'm_paperback_soaked') then
        return true
      end
    end
  end,

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_paperback_soaked

    return {
      vars = {
        localize {
          type = 'name_text',
          set = "Enhanced",
          key = 'm_paperback_soaked'
        }
      }
    }
  end
}
