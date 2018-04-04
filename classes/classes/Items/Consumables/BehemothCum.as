package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	
	public class BehemothCum extends Consumable 
	{
		private static const ITEM_VALUE:int = 15;
		
		public function BehemothCum() 
		{
			super("BhmtCum", "BhmtCum", "a sealed bottle of behemoth cum", ITEM_VALUE, "This bottle of behemoth cum looks thick and viscous.  You suspect that it might boost your strength and toughness.  It also has delicious taste.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You uncork the bottle and drink the behemoth cum; it tastes great and by the time you've finished drinking, you feel a bit stronger. ");
			dynStats("str", 0.5, "tou", 0.5, "lus", 5 + (player.cor / 5));
			player.HPChange(Math.round(player.maxHP() * .25), true);
			player.slimeFeed();
			player.refillHunger(25);
			player.orgasm('Lips',false);
			
			return false;
		}
		
		override public function getMaxStackSize():int {
			return 5;
		}
	}
}
