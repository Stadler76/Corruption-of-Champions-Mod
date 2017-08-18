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
	import classes.Scenes.Areas.Lake.*;

	use namespace kGAMECLASS;

	public class Lake extends BaseContent implements IExplorable
	{
		
		public var fetishCultistScene:FetishCultistScene = new FetishCultistScene();
		public var fetishZealotScene:FetishZealotScene = new FetishZealotScene();
		public var gooGirlScene:GooGirlScene = new GooGirlScene();
		public var greenSlimeScene:GreenSlimeScene = new GreenSlimeScene();
		public var kaiju:Kaiju = new Kaiju();
		public var calluScene:CalluScene = new CalluScene();
		public var swordInStone:SwordInStone = new SwordInStone();
		public function Lake()
		{
		}
		public function isDiscovered():Boolean {
			return flags[kFLAGS.TIMES_EXPLORED_LAKE] > 0;
		}

		public function discover():void {
			flags[kFLAGS.TIMES_EXPLORED_LAKE] = 1;
			outputText(images.showImage("area-lake"));
			outputText("Your wanderings take you far and wide across the barren wasteland that surrounds the portal, until the smell of humidity and fresh water alerts you to the nearby lake.  With a few quick strides you find a lake so massive the distant shore cannot be seen.  Grass and a few sparse trees grow all around it.\n\n<b>You've discovered the Lake!</b>");
			doNext(camp.returnToCampUseOneHour);
		}

		private var _exploreEncounter:Encounter = null;
		public function get exploreEncounter():Encounter {
			const game:CoC     = getGame();
			const fn:FnHelpers = Encounters.fn;
			//==============================
			//EVENTS GO HERE!
			//==============================
			if (_exploreEncounter == null) _exploreEncounter = Encounters.group(
					game.commonEncounters,
					fetishCultistScene,
					gooGirlScene, {
						call: game.commonEncounters.impEncounter,
						when: fn.ifNGplusMin(1)
					}, {
						call: game.commonEncounters.goblinEncounter,
						when: fn.ifNGplusMin(1)
					}, {
						name  : "egg",
						call  : eggChooserMenu,
						when  : fn.ifPregnantWith(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS),
						chance: 2.5
					}, {
						call  : calluScene,
						chance: 0.2
					}, game.latexGirl.lakeDiscovery,
					game.izmaScene,
					game.rathazul,
					kaiju,
					game.aprilFools.poniesEncounter, {
						name: "boat",
						call: game.boat.discoverBoat,
						when: fn.not(game.boat.isDiscovered)
					}, {
						name: "townruins",
						call: game.townRuins.discoverAmilyVillage,
						when: fn.not(game.townRuins.isDiscovered)
					}, swordInStone, {
						name  : "bigjunk",
						call  : curry(game.commonEncounters.bigJunkForestScene, true),
						chance: game.commonEncounters.bigJunkChance
					}, Encounters.group("loot", {
						name: "equinum",
						call: findEquinum
					}, {
						name: "wfruit",
						call: findWFruit
					}), {
						name: "farm",
						call: game.farm.farmExploreEncounter,
						when: farmEncounterAvailable
					}, {
						name: "walk",
						call: lakeWalk
					});
			return _exploreEncounter;
		}

		//Explore Lake
		public function explore():void {
			//Increment exploration count
			flags[kFLAGS.TIMES_EXPLORED_LAKE]++;
			exploreEncounter.execEncounter();
		}

		public function farmEncounterAvailable():Boolean {
			return !player.hasStatusEffect(StatusEffects.MetWhitney)
				   || player.statusEffectv1(StatusEffects.MetWhitney) <= 1;
		}

		public function lakeWalk():void {
				outputText(images.showImage("area-lake"));
			if (player.level < 2 || player.spe100 < 50) {
				clearOutput();
				outputText("Your quick walk along the lakeshore feels good.");
				if (player.spe100 < 50) {
					outputText("  You bet you could cover the same distance even faster next time.\n");
					dynStats("spe", .75);
				}
			} else {
				clearOutput();
				outputText("Your stroll around the lake increasingly bores you, leaving your mind to wander.  ");
				if (player.cor >= 60 || player.lust100 >= 90 || player.lib >= 75) {
					outputText("Your imaginings increasingly seem to turn into daydreams of raunchy perverted sex, flooding your groin with warmth.");
					dynStats("lus", (player.cor / 10 + player.lib / 10));
				} else if (player.cor > 30 || player.lust100 > 60 || player.lib > 40) {
					outputText("Your imaginings increasingly seem to turn to thoughts of sex.");
					dynStats("lus", (5 + player.lib / 10));
				} else {
					dynStats("int", 1);
				}
			}
			doNext(camp.returnToCampUseOneHour);
		}

		public function eggChooserMenu():void {
			clearOutput();
			outputText(images.showImage("lake-lights"));
			outputText("While wandering along the lakeshore, you spy beautiful colored lights swirling under the surface.  You lean over cautiously, and leap back as they flash free of the lake's liquid without making a splash.  The colored lights spin in a circle, surrounding you.  You wonder how you are to fight light, but they stop moving and hover in place around you.  There are numerous colors: Blue, Pink, White, Black, Purple, and Brown.  They appear to be waiting for something; perhaps you could touch one of them?");
			menu();
			addButton(0, "Blue", eggChoose, 2);
			addButton(1, "Pink", eggChoose, 3);
			addButton(2, "White", eggChoose, 4);
			addButton(3, "Black", eggChoose, 5);
			addButton(4, "Purple", eggChoose, 1);
			addButton(5, "Brown", eggChoose, 0);
			addButton(14, "Escape", eggChooseEscape);
		}

		public function findWFruit():void {
			clearOutput();
			outputText(images.showImage("item-wFruit"));
			outputText("You find an odd, fruit-bearing tree growing near the lake shore.  One of the fruits has fallen on the ground in front of you.  You pick it up.\n");
			inventory.takeItem(consumables.W_FRUIT, camp.returnToCampUseOneHour);
		}

		public function findEquinum():void {
			clearOutput();
			outputText(images.showImage("item-equinum"));
			outputText("You find a long and oddly flared vial half-buried in the sand.  Written across the middle band of the vial is a single word: 'Equinum'.\n");
			inventory.takeItem(consumables.EQUINUM, camp.returnToCampUseOneHour);
		}
		
		private function eggChoose(eggType:int):void {
			clearOutput();
			outputText("You reach out and touch the ");
			switch (eggType) {
				case  0: outputText("brown"); break;
				case  1: outputText("purple"); break;
				case  2: outputText("blue"); break;
				case  3: outputText("pink"); break;
				case  4: outputText("white"); break;
				default: outputText("black"); break;
			}
			outputText(" light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.");
			player.statusEffectByType(StatusEffects.Eggs).value1 = eggType; //Value 1 is the egg type. If pregnant with OviElixir then StatusEffects.Eggs must exist
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function eggChooseEscape():void {
			clearOutput();
			outputText("You throw yourself into a roll and take off, leaving the ring of lights hovering in the distance behind you.");
			doNext(camp.returnToCampUseOneHour);
		}
		

	}
}

