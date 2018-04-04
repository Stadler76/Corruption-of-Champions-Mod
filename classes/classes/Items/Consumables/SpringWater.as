package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	public class SpringWater extends Consumable 
	{
		public function SpringWater() 
		{
			super("S.Water", "SpringWtr", "a waterskin filled with spring water", ConsumableLib.DEFAULT_VALUE, "A waterskin full of purified water from Minerva's spring.  It's clean and clear, with a faint sweet scent to it.  You're sure it would be a very refreshing drink.");
		}
		
		override public function useItem():Boolean
		{
			player.slimeFeed();
			clearOutput();
			outputText("The water is cool and sweet to the taste, and every swallow makes you feel calmer, cleaner, and refreshed.  You drink until your thirst is quenched, feeling purer in both mind and body. ");
			//-30 fatigue, -2 libido, -10 lust]
			player.changeFatigue(-10);
			dynStats("lus", -25, "cor", (-3 - rand(2)), "scale", false);
			player.HPChange(20 + (5 * player.level) + rand(5 * player.level), true);
			player.refillHunger(10);
 			if (player.cor > 50) dynStats("cor", -1);
 			if (player.cor > 75) dynStats("cor", -1);
			
			return false;
		}
	}
}
