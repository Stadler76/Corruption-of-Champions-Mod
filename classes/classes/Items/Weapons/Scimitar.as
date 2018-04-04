package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Scimitar extends Weapon
	{
		public function Scimitar(tier:int, degrades:Boolean = false) 
		{
			var ids:Array = ["Scimitr", "Scimtr1", "Scimtr2", degrades ? "ScimtrO" : "Scimitr3"];
			var eqptNames:Array = ["scimitar", "fine scimitar", "masterwork scimitar", degrades ? "obsidian-bladed scimitar" : "epic scimitar"];
			var longNames:Array = ["a scimitar", "a fine scimitar", "a masterwork scimitar", degrades ? "a scimitar lined with obsidian" : "an epic scimitar"];
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "Scimitar", eqptNames[tier], longNames[tier], "slash", 13, 500, "A vicious curved sword made for slashing. No doubt it'll easily cut through flesh.", ""); 
		}
		
	}

}