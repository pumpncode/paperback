if PB_UTIL.config.ego_gifts_enabled then
  SMODS.Back {
    key = 'glimmer',
    atlas = 'decks_atlas',
    config = {
      joker_slot = -2,
      extra = {
        a_slot = 1,
      }
    },
    pos = { x = 6, y = 0 },

    locked_loc_vars = function(self, info_queue)
      return { vars = { 10 } }
    end,

    loc_vars = function(self)
      return {
        vars = {
          self.config.extra.a_slot,
          self.config.joker_slot,
        }
      }
    end,
    check_for_unlock = function(self, args)
      if args.type == 'paperback_sold_ego_gifts' then
        return #G.GAME.paperback.sold_ego_gifts >= 10
      end
    end,
    --[[
    calculate = function(self, back, context)
      if context.card_added or context.selling_card or (context.paperback and context.paperback.destroying_non_playing_card) then
        local sins = {}
        local count = 0
        local cards = G.consumeables.cards
        if context.card_added then cards[#cards + 1] = context.card end
        for _, v in ipairs(cards) do
          if v.ability.sin then
            if not sins[v.ability.sin] then
              sins[v.ability.sin] = true
              count = count + 1
            end
          end
        end


        local change = count - G.GAME.paperback.glimmer_change
        if change ~= 0 then
          G.consumeables:change_size(change)

          G.GAME.paperback.glimmer_change = count
        end
      end
    end
    ]]
  }
end
