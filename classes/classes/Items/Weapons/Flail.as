package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class Flail extends Weapon
	{
		public function Flail(tier:int) 
		{
			var ids:Array = ["Flail  ", "Flail 1", "Flail 2"];
			var eqptNames:Array = ["flail", "fine flail", "masterwork flail"];
			var longNames:Array = ["a flail", "a fine flail", "a masterwork flail"];
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "Flail", eqptNames[tier], longNames[tier], "smash", 10, 200, "This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself if you don't pay attention to the spiked ball.", ""); 
		}
		
	}

}