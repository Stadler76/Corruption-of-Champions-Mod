package classes.Items.Consumables 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	public class FishFillet extends Consumable 
	{
		public function FishFillet() 
		{
			super("FishFil", "FishFil", "a fish fillet", ConsumableLib.DEFAULT_VALUE, "A perfectly cooked piece of fish.  You're not sure what type of fish is, since you're fairly certain \"delicious\" is not a valid species.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			if (!getGame().inCombat) outputText("You sit down and unwrap your fish fillet. It's perfectly flaky, allowing you to break it off in bite-sized chunks.  The salty meal disappears quickly, and your stomach gives an appreciative gurgle.");
			//(In combat?)
			else outputText("You produce the fish fillet from your bag.  Rather than unwrap it and savor the taste as you normally would, you take a large bite out of it, leaf wrapping and all.  In no time your salty meal is gone, your stomach giving an appreciative gurgle.  ");

			//Increase HP by quite a bit!)
			//(Slight chance at increasing Toughness?)
			//(If lake has been tainted, +1 Corruption?)
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) dynStats("cor", 0.5);
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) dynStats("cor", -0.1);
			dynStats("cor", 0.1);
			player.HPChange(Math.round(player.maxHP() * .25), true);
			player.refillHunger(30);
			
			return false;
		}
	}
}
