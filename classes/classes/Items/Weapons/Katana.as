package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Katana extends Weapon
	{
		public function Katana(tier:int) 
		{
			var ids:Array = ["Katana ", "Katana1", "Katana2"];
			var eqptNames:Array = ["katana", "fine katana", "masterwork katana"];
			var longNames:Array = ["a katana", "a fine katana", "a masterwork katana"];
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "Katana", eqptNames[tier], longNames[tier], "keen cut", 10, 500, "A curved bladed weapon that cuts through flesh with the greatest of ease.", ""); 
		}
		
	}

}