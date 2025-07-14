if PB_UTIL.config.suits_enabled then
  CardSleeves.Sleeve {
    key = 'proud',
    atlas = 'card_sleeves_atlas',
    pos = { x = 1, y = 0 },
    paperback = {
      create_crowns = true,
      create_stars = true
    },

    loc_vars = function(self, info_queue, card)
      return {
        key = self.get_current_deck_key() == 'b_paperback_proud' and self.key .. '_buff'
      }
    end,

    apply = function(self, sleeve)
      if self.get_current_deck_key() == 'b_paperback_proud' then
        G.E_MANAGER:add_event(Event {
          func = function()
            for _, v in ipairs(G.playing_cards or {}) do
              if v:get_id() == 14 then
                v:set_edition('e_polychrome', true, true)
              end
            end
            return true
          end
        })
      end
    end
  }
end
