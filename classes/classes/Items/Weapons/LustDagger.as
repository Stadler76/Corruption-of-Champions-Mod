package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class LustDagger extends Weapon
	{
		public function LustDagger(tier:int) 
		{
			var ids:Array = ["L.Daggr", "L.Dagr1", "L.Dagr2"];
			var eqptNames:Array = ["lust-enchanted dagger", "fine lust-enchanted dagger", "masterwork lust-enchanted dagger"];
			var longNames:Array = ["an aphrodisiac-coated dagger", "a fine aphrodisiac-coated dagger", "a masterwork aphrodisiac-coated dagger"];
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			this.tier = tier;
			super(ids[tier], "L.Dagger", eqptNames[tier], longNames[tier], "stab", 3, 40, "A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", Weapon.PERK_APHRODISIAC); 
		}
		
	}

}