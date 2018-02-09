package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.Items.Shields.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class ShieldLib 
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		//Regular Shields
		public const WOODSHL:Shield = new WoodenShield();
		
		public const BUCKLR0:Shield = new Buckler(0);
		public const BUCKLR1:Shield = new Buckler(1);
		public const BUCKLR2:Shield = new Buckler(2);
		
		public const GRTSHL0:Shield = new GreatShield(0);
		public const GRTSHL1:Shield = new GreatShield(1);
		public const GRTSHL2:Shield = new GreatShield(2);
		
		public const KITESH0:Shield = new KiteShield(0);
		public const KITESH1:Shield = new KiteShield(1);
		public const KITESH2:Shield = new KiteShield(2);
		
		public const TOWRSH0:Shield = new TowerShield(0);
		public const TOWRSH1:Shield = new TowerShield(1);
		public const TOWRSH2:Shield = new TowerShield(2);
		
		//Special Shields
		public const DRGNSHL:Shield = new DragonShellShield(false);
		public const RUNESHL:Shield = new DragonShellShield(true);

		public function ShieldLib() {}
	}

}
