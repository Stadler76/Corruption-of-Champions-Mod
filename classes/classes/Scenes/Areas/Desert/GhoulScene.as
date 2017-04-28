// By Foxwells
// Ghouls! Their lore is that they look like hyenas and lure people to places and then eat them
// Apparently also they live in deserts and graveyards

package classes.Scenes.Areas.Desert {

	import classes.*;

	public class GhoulScene extends BaseContent {
	
		public function GhoulScene() { }
		
		public function ghoulEncounter() {
			outputText("holy shit a hyena", false);
			startCombat(new Ghoul());
		}
		
		public function ghoulWon() {
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
			dynStats("tou", -5);
			dynStats("sens", 5);
			doNext(camp.returnToCampUseFourHours);
		}
	}
}
