if PB_UTIL.config.spectrals_enabled and PB_UTIL.config.ranks_enabled then
  CardSleeves.Sleeve {
    key = 'dreamer',
    atlas = 'card_sleeves_atlas',
    pos = { x = 3, y = 0 },
    config = {
      joker_slot = -1,
      consumables = {
        'c_paperback_apostle_of_wands'
      }
    },

    loc_vars = function(self)
      local buffed = self.get_current_deck_key() == 'b_paperback_dreamer'

      return {
        key = buffed and self.key .. '_buff',
        vars = buffed and {
          localize('paperback_Apostle', 'ranks')
        } or {
          localize { type = 'name_text', key = 'c_paperback_apostle_of_wands', set = 'Spectral' },
          self.config.joker_slot
        }
      }
    end,

    apply = function(self, sleeve)
      -- Apply config only when not buffed
      if self.get_current_deck_key() ~= 'b_paperback_dreamer' then
        CardSleeves.Sleeve.apply(self, sleeve)
        -- Call apply function from dreamer deck
        SMODS.Back.obj_table.b_paperback_dreamer.apply(self)
      end

      -- Buffed effect happens within the Apostle's rank in_pool function
    end
  }
end
