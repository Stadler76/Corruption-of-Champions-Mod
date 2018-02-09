package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Dagger extends Weapon
	{
		public function Dagger(tier:int) 
		{
			var ids:Array = ["Dagger ", "Dagger1", "Dagger2"];
			var eqptNames:Array = ["dagger", "fine dagger", "masterwork dagger"];
			var longNames:Array = ["a short dagger", "a fine dagger", "a masterwork dagger"];
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			this.tier = tier;
			super(ids[tier], "Dagger", eqptNames[tier], longNames[tier], "stab", 3, 150, "A small blade easily held in one hand. Lightweight and easy to conceal, it's the preferred weapon among the stealthy type. Has increased critical chance.", ""); 
		}
		
	}

}