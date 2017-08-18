/**
 * Created by Kitteh6660. Volcanic Crag is a new endgame area with level 25 encounters.
 * Currently a Work in Progress.
 * 
 * This zone was mentioned in Glacial Rift doc.
 */

package classes.Scenes.Areas 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.API.Encounter;
	import classes.Scenes.API.Encounters;
	import classes.Scenes.API.FnHelpers;
	import classes.Scenes.API.IExplorable;
	import classes.Scenes.Areas.VolcanicCrag.*;
	
	use namespace kGAMECLASS;
	
	public class VolcanicCrag extends BaseContent implements IExplorable
	{
		public var behemothScene:BehemothScene = new BehemothScene();
		/* [INTERMOD:8chan]
		 public var volcanicGolemScene:VolcanicGolemScene           = new VolcanicGolemScene();
		 public var corruptedSandWitchScene:CorruptedSandWitchScene = new CorruptedSandWitchScene();
		 */
		
		public function VolcanicCrag() 
		{
		}

		public function isDiscovered():Boolean {
			return flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] > 0;
		}

		public function discover():void {
			flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] = 1;
			outputText(images.showImage("area-vulcaniccrag"));
			outputText("You walk for some time, roaming the hard-packed and pink-tinged earth of the demon-realm of Mareth. As you progress, you can feel the air getting warm. It gets hotter as you progress until you finally stumble across a blackened landscape. You reward yourself with a sight of the endless series of a volcanic landscape. Crags dot the landscape.\n\n");
			outputText("<b>You've discovered the Volcanic Crag!</b>");
			doNext(camp.returnToCampUseTwoHours);
		}

	private var _explorationEncounter:Encounter = null;
	public function get explorationEncounter():Encounter {
		return _explorationEncounter ||= Encounters.group(kGAMECLASS.commonEncounters, {
			name  : "aprilfools",
			when  : function ():Boolean {
				return isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0;
			},
			chance: Encounters.ALWAYS,
			call  : cragAprilFools
		}, {
			name  : "behemoth",
			chance: 1,
			call  : behemothScene.behemothIntro
		}, {
			name: "drakesheart",
			call: lootDrakHrt
			/* [INTERMOD: 8chan]
		}, {
			name: "golem",
			when: function ():Boolean {
				return flags[kFLAGS.DESTROYEDVOLCANICGOLEM] != 1;
			},
			call: volcanicGolemScene.volcanicGolemIntro
		}, {
			name: "witch",
			call: corruptedSandWitchScene.corrWitchIntro
			*/
		}, {
			name: "walk",
			call: walk
		});
	}

		public function explore():void {
			flags[kFLAGS.DISCOVERED_VOLCANO_CRAG]++;
			doNext(playerMenu);
			explorationEncounter.execEncounter();
		}

		private function lootDrakHrt():void {
			clearOutput();
			outputText(images.showImage("item-dHeart"));
			outputText("While you're minding your own business, you spot a flower. You walk over to it, pick it up and smell it. By Marae, it smells amazing! It looks like Drake's Heart as the legends foretold. ");
			inventory.takeItem(consumables.DRAKHRT, camp.returnToCampUseOneHour);
		}

		private function walk():void {
			clearOutput();
			outputText(images.showImage("area-vulcaniccrag"));
			outputText("You spend one hour exploring the infernal landscape but you don't manage to find anything interesting.");
			doNext(camp.returnToCampUseOneHour);
		}

		private function cragAprilFools():void {
			outputText(images.showImage("event-dlc"));
			getGame().aprilFools.DLCPrompt("Extreme Zones DLC", "Get the Extreme Zones DLC to be able to visit Glacial Rift and Volcanic Crag and discover the realms within!", "$4.99");
		}
		
	}

}
