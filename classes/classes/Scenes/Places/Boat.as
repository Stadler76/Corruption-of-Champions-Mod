/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Places
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.API.Encounter;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Areas.Lake.*;
	import classes.Scenes.Places.Boat.*;

	public class Boat extends AbstractLakeContent
	{
		public var sharkGirlScene:SharkGirlScene = new SharkGirlScene();
		public var marae:MaraeScene = new MaraeScene();
		
	public function Boat() {
	}

	public function isDiscovered():Boolean {
		return player.hasStatusEffect(StatusEffects.BoatDiscovery);
	}
		
		public function discoverBoat():void {
			clearOutput();
			player.createStatusEffect(StatusEffects.BoatDiscovery,0,0,0,0);
			outputText("You journey around the lake, seeking demons to fight");
			if (player.cor > 60) outputText(" or fuck");
			outputText(".  The air is fresh, and the grass is cool and soft under your feet.   Soft waves lap against the muddy sand of the lake-shore, as if radiating outward from the lake.   You pass around a few bushes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
			outputText("<b>You have discovered the lake boat!</b>\n(You may return and use the boat to explore the lake's interior by using the 'places' menu.)");
			doNext(camp.returnToCampUseOneHour);
		}

	private var _explorationEncounter:Encounter = null;
	public function get explorationEncounter():Encounter {
		return _explorationEncounter ||= Encounters.group(kGAMECLASS.commonEncounters, {
			name  : "izmakids",
			chance: 0.1,
			when  : function ():Boolean {
				return flags[kFLAGS.IZMA_KIDS_IN_WILD] > 0 && kGAMECLASS.izmaScene.izmaFollower();
			},
			call  : kGAMECLASS.izmaScene.findLostIzmaKids
		}, marae.encounterObject, {
			name: "nothing",
			call: nothingSpecial
		}, {
			name: "sharkgirl",
			call: curry(sharkGirlScene.sharkGirlEncounter, 1)
		}, {
			name  : "zealot",
			chance: 0.5,
			mods  : [FnHelpers.FN.ifLevelMin(2)],
			when  : function():Boolean {
				return flags[kFLAGS.FACTORY_SHUTDOWN] > 0;
			},
			call  : lake.fetishZealotScene.zealotBoat
		}, {
			name: "anemone",
			call: kGAMECLASS.anemoneScene.mortalAnemoneeeeee
		});
	}

	public function boatExplore():void {
			// XXX: This is supposed to be displayed for all encounters except Fetish Zealot. I guess new system doesn't allow this without putting it to every other encounter. Or removing clearOutput() from them.
			clearOutput();
			player.addStatusValue(StatusEffects.BoatDiscovery, 1, 1);
			outputText("You reach the dock without any incident and board the small rowboat.  The water is calm and placid, perfect for rowing.  ");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				outputText("The water appears somewhat muddy and has a faint pungent odor.  ");
				if (player.inte > 40) outputText("You realize what it smells like – sex.  ");
			}
			outputText("You set out, wondering if you'll find any strange islands or creatures in the lake.\n\n");
			
			explorationEncounter.execEncounter();
		}

		private function nothingSpecial():void {
			outputText(images.showImage("location-boat"));
			if (rand(2) == 0) {
				outputText("You row for nearly an hour, until your arms practically burn with exhaustion from all the rowing.");
			} else {
				outputText("You give up on finding anything interesting, and decide to go check up on your camp.");
			}
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
