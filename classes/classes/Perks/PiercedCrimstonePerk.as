/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.Perk;
	import classes.PerkType;

	public class PiercedCrimstonePerk extends PerkType
	{

		override public function desc(params:Perk = null):String
		{
			return "Increases minimum lust by " + Math.round(params.value1) + ".";
		}

		public function PiercedCrimstonePerk()
		{
			super("Pierced: Crimstone", "Pierced: Crimstone",
					"You've been pierced with Crimstone and your lust seems to stay a bit higher than before.");
		}
	}
}
