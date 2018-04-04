package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.StatusEffects.Combat.BasiliskSlowDebuff;

	/**
	 * Class to categorize monsters with the stare ability
	 * @since  27.02.2018
	 * @author Stadler76
	 */
	public class StareMonster extends Monster
	{
		public static function speedReduce(player:Player, amount:Number = 0):void
		{
			var bse:BasiliskSlowDebuff = player.createOrFindStatusEffect(StatusEffects.BasiliskSlow) as BasiliskSlowDebuff;
			bse.applyEffect(amount);
		}
	}
}
