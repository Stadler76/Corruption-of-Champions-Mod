package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	
	public class UrtaCum extends Consumable 
	{
		private static const ITEM_VALUE:int = 15;
		
		public function UrtaCum() 
		{
			super("UrtaCum", "UrtaCum", "a sealed bottle of Urta's cum", ITEM_VALUE, "This bottle of Urta's cum looks thick and viscous.  It's quite delicious.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You uncork the bottle and drink the vulpine cum; it tastes great. Urta definitely produces good-tasting cum!");
			dynStats("sens", 1, "lus", 5 + (player.cor / 5));
			player.HPChange(Math.round(player.maxHP() * .25), true);
			player.slimeFeed();
			player.refillHunger(25);
			player.orgasm('Lips',false);
			
			return false;
		}
	}
}
