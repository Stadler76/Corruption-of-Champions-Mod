package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Whip extends Weapon
	{
		public function Whip(tier:int) 
		{
			var ids:Array = ["Whip   ", "Whip  1", "Whip  2"];
			var eqptNames:Array = ["coiled whip", "fine coiled whip", "masterwork coiled whip"];
			var longNames:Array = ["a coiled whip", "a fine coiled whip", "a masterwork coiled whip"];
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			this.tier = tier;
			super(ids[tier], "Whip", eqptNames[tier], longNames[tier], "whip-crack", 5, 500, "A coiled length of leather designed to lash your foes into submission. There's a chance the bondage inclined might enjoy it!", ""); 
		}
		
	}

}