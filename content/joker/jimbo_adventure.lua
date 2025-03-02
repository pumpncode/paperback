SMODS.Joker {
  key = "jimbo_adventure",
  rarity = 1,
  pos = { x = 1, y = 5 },
  atlas = 'jokers_atlas',
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  soul_pos = { x = 2, y = 5 },
  unlocked = false,

  check_for_unlock = function(self, args)
    if args.tag_added then
      return #G.GAME.tags >= 4
    end
  end,

  locked_loc_vars = function(self, info_queue, card)
    return {
      vars = { 4 }
    }
  end,

  calculate = function(self, card, context)
    if context.skip_blind then
      PB_UTIL.add_tag(PB_UTIL.poll_tag("jimbo_adventure"))
    end
  end,
}
