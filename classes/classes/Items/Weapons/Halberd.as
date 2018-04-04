package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Halberd extends Weapon
	{
		
		public function Halberd(tier:int, degrades:Boolean = false) 
		{
			var ids:Array = ["Halberd", "Halbrd1", "Halbrd2", degrades ? "HalbrdO" : "Halbrd3"];
			var eqptNames:Array = ["halberd", "fine halberd", "masterwork halberd", degrades ? "obsidian-bladed halberd" : "epic halberd"];
			var longNames:Array = ["a halberd", "a fine halberd", "a masterwork halberd", degrades ? "an obsidian-bladed halberd" : "an epic halberd"];
			this.weightCategory = Weapon.WEIGHT_HEAVY;
			this.tier = tier;
			super(ids[tier], "Halberd", eqptNames[tier], longNames[tier], "slash", 11, 750, "Resembling a spear with a blade at the end, it's a long-reach melee weapon that can hit from a reasonable distance.", Weapon.PERK_LARGE); 
		}
		
	}

}