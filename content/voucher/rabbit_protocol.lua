SMODS.Voucher {
  key = 'rabbit_protocol',
  config = {
    triggered = false
  },
  atlas = 'vouchers_atlas',
  pos = { x = 2, y = 1 },
  unlocked = false,
  discovered = false,
  requires = {
    'v_paperback_second_trumpet'
  },
  paperback = {
    requires_ego_gifts = true,
  },
  locked_loc_vars = function(self, info_queue)
    return { vars = { 3 } }
  end,

  check_for_unlock = function(self, args)
    if args.type == 'paperback_sold_ego_gifts' then
      return #G.GAME.paperback.sold_ego_gifts >= 3
    end
  end,

  calculate = function(self, card, context)
    if context.selling_card and G.GAME.blind then
      if PB_UTIL.is_ego_gift(context.card) and G.GAME.blind.boss and not card.ability.triggered then
        return {
          focus = context.card,
          message = localize('ph_boss_disabled'),
          func = function()
            G.GAME.blind:disable()
            card.ability.triggered = true
          end
        }
      end
    end
    if context.end_of_round and G.GAME.blind.boss then
      card.ability.triggered = false
    end
  end
}
