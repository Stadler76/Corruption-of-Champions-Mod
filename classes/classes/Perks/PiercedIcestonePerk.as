/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.Perk;
	import classes.PerkType;

	public class PiercedIcestonePerk extends PerkType
	{

		override public function desc(params:Perk = null):String
		{
			return "Reduces minimum lust by " + Math.round(params.value1) + ".";
		}

		public function PiercedIcestonePerk()
		{
			super("Pierced: Icestone", "Pierced: Icestone",
					"You've been pierced with Icestone and your lust seems to stay a bit lower than before.");
		}
	}
}
