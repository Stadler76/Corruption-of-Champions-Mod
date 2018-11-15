package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class FlintlockPistol extends Weapon
	{
		public function FlintlockPistol(tier:int) 
		{
			var ids:Array = ["Flintlk", "Flntlk1", "Flntlk2"];
			var eqptNames:Array = ["flintlock pistol", "fine flintlock pistol", "masterwork flintlock pistol"];
			var longNames:Array = ["a flintlock pistol", "a fine flintlock pistol", "a masterwork flintlock pistol"];
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			this.tier = tier;
			super(ids[tier], "Flintlock", eqptNames[tier], longNames[tier], "shot", 14, 250, "A flintlock pistol. Pew pew pew. Can fire once before a reload is required and Speed has a factor in damage instead of Strength.", Weapon.PERK_RANGED); 
		}
		
	}

}