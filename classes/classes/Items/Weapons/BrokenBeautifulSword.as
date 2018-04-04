package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class BrokenBeautifulSword extends Weapon
	{
		
		public function BrokenBeautifulSword() 
		{
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			this.tier = 0;
			super("B.BSwrd", "B.B Sword", "broken beautiful sword", "a broken beautiful sword", "slash", 10, 500, "This sword was once a prime example of craftsmanship, now broken and no longer shining. The still-intact pommel and guard are heavily decorated in gold and brass. Some craftsman clearly poured his heart and soul into this blade. There might still be hope for this sword.");
		}
		
	}

}