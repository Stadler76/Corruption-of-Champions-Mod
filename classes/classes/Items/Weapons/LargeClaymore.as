/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;

	public class LargeClaymore extends Weapon 
	{
		public function LargeClaymore(tier:int) 
		{
			var ids:Array = ["Claymor", "Claymr1", "Claymr2"];
			var eqptNames:Array = ["large claymore", "fine claymore", "masterwork claymore"];
			var longNames:Array = ["a large claymore", "a fine claymore", "a masterwork claymore"];
			this.weightCategory = Weapon.WEIGHT_HEAVY;
			this.tier = tier;
			super(ids[tier], "L.Claymore", eqptNames[tier], longNames[tier], "cleaving sword-slash", 15, 1000, "A massive sword that a very strong warrior might use. Requires 40 strength to use.", Weapon.PERK_LARGE); 
		}
		
		override public function canUse():Boolean {
			if (game.player.str >= 40) return true;
			outputText("You aren't strong enough to handle such a heavy weapon! ");
			return false;
		}
		
	}
}
