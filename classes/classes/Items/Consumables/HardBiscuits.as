package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	
	/**
	 * Polly wants a cracker?
	 */
	public class HardBiscuits extends Consumable 
	{
		private static const ITEM_VALUE:int = 5;
		
		public function HardBiscuits() 
		{
			super("H.Bisct", "H.Biscuits", "a pack of hard biscuits", ITEM_VALUE, "These biscuits are tasteless, but they can stay edible for an exceedingly long time.");
		}
		
		override public function useItem():Boolean
		{
			outputText("You eat the flavorless biscuits. It satisfies your hunger a bit, but not much else.");
			player.refillHunger(15);
			
			return false;
		}
	}
}
