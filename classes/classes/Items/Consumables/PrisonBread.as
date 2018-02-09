package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	public class PrisonBread extends Consumable 
	{
		
		public function PrisonBread() {
			super("P.Bread", "P.Bread", "a stale loaf of prison bread", ConsumableLib.DEFAULT_VALUE, "An impossibly hard loaf of stale bread.  Despite its age, still quite nutritious.");
		}
		
		override public function canUse():Boolean {
			return true;
		}
		
		override public function useItem():Boolean {
			game.prison.prisonItemBread(false);
			return true;
		}
		
	}

}