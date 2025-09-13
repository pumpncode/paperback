PB_UTIL.EGO_Gift {
  key = 'blue_lighter',
  config = {
    sin = 'gloom',
  },
  atlas = 'ego_gift_atlas',
  pos = { x = 4, y = 1 },
  soul_pos = { x = 4, y = 4 },


  ego_gift_calc = function(self, card, context)
    if context.final_scoring_step and (hand_chips * mult > G.GAME.blind.chips) then
      if G.hand.cards[1] then
        local n = pseudorandom('blue_lighter', 1, #G.hand.cards)
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
            G.hand.cards[n]:flip()
            play_sound('card1', 1)
            G.hand.cards[n]:juice_up(0.3, 0.3)
            return true
          end
        }))
        delay(0.2)
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.1,
          func = function()
            assert(copy_card(G.play.cards[1], G.hand.cards[n]))
            return true
          end
        }))
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
            G.hand.cards[n]:flip()
            play_sound('tarot2', 1, 0.6)
            G.hand.cards[n]:juice_up(0.3, 0.3)
            return true
          end
        }))
        return {
          message = localize('paperback_copy_ex')
        }
      end
    end
  end
}
