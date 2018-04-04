/* Created by aimozg on 06.01.14 */
package classes.Scenes.Areas {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.API.Encounter;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.IExplorable;
import classes.Scenes.Areas.Swamp.*;
import classes.Scenes.PregnancyProgression;
import classes.internals.GuiOutput;

	use namespace kGAMECLASS;

	public class Swamp extends BaseContent implements IExplorable {
		public var corruptedDriderScene:CorruptedDriderScene;
		public var femaleSpiderMorphScene:FemaleSpiderMorphScene = new FemaleSpiderMorphScene();
		public var maleSpiderMorphScene:MaleSpiderMorphScene;
		public var rogar:Rogar = new Rogar();

		public function Swamp(pregnancyProgression:PregnancyProgression, output:GuiOutput) {
			maleSpiderMorphScene = new MaleSpiderMorphScene(pregnancyProgression, output);
			corruptedDriderScene = new CorruptedDriderScene(pregnancyProgression, output);
		}

		public function isDiscovered():Boolean { return flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0; }
		public function discover():void {
			flags[kFLAGS.TIMES_EXPLORED_SWAMP] = 1;
			outputText(images.showImage("area-swamp"));
			outputText("All things considered, you decide you wouldn't mind a change of scenery.  Gathering up your belongings, you begin a journey into the wasteland.  The journey begins in high spirits, and you whistle a little traveling tune to pass the time.  After an hour of wandering, however, your wanderlust begins to whittle away.  Another half-hour ticks by.  Fed up with the fruitless exploration, you're nearly about to head back to camp when a faint light flits across your vision.  Startled, you whirl about to take in three luminous will-o'-the-wisps, swirling around each other whimsically.  As you watch, the three ghostly lights begin to move off, and though the thought of a trap crosses your mind, you decide to follow.\n\n");
			outputText("Before long, you start to detect traces of change in the environment.  The most immediate difference is the increasingly sweltering heat.  A few minutes pass, then the will-o'-the-wisps plunge into the boundaries of a dark, murky, stagnant swamp; after a steadying breath you follow them into the bog.  Once within, however, the gaseous balls float off in different directions, causing you to lose track of them.  You sigh resignedly and retrace your steps, satisfied with your discovery.  Further exploration can wait.  For now, your camp is waiting.\n\n");
			outputText("<b>You've discovered the Swamp!</b>");
			doNext(camp.returnToCampUseTwoHours);
		}

		private var _explorationEncounter:Encounter = null;
		public function get explorationEncounter():Encounter {
			const game:CoC = kGAMECLASS;
			const fn:FnHelpers = Encounters.fn;
			if (_explorationEncounter == null) _explorationEncounter =
					Encounters.group(game.commonEncounters, {
						name: "bog",
						when: function ():Boolean {
							return (flags[kFLAGS.TIMES_EXPLORED_SWAMP] >= 25) && !game.bog.isDiscovered();
						},
						call: game.bog.discover
					}, {
						name: "kihaxhel",
						when: function ():Boolean {
							return !kGAMECLASS.kihaFollower.followerKiha()
							// 		&& flags[kFLAGS.KIHA_KILLED] == 0 //[INTERMOD:8chan]
									&& player.cor < 60
									&& flags[kFLAGS.KIHA_AFFECTION_LEVEL] >= 1
									&& flags[kFLAGS.HEL_FUCKBUDDY] > 0
									&& player.hasCock()
									&& flags[kFLAGS.KIHA_AND_HEL_WHOOPIE] == 0;
						},
						call: game.kihaFollower.kihaXSalamander
					}, {
						name  : "ember",
						when  : function ():Boolean {
							return flags[kFLAGS.TOOK_EMBER_EGG] == 0
								   && flags[kFLAGS.EGG_BROKEN] == 0
								   && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0;
						},
						chance: 0.1,
						call  : game.emberScene.findEmbersEgg
					}, {
						name: "rogar",
						when: function ():Boolean {
							return flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_PHASE] < 3;
						},
						call: rogar.encounterRogarSwamp
					}, {
						name: "mspider",
						call: maleSpiderMorphScene.greetMaleSpiderMorph
					}, {
						name: "fspider",
						call: femaleSpiderMorphScene.fSpiderMorphGreeting
					}, {
						name: "drider",
						call: corruptedDriderScene.driderEncounter
					}, {
						name: "kiha",
						call: function ():void {
							if (game.kihaFollower.followerKiha()
							//	|| flags[kFLAGS.KIHA_KILLED] //[INTERMOD:8chan]
								|| flags[kFLAGS.KIHA_TOLL_DURATION] > 1) game.kihaScene.kihaExplore();
							else game.kihaScene.encounterKiha();
						}
					}, {
						name: "walk",
						call: walkingSwampStatBoost
					});
			return _explorationEncounter;
		}
		public function explore():void {
			flags[kFLAGS.TIMES_EXPLORED_SWAMP]++;
			return explorationEncounter.execEncounter();
		}

		private function walkingSwampStatBoost():void {
			clearOutput();
			outputText(images.showImage("area-swamp"));
			outputText("You walk through the swamp lands for an hour, finding nothing.\n\n");
			//Chance of boost == 50%
			if (rand(2) == 0) {
				if (rand(2) == 0 && player.spe100 < 50) { //50/50 speed/toughness
					outputText("The effort of struggling with the uncertain footing has made you quicker.");
					dynStats("spe", .5);
				}
				else if (player.tou100 < 50) { //Toughness
					outputText("The effort of struggling with the uncertain footing has made you tougher.");
					dynStats("tou", .5);
				}
			}
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
