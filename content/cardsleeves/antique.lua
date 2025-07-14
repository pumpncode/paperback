if PB_UTIL.config.minor_arcana_enabled then
  CardSleeves.Sleeve {
    key = 'antique',
    atlas = 'card_sleeves_atlas',
    pos = { x = 4, y = 0 },

    loc_vars = function(self, info_queue, card)
      return {
        key = self.get_current_deck_key() == 'b_paperback_antique' and (self.key .. '_buff')
      }
    end,

    calculate = function(self, sleeve, context)
      if self.get_current_deck_key() == 'b_paperback_antique' and (context.starting_shop or context.reroll_shop) then
        for _, v in ipairs(G.shop_booster.cards or {}) do
          if v.config.center.kind == 'paperback_minor_arcana' then
            v.ability.couponed = true
            v:set_cost()
          end
        end
      end
    end
  }
end
