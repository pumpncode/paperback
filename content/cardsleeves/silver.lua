if PB_UTIL.config.minor_arcana_enabled and PB_UTIL.config.vouchers_enabled then
  CardSleeves.Sleeve {
    key = 'silver',
    atlas = 'card_sleeves_atlas',
    pos = { x = 2, y = 0 },
    config = {
      vouchers = {
        'v_paperback_celtic_cross'
      },
      consumables = {
        'c_paperback_nine_of_cups'
      }
    },

    loc_vars = function(self, info_queue)
      local buffed = self.get_current_deck_key() == 'b_paperback_silver'

      return {
        key = buffed and self.key .. '_buff',
        vars = buffed and {
          localize { type = 'name_text', key = 'v_paperback_soothsay', set = 'Voucher' }
        } or {
          localize { type = 'name_text', key = 'v_paperback_celtic_cross', set = 'Voucher' },
          localize { type = 'name_text', key = 'c_paperback_nine_of_cups', set = 'paperback_minor_arcana' }
        }
      }
    end,

    apply = function(self, sleeve)
      if self.get_current_deck_key() == 'b_paperback_silver' then
        -- A copy of how vouchers are normally applied through the original Sleeve apply function
        G.GAME.used_vouchers.v_paperback_soothsay = true
        G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
        G.E_MANAGER:add_event(Event({
          func = function()
            Card.apply_to_run(nil, G.P_CENTERS.v_paperback_soothsay)
            return true
          end
        }))
      else
        -- Give vouchers and consumables specified in config
        CardSleeves.Sleeve.apply(self, sleeve)
      end
    end
  }
end
