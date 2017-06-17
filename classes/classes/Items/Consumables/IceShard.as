package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	/**
	 * A refreshing icicle.
	 */
	public class IceShard extends Consumable 
	{
		public function IceShard() 
		{
			super("Icicle ","Icicle", "an ice shard", ConsumableLib.DEFAULT_VALUE,"An icicle that seems to be incapable of melting.  It numbs your hands as you hold it. ");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You give the icicle a tentative lick, careful not to stick your tongue to it. It tastes refreshing, like cool, clear glacier water.  The ice readily dissolves against the heat of your mouth as you continue to lick away at it.  Before long, the icicle has dwindled into a sliver small enough to pop into your mouth.  As the pinprick of ice melts you slide your chilled tongue around your mouth, savoring the crisp feeling.\n\n")
			if (rand(2) === 0 && (player.str100 < 75 || player.tou100 < 75)) {
				outputText("The rush of cold tenses your muscles and fortifies your body, making you feel hardier than ever.  ");
				if (player.str100 < 75) dynStats("str", ((1 + rand(5)) / 5))
				if (player.tou100 < 75) dynStats("tou", ((1 + rand(5)) / 5))
			}
			if (rand(2) === 0 && (player.spe100 > 25)) {
				outputText("You feel a chill spread through you; when it passes, you feel more slothful and sluggish.  ");
				if (player.spe100 > 25) dynStats("spe", -((1 + rand(5)) / 5))
			}
			if (rand(2) === 0) {
				outputText("You also feel a little numb all over, in more ways than one...  ")
				dynStats("lib", -((1 + rand(2)) / 2))
				dynStats("sen", -((1 + rand(2)) / 2))
			}
			player.refillHunger(5);
			
			return false;
		}
	}
}
