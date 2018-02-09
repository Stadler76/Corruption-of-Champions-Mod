package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class KihasAxe extends Weapon
	{
		
		public function KihasAxe() 
		{
			this.weightCategory = Weapon.WEIGHT_HEAVY;
			super("KihaAxe", "Greataxe", "fiery double-bladed axe", "a fiery double-bladed axe", "fiery cleave", 20, 1000, "This large, double-bladed axe matches Kiha's axe. It's constantly flaming.", Weapon.PERK_LARGE);
		}
		
	}

}