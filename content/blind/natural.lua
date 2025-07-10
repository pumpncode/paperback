SMODS.Blind {
  key = 'natural',
  boss = {
    min = 2,
  },
  mult = 1,
  boss_colour = HEX('926fcd'),
  atlas = 'music_blinds_atlas',
  pos = { y = 2 },

  calculate = function(self, blind, context)
    if context.before and not blind.disabled then
      local min = math.huge
      for i, v in pairs(G.GAME.hands) do
        min = min < v.level and min or v.level
      end
      if G.GAME.hands[context.scoring_name].level > to_big(min) then
        for k, v in pairs(context.scoring_hand) do
          v:set_debuff(true)
          v.debuffed_by_blind = true
        end
      end
    end
  end
}
