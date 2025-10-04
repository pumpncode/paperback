SMODS.Voucher {
  key = 'second_trumpet',
  config = {
    a_slot = 1,
    active = false
  },
  atlas = 'vouchers_atlas',
  pos = { x = 2, y = 0 },
  unlocked = true,
  discovered = false,
  paperback = {
    requires_ego_gifts = true,
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.a_slot or self.config.a_slot
      }
    }
  end,

  update = function(self, card, dt)
    if G.consumeables then
      local found_gift = false
      for _, v in ipairs(G.consumeables.cards) do
        if PB_UTIL.is_ego_gift(v) then found_gift = true end
      end

      if card.ability.active and not found_gift then
        G.consumeables:change_size(-card.ability.a_slot)
        card.ability.active = false
      else
        if found_gift and not card.ability.active then
          G.consumeables:change_size(card.ability.a_slot)
          card.ability.active = true
        end
      end
    end
  end
}
