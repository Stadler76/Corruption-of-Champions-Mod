/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.API.Encounter;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
	import classes.Scenes.Areas.Forest.*;
	
	use namespace kGAMECLASS;

	public class Forest extends BaseContent
	{
		public var akbalScene:AkbalScene = new AkbalScene();
		public var beeGirlScene:BeeGirlScene = new BeeGirlScene();
		public var corruptedGlade:CorruptedGlade = new CorruptedGlade();
		public var essrayle:Essrayle = new Essrayle();
		public var faerie:Faerie = new Faerie();
		public var kitsuneScene:KitsuneScene = new KitsuneScene();
		public var tamaniScene:TamaniScene = new TamaniScene();
		public var tentacleBeastScene:TentacleBeastScene = new TentacleBeastScene();
		public var erlkingScene:ErlKingScene = new ErlKingScene();
		// public var dullahanScene:DullahanScene = new DullahanScene(); // [INTERMOD:8chan]

		public function Forest() { }

		public function isDiscovered():Boolean {
			return flags[kFLAGS.TIMES_EXPLORED_FOREST] > 0;
		}
		public function discover():void {
			outputText("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You have discovered the Forest!</b>", true);
			flags[kFLAGS.TIMES_EXPLORED]++;
			flags[kFLAGS.TIMES_EXPLORED_FOREST]++;
			doNext(camp.returnToCampUseOneHour);
		}
		public function deepwoodsDiscovered():Boolean {
			return player.hasStatusEffect(StatusEffects.ExploredDeepwoods);
		}

		public function exploreDeepwoods():void
		{
			clearOutput();
			//Increment deepwoods exploration counter.
			player.addStatusValue(StatusEffects.ExploredDeepwoods, 1, 1);
			deepwoodsEncounter.execEncounter();
		}

		private function deepwoodsWalkFn():void {
			outputText("You enjoy a peaceful walk in the deepwoods.  It gives you time to think over the recent, disturbing events.", true);
			dynStats("tou", .5, "int", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		public function tentacleBeastDeepwoodsEncounterFn():void {
			if (player.gender > 0) flags[kFLAGS.GENDERLESS_CENTAUR_MADNESS] = 0;
			//Tentacle avoidance chance due to dangerous plants
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				trace("TENTACLE'S AVOIDED DUE TO BOOK!");
				outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n", true);
				menu();
				addButton(0,"Continue", tentacleBeastScene.encounter);
				addButton(4, "Leave", camp.returnToCampUseOneHour);
			}else {
				tentacleBeastScene.encounter();
			}
		}

		//==============================
		//EVENTS GO HERE!
		//==============================
		private var _forestEncounter:Encounter = null;
		public function get forestEncounter():Encounter { // lateinit because it references getGame()
			const game:CoC     = getGame();
			const fn:FnHelpers = Encounters.fn;
			if (_forestEncounter == null) _forestEncounter =
					Encounters.group(game.commonEncounters.withImpGob, {
						call  : tamaniScene,
						chance: 0.15
					}, game.jojoScene.jojoForest, {
						call  : essrayle.forestEncounter,
						chance: 0.10
					}, corruptedGlade, {
						call  : camp.cabinProgress.forestEncounter,
						chance: 0.5
					}, {
						name  : "deepwoods",
						call  : discoverDeepwoods,
						when  : function ():Boolean {
							return (flags[kFLAGS.TIMES_EXPLORED_FOREST] >= 20) && !player.hasStatusEffect(StatusEffects.ExploredDeepwoods);
						},
						chance: Encounters.ALWAYS
					}, {
						name  : "beegirl",
						call  : beeGirlScene.beeEncounter,
						chance: 0.50
					}, {
						name: "tentabeast",
						call: tentacleBeastEncounterFn,
						when: fn.ifLevelMin(2)
					}, {
						name  : "mimic",
						call  : curry(game.mimicScene.mimicTentacleStart, 3),
						when  : fn.ifLevelMin(3),
						chance: 0.50
					}, {
						name  : "succubus",
						call  : game.succubusScene.encounterSuccubus,
						when  : fn.ifLevelMin(3),
						chance: 0.50
					}, {
						name  : "marble",
						call  : marbleVsImp,
						when  : function ():Boolean {
							return flags[kFLAGS.TIMES_EXPLORED_FOREST] > 0 &&
								   !player.hasStatusEffect(StatusEffects.MarbleRapeAttempted)
								   && !player.hasStatusEffect(StatusEffects.NoMoreMarble)
								   && player.hasStatusEffect(StatusEffects.Marble)
								   && flags[kFLAGS.MARBLE_WARNING] == 0;
						},
						chance: 0.10
					}, {
						name: "trip",
						call: tripOnARoot
					}, {
						name  : "chitin",
						call  : findChitin,
						chance: 0.05
					}, {
						name  : "healpill",
						call  : findHPill,
						chance: 0.10
					}, {
						name  : "truffle",
						call  : findTruffle,
						chance: 0.35
					}, {
						name  : "bigjunk",
						call  : game.commonEncounters.bigJunkForestScene,
						chance: game.commonEncounters.bigJunkChance
					}, {
						name: "walk",
						call: forestWalkFn
					});
			return _forestEncounter;
		}
		private var _deepwoodsEncounter:Encounter = null;
		public function get deepwoodsEncounter():Encounter { // lateinit because it references getGame()
			return _deepwoodsEncounter ||= Encounters.group(kGAMECLASS.commonEncounters, {
				name: "kitsune",
				call: kitsuneScene
			}, /*{ // [INTERMOD:8chan]
				name: "dullahan",
				call: dullahanScene
			}, */{
				name: "akbal",
				call: akbalScene
			}, {
				name: "tamani",
				call: tamaniScene
			}, {
				name: "faerie",
				call: faerie
			}, {
				name: "erlking",
				call: erlkingScene
			}, {
				name: "fera",
				call: getGame().fera
			}, {
				name: "lumber",
				call: getGame().camp.cabinProgress.forestEncounter
			}, {
				name  : "glade",
				call  : corruptedGlade,
				chance: 2
			}, {
				name: "tentabeast",
				call: tentacleBeastDeepwoodsEncounterFn,
				when: Encounters.fn.ifLevelMin(2)
			}, {
				name: "dungeon",
				call: getGame().dungeons.enterDeepCave,
				when: getGame().dungeons.canFindDeepCave
			}, {
				name  : "walk",
				call  : deepwoodsWalkFn,
				chance: 0.01
			});
		}



		public function discoverDeepwoods():void {
			player.createStatusEffect(StatusEffects.ExploredDeepwoods, 0, 0, 0, 0);
			outputText("After exploring the forest so many times, you decide to really push it, and plunge deeper and deeper into the woods.  The further you go the darker it gets, but you courageously press on.  The plant-life changes too, and you spot more and more lichens and fungi, many of which are luminescent.  Finally, a wall of tree-trunks as wide as houses blocks your progress.  There is a knot-hole like opening in the center, and a small sign marking it as the entrance to the 'Deepwoods'.  You don't press on for now, but you could easily find your way back to explore the Deepwoods.\n\n<b>Deepwoods exploration unlocked!</b>", true);
			doNext(camp.returnToCampUseOneHour);
		}

		public function tentacleBeastEncounterFn():void {
			clearOutput();
			//Oh noes, tentacles!
			//Tentacle avoidance chance due to dangerous plants
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				trace("TENTACLE'S AVOIDED DUE TO BOOK!");
				outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n", false);
				menu();
				addButton(0, "Continue", tentacleBeastScene.encounter);
				addButton(4, "Leave", camp.returnToCampUseOneHour);
			} else {
				tentacleBeastScene.encounter();
			}

		}

		public function tripOnARoot():void {
			outputText("You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.", false);
			player.takeDamage(10);
			doNext(camp.returnToCampUseOneHour);
		}

		public function findTruffle():void {
			outputText("You spot something unusual. Taking a closer look, it's definitely a truffle of some sort. ");
			inventory.takeItem(consumables.PIGTRUF, camp.returnToCampUseOneHour);
		}
		public function findHPill():void {
			outputText("You find a pill stamped with the letter 'H' discarded on the ground. ");
			inventory.takeItem(consumables.H_PILL, camp.returnToCampUseOneHour);
		}
		public function findChitin():void {
			outputText("You find a large piece of insectile carapace obscured in the ferns to your left. It's mostly black with a thin border of bright yellow along the outer edge. There's still a fair portion of yellow fuzz clinging to the chitinous shard. It feels strong and flexible - maybe someone can make something of it. ");
			inventory.takeItem(useables.B_CHITN, camp.returnToCampUseOneHour);
		}
		public function forestWalkFn():void {
			if (player.cor < 80) {
				outputText("You enjoy a peaceful walk in the woods, it gives you time to think.", false);
				dynStats("tou", .5, "int", 1);
			}
			else {
				outputText("As you wander in the forest, you keep ", false);
				if (player.gender == 1) outputText("stroking your half-erect " + player.multiCockDescriptLight() + " as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes.", false);
				if (player.gender == 2) outputText("idly toying with your " + player.vaginaDescript(0) + " as you daydream about getting fucked by all kinds of monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.", false);
				if (player.gender == 3) outputText("stroking alternatively your " + player.multiCockDescriptLight() + " and your " + player.vaginaDescript(0) + " as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes, before, or while, getting fucked by various monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.", false);
				if (player.gender == 0) outputText("daydreaming about sex-demons with huge sexual attributes, and how you could please them.", false);
				outputText("", false);
				dynStats("tou", .5, "lib", .25, "lus", player.lib / 5);
			}
			doNext(camp.returnToCampUseOneHour);
		}


		public function marbleVsImp():void {
			clearOutput();
			outputText("While you're moving through the trees, you suddenly hear yelling ahead, followed by a crash and a scream as an imp comes flying at high speed through the foliage and impacts a nearby tree.  The small demon slowly slides down the tree before landing at the base, still.  A moment later, a familiar-looking cow-girl steps through the bushes brandishing a huge two-handed hammer with an angry look on her face.");
			outputText("\n\nShe goes up to the imp, and kicks it once.  Satisfied that the creature isn't moving, she turns around to face you and gives you a smile.  \"<i>Sorry about that, but I prefer to take care of these buggers quickly.  If they get the chance to call on their friends, they can actually become a nuisance.</i>\"  She disappears back into the foliage briefly before reappearing holding two large pile of logs under her arms, with a fire axe and her hammer strapped to her back.  \"<i>I'm gathering firewood for the farm, as you can see; what brings you to the forest, sweetie?</i>\"  You inform her that you're just exploring.");
			outputText("\n\nShe gives a wistful sigh. \"<i>I haven't really explored much since getting to the farm.  Between the jobs Whitney gives me, keeping in practice with my hammer, milking to make sure I don't get too full, cooking, and beauty sleep, I don't get a lot of free time to do much else.</i>\"  She sighs again.  \"<i>Well, I need to get this back, so I'll see you later!</i>\"");
			//end event
			doNext(camp.returnToCampUseOneHour);
		}
		public function exploreForest():void
		{
			clearOutput();
			//Increment forest exploration counter.
			flags[kFLAGS.TIMES_EXPLORED_FOREST]++;
			forestEncounter.execEncounter();
		}

	}
}
