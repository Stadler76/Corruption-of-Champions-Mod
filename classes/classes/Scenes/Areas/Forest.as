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
	import classes.Scenes.API.IExplorable;
	import classes.Scenes.Areas.Forest.*;
	
	use namespace kGAMECLASS;

	public class Forest extends BaseContent implements IExplorable
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
			clearOutput();
			outputText(images.showImage("area-forest"));
			outputText("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You have discovered the Forest!</b>");
			flags[kFLAGS.TIMES_EXPLORED]++;
			flags[kFLAGS.TIMES_EXPLORED_FOREST]++;
			doNext(camp.returnToCampUseOneHour);
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
						call  : kGAMECLASS.deepWoods.discover,
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

		public function tentacleBeastEncounterFn():void {
			clearOutput();
			//Oh noes, tentacles!
			//Tentacle avoidance chance due to dangerous plants
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				//trace("TENTACLE'S AVOIDED DUE TO BOOK!");
				outputText(images.showImage("item-dPlants"));
				outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n");
				menu();
				addButton(0, "Continue", tentacleBeastScene.encounter);
				addButton(4, "Leave", camp.returnToCampUseOneHour);
			} else {
				tentacleBeastScene.encounter();
			}

		}

		public function tripOnARoot():void {
			outputText(images.showImage("minomob-falling"));
			outputText("You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.");
			player.takeDamage(10);
			doNext(camp.returnToCampUseOneHour);
		}

		public function findTruffle():void {
			outputText(images.showImage("item-pigTruffle"));
			outputText("You spot something unusual. Taking a closer look, it's definitely a truffle of some sort. ");
			inventory.takeItem(consumables.PIGTRUF, camp.returnToCampUseOneHour);
		}
		public function findHPill():void {
			outputText(images.showImage("item-hPill"));
			outputText("You find a pill stamped with the letter 'H' discarded on the ground. ");
			inventory.takeItem(consumables.H_PILL, camp.returnToCampUseOneHour);
		}
		public function findChitin():void {
			outputText(images.showImage("item-bChitin"));
			outputText("You find a large piece of insectile carapace obscured in the ferns to your left. It's mostly black with a thin border of bright yellow along the outer edge. There's still a fair portion of yellow fuzz clinging to the chitinous shard. ");
			if (player.statusEffectv2(StatusEffects.MetRathazul) == 0) outputText("It feels strong and flexible - maybe someone can make something of it. ");
			inventory.takeItem(useables.B_CHITN, camp.returnToCampUseOneHour);
		}
		public function forestWalkFn():void {
			outputText(images.showImage("area-forest"));
			if (player.cor < 80) {
				outputText("You enjoy a peaceful walk in the woods, it gives you time to think.");
				dynStats("tou", .5, "int", 1);
			}
			else {
				outputText("As you wander in the forest, you keep ");
				if (player.gender == 1) outputText("stroking your half-erect " + player.multiCockDescriptLight() + " as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes.");
				if (player.gender == 2) outputText("idly toying with your " + player.vaginaDescript(0) + " as you daydream about getting fucked by all kinds of monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.");
				if (player.gender == 3) outputText("stroking alternatively your " + player.multiCockDescriptLight() + " and your " + player.vaginaDescript(0) + " as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes, before, or while, getting fucked by various monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.");
				if (player.gender == 0) outputText("daydreaming about sex-demons with huge sexual attributes, and how you could please them.");
				outputText("");
				dynStats("tou", .5, "lib", .25, "lus", player.lib / 5);
			}
			doNext(camp.returnToCampUseOneHour);
		}


		public function marbleVsImp():void {
			clearOutput();
			outputText("While you're moving through the trees, you suddenly hear yelling ahead, followed by a crash and a scream as an imp comes flying at high speed through the foliage and impacts a nearby tree.  The small demon slowly slides down the tree before landing at the base, still.  A moment later, a familiar-looking cow-girl steps through the bushes brandishing a huge two-handed hammer with an angry look on her face.");
			outputText(images.showImage("monster-marble"));
			outputText("\n\nShe goes up to the imp, and kicks it once.  Satisfied that the creature isn't moving, she turns around to face you and gives you a smile.  \"<i>Sorry about that, but I prefer to take care of these buggers quickly.  If they get the chance to call on their friends, they can actually become a nuisance.</i>\"  She disappears back into the foliage briefly before reappearing holding two large pile of logs under her arms, with a fire axe and her hammer strapped to her back.  \"<i>I'm gathering firewood for the farm, as you can see; what brings you to the forest, sweetie?</i>\"  You inform her that you're just exploring.");
			outputText("\n\nShe gives a wistful sigh. \"<i>I haven't really explored much since getting to the farm.  Between the jobs Whitney gives me, keeping in practice with my hammer, milking to make sure I don't get too full, cooking, and beauty sleep, I don't get a lot of free time to do much else.</i>\"  She sighs again.  \"<i>Well, I need to get this back, so I'll see you later!</i>\"");
			//end event
			doNext(camp.returnToCampUseOneHour);
		}
		public function explore():void
		{
			clearOutput();
			//Increment forest exploration counter.
			flags[kFLAGS.TIMES_EXPLORED_FOREST]++;
			forestEncounter.execEncounter();
		}

	}
}
