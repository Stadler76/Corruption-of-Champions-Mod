package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Dagger extends Weapon
	{
		public function Dagger(tier:int, degrades:Boolean = false) 
		{
			var ids:Array = ["Dagger ", "Dagger1", "Dagger2", degrades ? "DaggerO" : "Dagger3"];
			var eqptNames:Array = ["dagger", "fine dagger", "masterwork dagger", degrades ? "obsidian dagger" : "epic dagger"];
			var longNames:Array = ["a short dagger", "a fine dagger", "a masterwork dagger", degrades ? "an obsidian-bladed dagger" : "an epic dagger"];
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			this.tier = tier;
			super(ids[tier], "Dagger", eqptNames[tier], longNames[tier], "stab", 3, 150, "A small blade easily held in one hand. Lightweight and easy to conceal, it's the preferred weapon among the stealthy type. Has increased critical chance.", ""); 
		}
		
	}

}