package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Blunderbuss extends Weapon
	{
		public function Blunderbuss(tier:int) 
		{
			var ids:Array = ["Blunder", "Blundr1", "Blundr2"];
			var eqptNames:Array = ["blunderbuss", "fine blunderbuss", "masterwork blunderbuss"];
			var longNames:Array = ["a blunderbuss", "a fine blunderbuss", "a masterwork blunderbuss"];
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "Blndrbss", eqptNames[tier], longNames[tier], "shot", 16, 600, "This is a blunderbuss, a two-handed gun. It's effective at short range but poor at long range. Reload is required after each shot. Speed has factor in damage rather than Strength.", Weapon.PERK_RANGED); 
		}
		
	}

}