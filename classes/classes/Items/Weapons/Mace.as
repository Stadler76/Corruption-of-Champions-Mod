package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Mace extends Weapon
	{
		public function Mace(tier:int, degrades:Boolean = false) 
		{
			var ids:Array = ["Mace   ", "Mace  1", "Mace  2", degrades ? "Mace  O" : "Mace  3"];
			var eqptNames:Array = ["mace", "fine mace", "masterwork mace", degrades ? "obsidian-spiked mace" : "epic mace"];
			var longNames:Array = ["a mace", "a fine mace", "a masterwork mace", degrades ? "a mace spiked with obsidian" : "an epic mace"];
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "Mace", eqptNames[tier], longNames[tier], "smash", 9, 100, "This is a mace, designed to be able to crush against various defenses.", ""); 
		}
		
	}

}