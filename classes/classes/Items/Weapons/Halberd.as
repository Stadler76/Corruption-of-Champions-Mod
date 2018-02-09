package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Halberd extends Weapon
	{
		
		public function Halberd(tier:int) 
		{
			var ids:Array = ["Halberd", "Halbrd1", "Halbrd2"];
			var eqptNames:Array = ["halberd", "fine halberd", "masterwork halberd"];
			var longNames:Array = ["a halberd", "a fine halberd", "a masterwork halberd"];
			this.weightCategory = Weapon.WEIGHT_HEAVY;
			this.tier = tier;
			super(ids[tier], "Halberd", eqptNames[tier], longNames[tier], "slash", 11, 750, "A curved bladed weapon that cuts through flesh with the greatest of ease.", Weapon.PERK_LARGE); 
		}
		
	}

}