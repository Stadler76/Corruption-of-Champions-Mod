package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class RidingCrop extends Weapon
	{
		public function RidingCrop(tier:int) 
		{
			var ids:Array = ["RidingC", "Riding1", "Riding2"];
			var eqptNames:Array = ["riding crop", "fine riding crop", "masterwork riding crop"];
			var longNames:Array = ["a riding crop", "a fine riding crop", "a masterwork riding crop"];
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			this.tier = tier;
			super(ids[tier], "RidingC", eqptNames[tier], longNames[tier], "whip-crack", 5, 50, "This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.", ""); 
		}
		
	}

}