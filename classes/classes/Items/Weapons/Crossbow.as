package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Crossbow extends Weapon
	{
		public function Crossbow(tier:int) 
		{
			var ids:Array = ["Crossbw", "Crsbow1", "Crsbow2"];
			var eqptNames:Array = ["crossbow", "fine crossbow", "masterwork crossbow"];
			var longNames:Array = ["a crossbow", "a fine crossbow", "a masterwork crossbow"];
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "Crossbow", eqptNames[tier], longNames[tier], "shot", 11, 200, "This weapon fires bolts at your enemies with the pull of a lever. Speed has factor in damage rather than Strength.", Weapon.PERK_RANGED); 
		}
		
	}

}