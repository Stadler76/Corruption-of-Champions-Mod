package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Scimitar extends Weapon
	{
		public function Scimitar(tier:int) 
		{
			var ids:Array = ["Scimitr", "Scimtr1", "Scimtr2"];
			var eqptNames:Array = ["scimitar", "fine scimitar", "masterwork scimitar"];
			var longNames:Array = ["a scimitar", "a fine scimitar", "a masterwork scimitar"];
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "Scimitar", eqptNames[tier], longNames[tier], "slash", 13, 500, "A vicious curved sword made for slashing. No doubt it'll easily cut through flesh.", ""); 
		}
		
	}

}