SMODS.Blind {
  key = 'sharp',
  boss = {
    min = 1,
  },
  boss_colour = HEX('5D5EA3'),
  atlas = 'music_blinds_atlas',
  pos = { y = 3 },

  calculate = function(self, blind, context)
    if context.after then
      PB_UTIL.use_consumable_animation(nil, context.full_hand, function()
        for k, v in pairs(context.full_hand) do
          assert(SMODS.modify_rank(v, 1))
        end
      end)
    end
  end
}
