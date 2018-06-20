package classes
{
	import classes.BodyParts.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.PerkLib;
	import classes.Player;
	import classes.helper.StageLocator;
	import classes.lists.ColorLists;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.*;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import classes.Items.ArmorLib;

	public class PlayerTest 
	{
		private static const HP_OVER_HEAL:Number = 1000;
		private static const PLAYER_MAX_HP:Number = 250;
		private const MAX_SUPPORTED_VAGINAS:Number = 2;
		private const MAX_SUPPORTED_BREAST_ROWS:Number = 10;

		private var impPlayer:Player;
		private var minoPlayer:Player;
		private var cowPlayer:Player;
		private var wolfPlayer:Player;
		private var dogPlayer:Player;
		private var mutantPlayer:Player;
		private var cut:DummyPlayer;

		private function createVaginas(numberOfVaginas:Number, instance:Player):void
		{
			for (var i:Number = 0; i < numberOfVaginas; i++) {
				instance.createVagina();
			}
		}

		private function createMaxVaginas(instance:Player):void
		{
			createVaginas(MAX_SUPPORTED_VAGINAS, instance);
		}

		private function createBreastRows(numberOfRows:Number, instance:Player):void
		{
			removeAllBreasts(instance);
			for (var i:Number = 1; i < numberOfRows; i++) {
				instance.createBreastRow();
			}
		}

		private function createMaxBreastRows(instance:Player):void
		{
			createBreastRows(MAX_SUPPORTED_BREAST_ROWS, instance);
		}

		private function removeExtraBreastRows(instance:Player):void
		{
			if (instance.breastRows.length <= 1)
				return;

			instance.removeBreastRow(1, instance.breastRows.length - 1);
		}

		private function removeAllBreasts(instance:Player):void
		{
			if (instance.breastRows.length === 0) {
				instance.createBreastRow();
				return;
			}

			removeExtraBreastRows(instance);
			instance.breastRows[0].restore();
		}

		private function removeAllVags(instance:Player):void
		{
			if (instance.vaginas.length === 0)
				return;

			instance.removeVagina(0, instance.vaginas.length);
		}

		private function createCock(ctype:CockTypesEnum, instance:Player):void
		{
			instance.createCock(5.5, 1, ctype);
		}

		private function createPerk(perk:PerkType, instance:Player):void
		{
			instance.createPerk(perk, 1, 1, 1, 1);
		}

		private function createStatusEffect(stype:StatusEffectType, instance:Player):void
		{
			if (!instance.hasStatusEffect(stype))
				instance.createStatusEffect(stype, 1, 1, 1, 1);
		}

		[BeforeClass]
		public static function setUpClass():void
		{
			/* Hidden dependencies on global variables can cause tests to fail spectacularly.
			 * 
			 * Seriously people, DONT use global variables.
			 */

			kGAMECLASS = new CoC(StageLocator.stage);
		}

		[Before]
		public function setUp():void
		{
			impPlayer = new Player();
			impPlayer.createBreastRow();
			impPlayer.ears.type = Ears.IMP;
			impPlayer.tail.type = Tail.IMP;
			impPlayer.wings.type = Wings.IMP;
			impPlayer.wings.type = Wings.IMP_LARGE;
			impPlayer.lowerBody.type = LowerBody.IMP;
			impPlayer.skin.type = Skin.PLAIN;
			impPlayer.skin.tone = "red";
			impPlayer.horns.type = Horns.IMP;
			impPlayer.arms.setType(Arms.PREDATOR, Claws.IMP);

			minoPlayer = new Player();
			minoPlayer.face.type = Face.COW_MINOTAUR;
			minoPlayer.ears.type = Ears.COW;
			minoPlayer.tail.type = Tail.COW;
			minoPlayer.horns.type = Horns.COW_MINOTAUR;
			minoPlayer.lowerBody.type = LowerBody.HOOFED;
			minoPlayer.tallness = 100;
			createCock(CockTypesEnum.HORSE, minoPlayer);

			cowPlayer = new Player();
			cowPlayer.ears.type = Ears.COW;
			cowPlayer.tail.type = Tail.COW;
			cowPlayer.horns.type = Horns.COW_MINOTAUR;
			cowPlayer.lowerBody.type = LowerBody.HOOFED;
			cowPlayer.tallness = 73;
			cowPlayer.createVagina();
			cowPlayer.createBreastRow(5);
			cowPlayer.breastRows[0].lactationMultiplier = 3;

			wolfPlayer = new Player();
			createCock(CockTypesEnum.WOLF, wolfPlayer);
			wolfPlayer.face.type = Face.WOLF;
			wolfPlayer.ears.type = Ears.WOLF;
			wolfPlayer.tail.type = Tail.WOLF;
			wolfPlayer.lowerBody.type = LowerBody.WOLF;
			wolfPlayer.eyes.type = Eyes.WOLF;
			wolfPlayer.skin.type = Skin.FUR;

			dogPlayer = new Player();
			createCock(CockTypesEnum.DOG, dogPlayer);
			dogPlayer.face.type = Face.DOG;
			dogPlayer.ears.type = Ears.DOG;
			dogPlayer.tail.type = Tail.DOG;
			dogPlayer.arms.setType(Arms.DOG);
			dogPlayer.lowerBody.type = LowerBody.DOG;
			dogPlayer.skin.type = Skin.FUR;

			mutantPlayer = new Player();
			createBreastRows(2, mutantPlayer);
			mutantPlayer.breastRows[0].fuckable = true;
			mutantPlayer.createCock();
			mutantPlayer.createCock();
			mutantPlayer.createVagina();
			
			cut = new DummyPlayer();
			cut.HP = 1;
			cut.tou = 100;
		}

		[Test]
		public function testRedPandaScore():void
		{
			var redPandaPlayer:Player = new Player();
			redPandaPlayer.ears.type = Ears.RED_PANDA;
			redPandaPlayer.tail.type = Tail.RED_PANDA;
			redPandaPlayer.arms.type = Arms.RED_PANDA;
			redPandaPlayer.face.type = Face.RED_PANDA;
			redPandaPlayer.lowerBody.type = LowerBody.RED_PANDA;
			redPandaPlayer.skin.type = Skin.FUR;
			redPandaPlayer.underBody.type = UnderBody.FURRY;
			redPandaPlayer.underBody.skin.type = Skin.FUR;

			assertThat(redPandaPlayer.redPandaScore(), greaterThan(0));
		}

		[Test]
		public function testCockatriceScore():void
		{
			var cockatricePlayer:Player = new Player();
			cockatricePlayer.ears.type = Ears.COCKATRICE;
			cockatricePlayer.tail.type = Tail.COCKATRICE;
			cockatricePlayer.lowerBody.type = LowerBody.COCKATRICE;
			cockatricePlayer.face.type = Face.COCKATRICE;
			cockatricePlayer.eyes.type = Eyes.COCKATRICE;
			cockatricePlayer.arms.type = Arms.COCKATRICE;
			cockatricePlayer.antennae.type = Antennae.COCKATRICE;
			cockatricePlayer.neck.type = Neck.COCKATRICE;
			cockatricePlayer.tongue.type = Tongue.LIZARD;
			cockatricePlayer.wings.type = Wings.FEATHERED_LARGE;
			cockatricePlayer.skin.type = Skin.LIZARD_SCALES;
			cockatricePlayer.underBody.type = UnderBody.COCKATRICE;
			createCock(CockTypesEnum.LIZARD, cockatricePlayer);

			assertThat(cockatricePlayer.cockatriceScore(), greaterThan(0));
		}

		[Test]
		public function testNormalImpScore():void
		{
			removeAllBreasts(impPlayer);
			impPlayer.tallness = 30;

			assertThat(impPlayer.impScore(), greaterThan(0));
		}

		[Test]
		public function testTitsImpScore():void
		{
			removeAllBreasts(impPlayer);
			impPlayer.tallness = 50;
			impPlayer.breastRows[0].breastRating = 5;
			impPlayer.createBreastRow(5);
			impPlayer.createBreastRow(5);
			impPlayer.createBreastRow(5);

			assertThat(impPlayer.impScore(), greaterThan(0));
		}

		[Test]
		public function testDemonScore():void
		{
			var demonPlayer:Player = new Player();
			demonPlayer.horns.type = Horns.DEMON;
			demonPlayer.horns.value = 12;
			demonPlayer.tail.type = Tail.DEMONIC;
			demonPlayer.wings.type = Wings.BAT_LIKE_LARGE;
			demonPlayer.skin.type = Skin.PLAIN;
			demonPlayer.cor = 100;
			demonPlayer.face.type = Face.HUMAN;
			demonPlayer.lowerBody.type = LowerBody.DEMONIC_CLAWS;
			createCock(CockTypesEnum.DEMON, demonPlayer);

			assertThat(demonPlayer.demonScore(), greaterThan(0));
		}

		[Test]
		public function testHumanScore():void
		{
			var humanPlayer:Player = new Player();
			humanPlayer.face.type = Face.HUMAN;
			humanPlayer.skin.type = Skin.PLAIN;
			humanPlayer.horns.type = Horns.NONE;
			humanPlayer.tail.type = Tail.NONE;
			humanPlayer.wings.type = Wings.NONE;
			humanPlayer.lowerBody.type = LowerBody.HUMAN;
			humanPlayer.skin.type = Skin.PLAIN;
			createCock(CockTypesEnum.HUMAN, humanPlayer);
			removeAllBreasts(humanPlayer); // auto-creates a breast row, if none exists

			assertThat(humanPlayer.humanScore(), greaterThan(0));
		}

		[Test]
		public function testMinoScore():void
		{
			removeAllVags(minoPlayer);

			assertThat(minoPlayer.minoScore(), greaterThan(0));
		}


		[Test]
		public function testVagMinoScore():void
		{
			minoPlayer.createVagina();

			assertThat(minoPlayer.minoScore(), greaterThan(0));
		}

		[Test]
		public function testCowScore():void
		{
			cowPlayer.face.type = Face.HUMAN;

			assertThat(cowPlayer.cowScore(), greaterThan(0));
		}

		[Test]
		public function testCowFaceCowScore():void
		{
			cowPlayer.face.type = Face.COW_MINOTAUR;

			assertThat(cowPlayer.cowScore(), greaterThan(0));
		}

		[Test]
		public function testSandTrapScore():void
		{
			var sandTrapPlayer:Player = new Player();
			createStatusEffect(StatusEffects.BlackNipples, sandTrapPlayer);
			createStatusEffect(StatusEffects.Uniball, sandTrapPlayer);
			sandTrapPlayer.createVagina();
			sandTrapPlayer.vaginaType(5);
			sandTrapPlayer.eyes.type = Eyes.BLACK_EYES_SAND_TRAP;
			sandTrapPlayer.wings.type = Wings.GIANT_DRAGONFLY;

			assertThat(sandTrapPlayer.sandTrapScore(), greaterThan(0));
		}

		[Test]
		public function testBeeScore():void
		{
			var beePlayer:Player = new Player();
			beePlayer.hair.color = "black and yellow";
			beePlayer.antennae.type = Antennae.BEE;
			beePlayer.face.type = Face.HUMAN;
			beePlayer.arms.type = Arms.BEE;
			beePlayer.lowerBody.type = LowerBody.BEE;
			beePlayer.createVagina();
			beePlayer.tail.type = Tail.BEE_ABDOMEN;
			beePlayer.wings.type = Wings.BEE_LIKE_SMALL;

			assertThat(beePlayer.beeScore(), greaterThan(0));
		}

		[Test]
		public function testFerretScore():void
		{
			var ferretPlayer:Player = new Player();
			ferretPlayer.face.type = Face.FERRET;
			ferretPlayer.ears.type = Ears.FERRET;
			ferretPlayer.tail.type = Tail.FERRET;
			ferretPlayer.lowerBody.type = LowerBody.FERRET;
			ferretPlayer.arms.type = Arms.FERRET;
			ferretPlayer.skin.type = Skin.FUR;

			assertThat(ferretPlayer.ferretScore(), greaterThan(0));
		}

		[Test]
		public function testMaleWolfScore():void
		{
			removeAllBreasts(wolfPlayer);

			assertThat(wolfPlayer.wolfScore(), greaterThan(0));
		}

		[Test]
		public function testHermWolfScore():void
		{
			createBreastRows(4, wolfPlayer);

			assertThat(wolfPlayer.wolfScore(), greaterThan(0));
		}

		[Test]
		public function testHermLottaBreastRowsWolfScore():void
		{
			createMaxBreastRows(wolfPlayer);

			assertThat(wolfPlayer.wolfScore(), greaterThan(0));
		}

		[Test]
		public function testMaleDogScore():void
		{
			removeAllBreasts(dogPlayer);

			assertThat(dogPlayer.dogScore(), greaterThan(0));
		}

		[Test]
		public function testHermDogScore():void
		{
			createBreastRows(3, dogPlayer);

			assertThat(dogPlayer.dogScore(), greaterThan(0));
		}

		[Test]
		public function testHermLottaBreastRowsDogScore():void
		{
			createMaxBreastRows(dogPlayer);

			assertThat(dogPlayer.dogScore(), greaterThan(0));
		}

		[Test]
		public function testMouseScore():void
		{
			var mousePlayer:Player = new Player();
			mousePlayer.ears.type = Ears.MOUSE;
			mousePlayer.tail.type = Tail.MOUSE;
			mousePlayer.face.type = Face.MOUSE;
			mousePlayer.skin.type = Skin.FUR;
			mousePlayer.tallness = 30;

			assertThat(mousePlayer.mouseScore(), greaterThan(0));
		}

		[Test]
		public function testRaccoonScore():void
		{
			var raccoonPlayer:Player = new Player();
			raccoonPlayer.face.type = Face.RACCOON;
			raccoonPlayer.ears.type = Ears.RACCOON;
			raccoonPlayer.tail.type = Tail.RACCOON;
			raccoonPlayer.lowerBody.type = LowerBody.RACCOON;
			raccoonPlayer.balls = 2;
			raccoonPlayer.skin.type = Skin.FUR;

			assertThat(raccoonPlayer.raccoonScore(), greaterThan(0));
		}

		[Test]
		public function testFoxScore():void
		{
			// No need to test variations of breastrow-count yet
			var foxPlayer:Player = new Player();
			createBreastRows(4, foxPlayer);
			createCock(CockTypesEnum.FOX, foxPlayer);
			foxPlayer.face.type = Face.FOX;
			foxPlayer.ears.type = Ears.FOX;
			foxPlayer.tail.type = Tail.FOX;
			foxPlayer.lowerBody.type = LowerBody.FOX;
			foxPlayer.arms.setType(Arms.FOX);
			foxPlayer.skin.type = Skin.FUR;

			assertThat(foxPlayer.foxScore(), greaterThan(0));
		}

		[Test]
		public function testCatScore():void
		{
			// No need to test variations of breastrow-count yet
			var catPlayer:Player = new Player();
			createBreastRows(3, catPlayer);
			createCock(CockTypesEnum.CAT, catPlayer);
			catPlayer.face.type = Face.CAT;
			catPlayer.ears.type = Ears.CAT;
			catPlayer.tail.type = Tail.CAT;
			catPlayer.lowerBody.type = LowerBody.CAT;
			catPlayer.arms.setType(Arms.CAT);
			catPlayer.skin.type = Skin.FUR;

			assertThat(catPlayer.catScore(), greaterThan(0));
		}

		[Test]
		public function testLizardScore():void
		{
			var lizardPlayer:Player = new Player();
			lizardPlayer.face.type = Face.LIZARD;
			lizardPlayer.ears.type = Ears.LIZARD;
			lizardPlayer.tail.type = Tail.LIZARD;
			lizardPlayer.lowerBody.type = LowerBody.LIZARD;
			lizardPlayer.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
			lizardPlayer.arms.setType(Arms.PREDATOR, Claws.LIZARD);
			lizardPlayer.tongue.type = Tongue.LIZARD;
			createCock(CockTypesEnum.LIZARD, lizardPlayer);
			createCock(CockTypesEnum.LIZARD, lizardPlayer);
			lizardPlayer.eyes.type = Eyes.LIZARD;
			lizardPlayer.skin.type = Skin.LIZARD_SCALES;

			assertThat(lizardPlayer.lizardScore(), greaterThan(0));
		}

		[Test]
		public function testSpiderScore():void
		{
			var driderPlayer:Player = new Player();
			driderPlayer.eyes.setProps({type: Eyes.SPIDER, count: 4});
			driderPlayer.face.type = Face.SPIDER_FANGS;
			driderPlayer.arms.type = Arms.SPIDER;
			driderPlayer.lowerBody.type = LowerBody.DRIDER;
			driderPlayer.tail.type = Tail.SPIDER_ABDOMEN;
			driderPlayer.skin.type = Skin.PLAIN;

			assertThat(driderPlayer.spiderScore(), greaterThan(0));
		}

		[Test]
		public function testHorseScore():void
		{
			var horsePlayer:Player = new Player();
			createCock(CockTypesEnum.HORSE, horsePlayer);
			horsePlayer.face.type = Face.HORSE;
			horsePlayer.ears.type = Ears.HORSE;
			horsePlayer.tail.type = Tail.HORSE;
			horsePlayer.lowerBody.type = LowerBody.HOOFED;
			horsePlayer.skin.type = Skin.FUR;

			assertThat(horsePlayer.horseScore(), greaterThan(0));
		}

		[Test]
		public function testKitsuneScore():void
		{
			// Avoiding randomness for hair and fur colors now. Maybe later?
			var kitsunePlayer:Player = new Player();
			kitsunePlayer.createVagina();
			kitsunePlayer.createStatusEffect(StatusEffects.BonusVCapacity, 8000, 0, 0, 0);
			kitsunePlayer.ears.type = Ears.FOX;
			kitsunePlayer.tail.setProps({type: Tail.FOX, venom: 9});
			kitsunePlayer.face.type = Face.FOX;
			kitsunePlayer.hair.color = ColorLists.ELDER_KITSUNE[0];
			kitsunePlayer.skin.type = Skin.FUR;
			kitsunePlayer.setFurColor([ColorLists.ELDER_KITSUNE[0]], {type: UnderBody.FURRY}, true);
			kitsunePlayer.femininity = 40;
			kitsunePlayer.lowerBody.type = LowerBody.FOX;

			assertThat(kitsunePlayer.kitsuneScore(), greaterThan(0));
		}

		[Test]
		public function testDragonScore():void
		{
			var dragonPlayer:Player = new Player();
			createCock(CockTypesEnum.DRAGON, dragonPlayer);
			createPerk(PerkLib.Dragonfire, dragonPlayer);
			dragonPlayer.face.type = Face.DRAGON;
			dragonPlayer.ears.type = Ears.DRAGON;
			dragonPlayer.tail.type = Tail.DRACONIC;
			dragonPlayer.tongue.type = Tongue.DRACONIC;
			dragonPlayer.wings.type = Wings.DRACONIC_LARGE;
			dragonPlayer.lowerBody.type = LowerBody.DRAGON;
			dragonPlayer.skin.type = Skin.DRAGON_SCALES;
			dragonPlayer.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
			dragonPlayer.arms.setType(Arms.PREDATOR, Claws.DRAGON);
			dragonPlayer.eyes.type = Eyes.DRAGON;
			dragonPlayer.neck.modify(Infinity, Neck.DRACONIC);
			dragonPlayer.rearBody.type = RearBody.DRACONIC_SPIKES;

			assertThat(dragonPlayer.dragonScore(), greaterThan(0));
		}

		[Test]
		public function testGoblinScore():void
		{
			var goblinPlayer:Player = new Player();
			goblinPlayer.createVagina();
			goblinPlayer.ears.type = Ears.ELFIN;
			goblinPlayer.skin.tone = ColorLists.GOBLIN_SKIN[0];
			goblinPlayer.face.type = Face.HUMAN;
			goblinPlayer.tallness = 40;
			goblinPlayer.lowerBody.type = LowerBody.HUMAN;

			assertThat(goblinPlayer.goblinScore(), greaterThan(0));
		}

		[Test]
		public function testGooScore():void
		{
			var gooPlayer:Player = new Player();
			gooPlayer.hair.type = Hair.GOO;
			gooPlayer.skin.adj = "slimy";
			gooPlayer.lowerBody.type = LowerBody.GOO;
			gooPlayer.createVagina();
			gooPlayer.createStatusEffect(StatusEffects.BonusVCapacity, 9000, 0, 0, 0);
			gooPlayer.createStatusEffect(StatusEffects.SlimeCraving, 0, 0, 0, 1);

			assertThat(gooPlayer.gooScore(), greaterThan(0));
		}

		[Test]
		public function testNagaScore():void
		{
			var nagaPlayer:Player = new Player();
			nagaPlayer.face.type = Face.SNAKE_FANGS;
			nagaPlayer.tongue.type = Tongue.SNAKE;
			nagaPlayer.lowerBody.type = LowerBody.NAGA; // Not included in nagaScore, but just in case ...

			assertThat(nagaPlayer.nagaScore(), greaterThan(0));
		}

		[Test]
		public function testBunnyScore():void
		{
			var bunnyPlayer:Player = new Player();
			bunnyPlayer.face.type = Face.BUNNY;
			bunnyPlayer.tail.type = Tail.RABBIT;
			bunnyPlayer.ears.type = Ears.BUNNY;
			bunnyPlayer.lowerBody.type = LowerBody.BUNNY;

			assertThat(bunnyPlayer.bunnyScore(), greaterThan(0));
		}

		[Test]
		public function testHarpyScore():void
		{
			var harpyPlayer:Player = new Player();
			harpyPlayer.arms.type = Arms.HARPY;
			harpyPlayer.hair.type = Hair.FEATHER;
			harpyPlayer.wings.type = Wings.FEATHERED_LARGE;
			harpyPlayer.tail.type = Tail.HARPY;
			harpyPlayer.lowerBody.type = LowerBody.HARPY;

			assertThat(harpyPlayer.harpyScore(), greaterThan(0));
		}

		[Test]
		public function testKangaScore():void
		{
			var kangaPlayer:Player = new Player();
			createCock(CockTypesEnum.KANGAROO, kangaPlayer);
			kangaPlayer.ears.type = Ears.KANGAROO;
			kangaPlayer.tail.type = Tail.KANGAROO;
			kangaPlayer.face.type = Face.KANGAROO;
			kangaPlayer.lowerBody.type = LowerBody.KANGAROO;
			kangaPlayer.skin.type = Skin.FUR;

			assertThat(kangaPlayer.kangaScore(), greaterThan(0));
		}

		[Test]
		public function testSheepScore():void
		{
			var sheepPlayer:Player = new Player();
			sheepPlayer.ears.type = Ears.SHEEP;
			sheepPlayer.horns.type = Horns.SHEEP;
			sheepPlayer.tail.type = Tail.SHEEP;
			sheepPlayer.lowerBody.setProps({type: LowerBody.CLOVEN_HOOFED, legCount: 2});
			sheepPlayer.hair.type = Hair.WOOL;
			sheepPlayer.skin.type = Skin.WOOL;

			assertThat(sheepPlayer.sheepScore(), greaterThan(0));
		}

		[Test]
		public function testSharkScore():void
		{
			var sharkPlayer:Player = new Player();
			sharkPlayer.face.type = Face.SHARK_TEETH;
			sharkPlayer.gills.type = Gills.FISH;
			sharkPlayer.rearBody.type = RearBody.SHARK_FIN;
			sharkPlayer.tail.type = Tail.SHARK;

			assertThat(sharkPlayer.sharkScore(), greaterThan(0));
		}

		[Test]
		public function testMutantScore():void
		{
			mutantPlayer.face.type = Face.WOLF;
			mutantPlayer.tail.type = Tail.DRACONIC;
			mutantPlayer.skin.type = Skin.PLAIN;

			assertThat(mutantPlayer.mutantScore(), greaterThan(0));
		}

		[Test]
		public function testHorseMutantScore():void
		{
			mutantPlayer.face.type = Face.HORSE;
			mutantPlayer.tail.type = Tail.HORSE;
			mutantPlayer.skin.type = Skin.FUR;

			assertThat(mutantPlayer.mutantScore(), greaterThan(0));
		}

		[Test]
		public function testDogMutantScore():void
		{
			mutantPlayer.face.type = Face.DOG;
			mutantPlayer.tail.type = Tail.DOG;
			mutantPlayer.skin.type = Skin.FUR;

			assertThat(mutantPlayer.mutantScore(), greaterThan(0));
		}

		[Test]
		public function testSalamanderScore():void
		{
			var salamanderPlayer:Player = new Player();
			createPerk(PerkLib.Lustzerker, salamanderPlayer);
			createCock(CockTypesEnum.LIZARD, salamanderPlayer);
			salamanderPlayer.arms.type = Arms.SALAMANDER;
			salamanderPlayer.lowerBody.type = LowerBody.SALAMANDER;
			salamanderPlayer.tail.type = Tail.SALAMANDER;

			assertThat(salamanderPlayer.salamanderScore(), greaterThan(0));
		}

		[Test]
		public function testSirenScore():void
		{
			var sirenPlayer:Player = new Player();
			sirenPlayer.createVagina();
			sirenPlayer.face.type = Face.SHARK_TEETH;
			sirenPlayer.tail.type = Tail.SHARK;
			sirenPlayer.wings.type = Wings.FEATHERED_LARGE;
			sirenPlayer.arms.type = Arms.HARPY;

			assertThat(sirenPlayer.sirenScore(), greaterThan(0));
		}

		[Test]
		public function testPigScore():void
		{
			var pigPlayer:Player = new Player();
			createCock(CockTypesEnum.PIG, pigPlayer);
			pigPlayer.ears.type = Ears.PIG;
			pigPlayer.tail.type = Tail.PIG;
			pigPlayer.face.type = Face.PIG;
			pigPlayer.lowerBody.type = LowerBody.CLOVEN_HOOFED;

			assertThat(pigPlayer.pigScore(), greaterThan(0));
		}

		[Test]
		public function testSatyrScore():void
		{
			var satyrPlayer:Player = new Player();
			satyrPlayer.lowerBody.type = LowerBody.CLOVEN_HOOFED;
			satyrPlayer.tail.type = Tail.GOAT;
			satyrPlayer.ears.type = Ears.ELFIN;
			satyrPlayer.face.type = Face.HUMAN;
			satyrPlayer.createCock();
			satyrPlayer.balls = 2;
			satyrPlayer.ballSize = 3;

			assertThat(satyrPlayer.satyrScore(), greaterThanOrEqualTo(4)); // There was an issue with the satyrScore producing a too low score
		}

		[Test]
		public function testRhinoScore():void
		{
			var rhinoPlayer:Player = new Player();
			createCock(CockTypesEnum.RHINO, rhinoPlayer);
			rhinoPlayer.ears.type = Ears.RHINO;
			rhinoPlayer.tail.type = Tail.RHINO;
			rhinoPlayer.face.type = Face.RHINO;
			rhinoPlayer.horns.type = Horns.RHINO;
			rhinoPlayer.skin.tone = "gray";

			assertThat(rhinoPlayer.rhinoScore(), greaterThan(0));
		}

		[Test]
		public function testEchidnaScore():void
		{
			var echidnaPlayer:Player = new Player();
			createCock(CockTypesEnum.ECHIDNA, echidnaPlayer);
			echidnaPlayer.ears.type = Ears.ECHIDNA;
			echidnaPlayer.tail.type = Tail.ECHIDNA;
			echidnaPlayer.face.type = Face.ECHIDNA;
			echidnaPlayer.tongue.type = Tongue.ECHIDNA;
			echidnaPlayer.lowerBody.type = LowerBody.ECHIDNA;
			echidnaPlayer.skin.type = Skin.FUR;

			assertThat(echidnaPlayer.echidnaScore(), greaterThan(0));
		}

		[Test]
		public function testDeerScore():void
		{
			var deerPlayer:Player = new Player();
			createCock(CockTypesEnum.HORSE, deerPlayer);
			deerPlayer.ears.type = Ears.DEER;
			deerPlayer.tail.type = Tail.DEER;
			deerPlayer.face.type = Face.DEER;
			deerPlayer.lowerBody.type = LowerBody.CLOVEN_HOOFED;
			deerPlayer.horns.setProps({type: Horns.ANTLERS, value: 4});
			deerPlayer.skin.type = Skin.FUR;

			assertThat(deerPlayer.deerScore(), greaterThan(0));
		}

		[Test]
		public function testDragonneScore():void
		{
			var dragonnePlayer:Player = new Player();
			dragonnePlayer.face.type = Face.CAT;
			dragonnePlayer.ears.type = Ears.CAT;
			dragonnePlayer.tail.type = Tail.CAT;
			dragonnePlayer.tongue.type = Tongue.DRACONIC;
			dragonnePlayer.wings.type = Wings.DRACONIC_LARGE;
			dragonnePlayer.lowerBody.type = LowerBody.CAT;
			dragonnePlayer.skin.type = Skin.DRAGON_SCALES;

			assertThat(dragonnePlayer.dragonneScore(), greaterThan(0));
		}

		[Test]
		public function testManticoreScore():void
		{
			var manticorePlayer:Player = new Player();
			manticorePlayer.face.type = Face.CAT;
			manticorePlayer.ears.type = Ears.CAT;
			manticorePlayer.tail.type = Tail.SCORPION;
			manticorePlayer.lowerBody.type = LowerBody.CAT;
			manticorePlayer.horns.type = Horns.DEMON;
			manticorePlayer.wings.type = Wings.BAT_LIKE_LARGE;
			manticorePlayer.skin.type = Skin.FUR;

			assertThat(manticorePlayer.manticoreScore(), greaterThan(0));
		}

		[Test]
		public function testBimboScore():void
		{
			var bimboPlayer:Player = new Player();
			createPerk(PerkLib.BimboBrains, bimboPlayer);
			createPerk(PerkLib.BimboBody, bimboPlayer);
			bimboPlayer.createVagina(true, VaginaClass.WETNESS_SLICK);
			bimboPlayer.createBreastRow(10);
			bimboPlayer.setArmor(kGAMECLASS.armors.BIMBOSK);
			kGAMECLASS.flags[kFLAGS.BIMBOSKIRT_MINIMUM_LUST] = 30;
			bimboPlayer.femininity = 100;
			bimboPlayer.hips.rating = 10;
			bimboPlayer.butt.rating = 10;
			bimboPlayer.tone = 10;
			bimboPlayer.hair.setProps({color: "platinum blonde", length: 12});
			bimboPlayer.inte = 10;

			assertThat(bimboPlayer.bimboScore(), greaterThan(0));
		}
		
		[Test]
		public function hpChangeNotifyNoChange(): void {
			cut.HPChangeNotify(0);
			
			assertThat(cut.collectedOutput, emptyArray());
		}
		
		[Test]
		public function hpChangeNotifyNoChangeOverMaxHp(): void {
			cut.HP = HP_OVER_HEAL;
			
			cut.HPChangeNotify(0);
			
			assertThat(cut.collectedOutput, hasItem(startsWith("You're as healthy as you can be.")));
		}
		
		[Test]
		public function hpChangeNotifyHeal(): void {
			cut.HPChangeNotify(1);
			
			assertThat(cut.collectedOutput, hasItem(startsWith("You gain")));
		}
		
		[Test]
		public function hpChangeNotifyHealOverMaxHp(): void {
			cut.HP = HP_OVER_HEAL;
			
			cut.HPChangeNotify(1);
			
			assertThat(cut.collectedOutput, hasItem(startsWith("Your HP maxes out at")));
		}
		
		[Test]
		public function hpChangeNotifyDamage(): void {
			cut.HPChangeNotify(-1);
			
			assertThat(cut.collectedOutput, hasItem(containsString("damage.")));
		}
		
		[Test]
		public function hpChangeNotifyDamageHpBelowZero(): void {
			cut.HP = -1;
			
			cut.HPChangeNotify(-1);
			
			assertThat(cut.collectedOutput, hasItem(containsString("damage, dropping your HP to 0.")));
		}
		
		[Test]
		public function hpChangeZeroNoDelta(): void {
			assertThat(cut.HPChange(0, false), equalTo(0));
		}
		
		[Test]
		public function hpChangeHealerBoost(): void {
			cut.createPerk(PerkLib.HistoryHealer, 0, 0, 0, 0);
			
			assertThat(cut.HPChange(100, false), equalTo(120));
		}
		
		[Test]
		public function hpChangeNurseOutfitBoost(): void {
			cut.setArmor(new ArmorLib().NURSECL);
			
			assertThat(cut.HPChange(100, false), equalTo(110));
		}
		
		[Test]
		public function hpChangeOverHeal(): void {
			assertThat(cut.HPChange(HP_OVER_HEAL, false), equalTo(249));
		}
		
		[Test]
		public function hpChangeOverHealPlayerHp(): void {
			cut.HPChange(HP_OVER_HEAL, false);
			
			assertThat(cut.HP, equalTo(PLAYER_MAX_HP));
		}
		
		[Test]
		public function hpChangeOverHealDisplayHpChange(): void {
			cut.HPChange(HP_OVER_HEAL, true);
			
			assertThat(cut.calls, arrayWithSize(1));
			assertThat(cut.calls, hasItem(equalTo(HP_OVER_HEAL)));
		}
		
		[Test]
		public function hpChangePlayerHpOverMaxDelta(): void {
			cut.HP = HP_OVER_HEAL;
			
			assertThat(cut.HPChange(HP_OVER_HEAL, false), equalTo(0));
		}
		
		[Test]
		public function hpChangePlayerHpOverMaxPlayerHp(): void {
			cut.HP = HP_OVER_HEAL;
			
			cut.HPChange(HP_OVER_HEAL, false);
			
			assertThat(cut.HP, equalTo(1000));
		}
		
		[Test]
		public function hpChangePlayerHpOverMaxDisplayHpChange(): void {
			cut.HP = HP_OVER_HEAL;
			
			cut.HPChange(HP_OVER_HEAL, true);
			
			assertThat(cut.calls, arrayWithSize(1));
			assertThat(cut.calls, hasItem(equalTo(HP_OVER_HEAL)));
		}
		
		[Test]
		public function hpChangeHealDisplayHpChange(): void {
			cut.HPChange(1, true);
			
			assertThat(cut.calls, arrayWithSize(1));
			assertThat(cut.calls, hasItem(equalTo(1)));
		}
		
		[Test]
		public function hpChangeHealPlayerHP(): void {
			cut.HPChange(1, true);
			
			assertThat(cut.HP, equalTo(2));
		}
		
		[Test]
		public function hpChangeDamageDisplayHpChange(): void {
			cut.HP = 50;
			
			cut.HPChange(-1, true);
			
			assertThat(cut.calls, arrayWithSize(1));
			assertThat(cut.calls, hasItem(equalTo(-1)));
		}
		
		[Test]
		public function hpChangeDamagePlayerHp(): void {
			cut.HP = 50;
			
			cut.HPChange(-1, false);
			
			assertThat(cut.HP, equalTo(49));
		}
		
		[Test]
		public function hpChangeDamageBelowZeroDisplayHpChange(): void {
			cut.HPChange(-HP_OVER_HEAL, true);
			
			assertThat(cut.calls, arrayWithSize(1));
			assertThat(cut.calls, hasItem(equalTo(-HP_OVER_HEAL)));
		}
		
		[Test]
		public function hpChangeDamageBelowZeroPlayerHp(): void {
			cut.HPChange(-HP_OVER_HEAL, false);
			
			assertThat(cut.HP, equalTo(0));
		}
	}
}

import classes.Player;

/**
 * Yes, i'm a lazy git.
 */
class DummyPlayer extends Player {
	public var calls:Vector.<Number> = new Vector.<Number>();
	public var collectedOutput:Vector.<String> = new Vector.<String>();

	/**
	 * Intercept calls to HPChangeNotify so we can sense them in tests.
	 * 
	 * @param	changeNum the value of the HP change?
	 */
	override public function HPChangeNotify(changeNum:Number):void {
		calls.push(changeNum);
		super.HPChangeNotify(changeNum);
	}
	
	/**
	 * Redirect output to a vector instead of displaying it on the GUI.
	 * @param	text to store
	 */
	override protected function outputText(text:String):void {
		collectedOutput.push(text);
	}
}