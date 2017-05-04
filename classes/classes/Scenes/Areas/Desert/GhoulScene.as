// By Foxwells
// Ghouls! Their lore is that they look like hyenas and lure people to places and then eat them
// Apparently also they live in deserts and graveyards

package classes.Scenes.Areas.Desert {

	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class GhoulScene extends BaseContent {
	
		public function GhoulScene() {
			
		}
		
		public function ghoulEncounter():void {
			clearOutput();
			outputText("As you wander the desert, your eyes catch something moving. You look in its direction. It's a hyena. Not a hyena-morph, but a literal hyena. If that wasn't weird enough, you're pretty certain anything hyena would be found ", false);
				if (flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0) {
					outputText("at the Plains.", false);
				} else {
					outputText("elsewhere.", false);
				}
			outputText(" But it hardly matters. The hyena has spotted you and is charging at you, ruining any more contemplation. Instead, you prep yourself for a fight.", false);
			startCombat(new Ghoul());
		}
		
		public function ghoulWon():void {
			combat.cleanupAfterCombat();
			clearOutput();
			if (player.HP <= 0) {
				outputText("You fall into the sand, your wounds too great. ", false);
			}
			else { //lust loss I guess
				outputText("You fall into the sand, your lust too overpowering. ", false);
			}
			outputText("The ghoul wastes no time and lunges forward at you. The last thing you see before you pass out is the ghoul's outstretched jaws.\n\nYou have no idea what time it is when you wake up. Bite marks and other wounds cover your body, and pain wracks you with every breath you take. The sand is red with your blood and the metallic smell makes your stomach churn, but at the very least, you don't seem to be bleeding anymore. With great effort, you heave yourself up and stagger your way back to camp.", false);
			dynStats("str", -2);
			dynStats("tou", -3);
			dynStats("sens", 3);
			doNext(camp.returnToCampUseFourHours);
		}
	}
}
