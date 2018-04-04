/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;

	public class LargeHammer extends Weapon 
	{
		public function LargeHammer(tier:int, degrades:Boolean = false) 
		{
			var ids:Array = ["L.Hammr", "L.Hamr1", "L.Hamr2", degrades ? "L.HamrO" : "L.Hamr3"];
			var eqptNames:Array = ["large hammer", "fine large hammer", "masterwork large hammer", degrades ? "obsidian-spiked large hammer" : "epic large hammer"];
			var longNames:Array = ["Marble's large hammer", "a fine, large hammer", "a masterwork, large hammer", degrades ? "an obsidian-spiked large hammer" : "an epic, large hammer"];
			this.weightCategory = Weapon.WEIGHT_HEAVY;
			this.tier = tier;
			super(ids[tier], "L.Hammer", eqptNames[tier], longNames[tier], "smash", 16, 90, "This two-handed warhammer looks pretty devastating. You took it from Marble after she refused your advances.", Weapon.PERK_LARGE); 
		}
		
		override public function canUse():Boolean {
			if (game.player.tallness >= 60) return true;
			outputText("This hammer is too large for you to wield effectively. ");
			return false;
		}
		
	}
}
