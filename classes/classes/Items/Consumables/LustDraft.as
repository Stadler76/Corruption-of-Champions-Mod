package classes.Items.Consumables 
{
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;

	/**
	 * @since March 26, 2018
	 * @author Stadler76
	 */
	public class LustDraft extends Consumable 
	{
		public static const STANDARD:int = 0;
		public static const ENHANCED:int = 1;

		private var fuck:Boolean;

		public function LustDraft(type:int) 
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			fuck = type === ENHANCED;

			switch (type) {
				case STANDARD:
					id = "L.Draft";
					shortName = "LustDraft";
					longName = "a vial of roiling bubble-gum pink fluid";
					description = 'This vial of bright pink fluid bubbles constantly inside the glass, as if eager to escape.'
					             +' It smells very sweet, and has "Lust" inscribed on the side of the vial.';
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case ENHANCED:
					id = "F.Draft";
					shortName = "FuckDraft";
					longName = 'a vial of roiling red fluid labeled "Fuck Draft"';
					description = 'This vial of red fluid bubbles constantly inside the glass, as if eager to escape.'
					             +' It smells very strongly, though its odor is difficult to identify.'
					             +'  The word "Fuck" is inscribed on the side of the vial.';
					value = 20;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			player.slimeFeed();
			clearOutput();
			outputText("You drink the " + (fuck ? "red" : "pink") + " potion, and its unnatural warmth immediately flows to your groin.");
			dynStats("lus", (30 + rand(player.lib / 10)), "scale", false);

			//Heat/Rut for those that can have them if "fuck draft"
			if (fuck) {
				//Try to go into intense heat.
				player.goIntoHeat(true, 2);
				//Males go into rut
				player.goIntoRut(true);
			}
			//ORGAZMO
			if (player.lust >= player.maxLust() && !kGAMECLASS.inCombat) {
				outputText("\n\nThe arousal from the potion overwhelms your senses and causes you to spontaneously orgasm."
				          +" You rip off your [armor] and look down as your "
				          +"[if (hasCock)[cocks] erupt[if (cocks == 1)s] in front of you, liberally spraying the ground around you. "
				          + "[if (hasVagina)At the same time your ]" // Had to do this, since parser-weirdness with [if (hasCock && hasVagina)]
				          +"]"
				          +"[if (hasVagina)[vagina] soaks your thighs. ]"
				          +"[if (isGenderless)body begins to quiver with orgasmic bliss. ]"
				          +"Once you've had a chance to calm down, you notice that the explosion of pleasure you just experienced"
				          +" has rocked you to your core. You are a little hornier than you were before.");
				//increase player libido, and maybe sensitivity too?
				player.orgasm('Generic');
				dynStats("lib", 2, "sen", 1);
			}
			if (player.lust > player.maxLust()) player.lust = player.maxLust();
			outputText("\n\n");
			player.refillHunger(5);
			return false;
		}
	}
}
