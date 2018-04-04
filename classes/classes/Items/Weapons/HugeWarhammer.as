/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;

	public class HugeWarhammer extends Weapon 
	{	
		public function HugeWarhammer(tier:int, degrades:Boolean = false) 
		{
			var ids:Array = ["Warhamr", "Warham1", "Warham2", degrades ? "WarhamO" : "Warham3"];
			var eqptNames:Array = ["huge warhammer", "fine warhammer", "masterwork warhammer", degrades ? "obsidian-spiked warhammer" : "epic warhammer"];
			var longNames:Array = ["a huge warhammer", "a fine, huge warhammer", "a masterwork, huge warhammer", degrades ? "an obsidian-spiked, huge warhammer" : "an epic, huge warhammer"];
			this.weightCategory = Weapon.WEIGHT_HEAVY;
			this.tier = tier;
			super(ids[tier], "Warhammer", eqptNames[tier], longNames[tier], "smash", 15, 1600, "A huge war-hammer made almost entirely of steel that only the strongest warriors could use. Requires 80 strength to use. Getting hit with this might stun the victim.", Weapon.PERK_LARGE); 
		}
		
		override public function canUse():Boolean {
			if (game.player.str >= 80) return true;
			outputText("You aren't strong enough to handle such a heavy weapon!  ");
			return false;
		}
		
	}
}
