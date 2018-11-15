package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	
	public class HookedGauntlet extends Weapon
	{
		public function HookedGauntlet(tier:int, degrades:Boolean = false)
		{
			var ids:Array = ["H.Gaunt", "H.Gaun1", "H.Gaunt2", degrades ? "H.GaunO" : "H.Gaunt3"];
			var eqptNames:Array = ["hooked gauntlets", "fine hooked gauntlets", "masterwork hooked gauntlets", degrades ? "obsidian-hooked gauntlets" : "epic hooked gauntlets"];
			var longNames:Array = ["a set of hooked gauntlets", "a set of fine hooked gauntlets", "a set of masterwork gauntlets", degrades ? "a set of obsidian-hooked gauntlets" : "a set of epic hooked gauntlets"];
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			this.tier = tier;
			super(ids[tier], "H.Gaunt", eqptNames[tier], longNames[tier], "clawing punch", 8, 400, "These metal gauntlets are fitted with bone spikes and hooks shaped like shark teeth that are sure to tear at your foes flesh and cause them harm.", ""); 
		}
		
		override public function get attack():Number {
			var amt:Number = _attack + (_tier * 2);
			if (game.player.hasPerk(PerkLib.IronFists)) amt += 2;
			if (game.player.hasPerk(PerkLib.IronFists2)) amt += 1;
			if (game.player.hasPerk(PerkLib.IronFists3)) amt += 1;
			return amt;
		}
		
	}

}