SMODS.Joker {
  key = 'ready_to_fly',
  rarity = 1,
  pos = { x = 16, y = 0 },
  atlas = 'jokers_atlas',
  cost = 6,
  config = { extra = { xchips = 1, scaling = 0.05, left = nil, right = nil } },
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  soul_pos = nil,
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.xchips,
        card.ability.extra.scaling
      }
    }
  end,

  update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
          if i > 1 then
            card.ability.extra.left = G.jokers.cards[i - 1]
          else
            card.ability.extra.left = nil
          end
          if i <= #G.jokers.cards then
            card.ability.extra.right = G.jokers.cards[i + 1]
          else
            card.ability.extra.right = nil
          end
        end
      end
    end
  end,

  calculate = function(self, card, context)
    if context.post_trigger then
      if (card.ability.extra.left and context.other_card == card.ability.extra.left) or (card.ability.extra.right and context.other_card == card.ability.extra.right) then
        card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.scaling
        return {
          message = localize('k_upgrade_ex'),
          message_card = card
        }
      end
    end

    if context.joker_main then
      return {
        xchips = card.ability.extra.xchips
      }
    end
  end
}
