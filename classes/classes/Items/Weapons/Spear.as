package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Spear extends Weapon
	{
		public function Spear(tier:int, degrades:Boolean = false) 
		{
			var ids:Array = ["Spear  ", "Spear 1", "Spear 2", degrades ? "Spear O" : "Spear 3"];
			var eqptNames:Array = ["deadly spear", "fine spear", "masterwork spear", degrades ? "obsidian-tipped spear" : "epic spear"];
			var longNames:Array = ["a deadly spear", "a fine, deadlier spear", "a masterwork, even deadlier spear", degrades ? "an obsidian-tipped spear" : "an epic, deadliest spear"];
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "Spear", eqptNames[tier], longNames[tier], "piercing stab", 8, 450, "A staff with a sharp blade at the tip designed to pierce through the toughest armor. This would ignore most armors.", ""); 
		}
		
	}

}