package classes.Scenes
{
	import classes.Scenes.Monsters.ImpScene;
	import classes.Scenes.NPCs.EmberScene;
	import classes.Scenes.NPCs.UrtaPregs;
	import classes.Scenes.Places.TelAdre;
	import classes.helper.DummyOutput;
	import classes.internals.GuiOutput;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.helper.StageLocator;
	
	import classes.DefaultDict;
	import classes.CoC;
	import classes.Player;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.PregnancyStore;
	import classes.StatusEffects;
	import classes.VaginaClass;
	import classes.StatusEffects;
	import classes.Scenes.Areas.Bog;
	
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class PregnancyProgressionVagBirthTest 
	{
		private static const COTTON_225_MESSAGE:String = "You stroke the orb and wonder with a half-grin if you'll have a daughter who takes after her 'daddy'.";
		private static const FROG_ANAL_8_MESSAGE:String = "Your gut churns, and with a squelching noise,";
		private static const HEAT_END:String = "It seems your heat has ended.";
		private static const IMP_BIRTH_MESSAGE:String = "The pain begins to subside as your delivery continues...";
		private static const MOUSE_BIRTH_MESSAGE:String = "Two emerge, then four, eight... you lose track.";
		
		private static var cut:PregProgForTest; // static so I can be lazy and don't need to pass it as a parameter
		private var player:Player;
		private var output:GuiOutput;
		
		private var pregnancyType:int;
		private var testFunction:Function;
		private var shouldDisplayText:Boolean;
		private var autoCreatesVaginaOnBirth:Boolean;
		private var childrenOnBirth:int;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
		public function setUp():void {
			player = new Player();
			player.createVagina(true, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_GAPING);
			player.hips.rating = 3;
			kGAMECLASS.player = player;
			
			kGAMECLASS.flags = new DefaultDict();
			kGAMECLASS.flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 100;
			kGAMECLASS.time.hours = 5;
			
			output = new DummyOutput();
			
			cut = new PregProgForTest();
			kGAMECLASS.createScenes(cut);
			kGAMECLASS.impScene = new ImpScene(cut, output);
		}
		
		/**
		 * The test functions are required due to birth scenes being anything but uniform.
		 */
		// function():void{assertThat(kGAMECLASS.player.fatigue, equalTo(40))}
		[Parameters]
		public static var testData:Array = [
			[PregnancyStore.PREGNANCY_FAERIE, function():void{assertThat(kGAMECLASS.flags[kFLAGS.BIRTHS_FAERIE], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_EMBER, function():void{assertThat(kGAMECLASS.flags[kFLAGS.EMBER_CHILDREN_MALES] + 
																			kGAMECLASS.flags[kFLAGS.EMBER_CHILDREN_FEMALES] +
																			kGAMECLASS.flags[kFLAGS.EMBER_CHILDREN_HERMS], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_URTA, function():void{assertThat(kGAMECLASS.flags[kFLAGS.URTA_TIMES_PC_BIRTHED], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_SAND_WITCH, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_SAND_WITCH))}, true, 1],
			[PregnancyStore.PREGNANCY_IZMA, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_IZMA))}, true, 1],
			[PregnancyStore.PREGNANCY_SPIDER, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_SPIDER))}, true, 1],
			[PregnancyStore.PREGNANCY_DRIDER_EGGS, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_DRIDER_EGGS))}, true, 1],
			[PregnancyStore.PREGNANCY_COTTON, function():void{assertThat(kGAMECLASS.flags[kFLAGS.COTTON_KID_COUNT], equalTo(1)); }, true, 1],
			[PregnancyStore.PREGNANCY_GOO_GIRL, function():void{assertThat(kGAMECLASS.flags[kFLAGS.GOOGIRL_BIRTHS], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_BASILISK, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_BASILISK))}, true, 1],
			[PregnancyStore.PREGNANCY_COCKATRICE, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_COCKATRICE))}, true, 1],
			[PregnancyStore.PREGNANCY_SATYR, function():void{assertThat(kGAMECLASS.flags[kFLAGS.SATYR_KIDS], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_FROG_GIRL, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_FROG_GIRL))}, true, 1],
			[PregnancyStore.PREGNANCY_BUNNY, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_BUNNY))}, true, 1],
			[PregnancyStore.PREGNANCY_ANEMONE, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_ANEMONE))}, true, 1],
			[PregnancyStore.PREGNANCY_IMP, function():void{assertThat(kGAMECLASS.player.statusEffectv1(StatusEffects.BirthedImps), equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_MARBLE, function():void{assertThat(kGAMECLASS.flags[kFLAGS.MARBLE_KIDS], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_MINOTAUR, function():void{assertThat(kGAMECLASS.flags[kFLAGS.MINOTAUR_SONS_PENDING], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_BENOIT, function():void{assertThat(kGAMECLASS.flags[kFLAGS.BENOIT_EGGS], equalTo(1))}, true, 2],
			[PregnancyStore.PREGNANCY_CENTAUR, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_CENTAUR))}, true, 1],
			[PregnancyStore.PREGNANCY_KELT, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_CENTAUR))}, true, 1],
			[PregnancyStore.PREGNANCY_HELL_HOUND, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_HELL_HOUND))}, true, 1],
			[PregnancyStore.PREGNANCY_MINERVA, function():void{assertThat(kGAMECLASS.flags[kFLAGS.TIMES_BIRTHED_SHARPIES], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_BEHEMOTH, function():void{assertThat(kGAMECLASS.flags[kFLAGS.BEHEMOTH_CHILDREN], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, function():void{assertThat(kGAMECLASS.player.hasStatusEffect(StatusEffects.LootEgg), equalTo(true))}, false, 1],
			[PregnancyStore.PREGNANCY_AMILY, function():void{assertThat(kGAMECLASS.flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS], equalTo(1))}, true, 1],
			[PregnancyStore.PREGNANCY_MOUSE, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_MOUSE))}, true, 1],
			[PregnancyStore.PREGNANCY_JOJO, function():void{assertThat(cut.senseVaginalBirth, hasItem(PregnancyStore.PREGNANCY_MOUSE))}, true, 1]
			];

		public function PregnancyProgressionVagBirthTest(pregnancyType:int, testFunction:Function, autoCreatesVaginaOnBirth:Boolean, childrenOnBirth:int):void {
			this.pregnancyType = pregnancyType;
			this.testFunction = testFunction;
			this.shouldDisplayText = shouldDisplayText;
			this.autoCreatesVaginaOnBirth = autoCreatesVaginaOnBirth;
			this.childrenOnBirth = childrenOnBirth;
		}
		
		[Test]
		public function giveBirth():void {
			player.knockUpForce(pregnancyType, 1);
			
			cut.updatePregnancy();
			
			testFunction();
		}
		
		[Test]
		public function displayText():void {
			player.knockUpForce(pregnancyType, 1);
			
			assertThat(cut.updatePregnancy(), equalTo(true));
		}
		
		[Test]
		public function pregnancyCleared():void {
			player.knockUpForce(pregnancyType, 1);
			
			cut.updatePregnancy();
			
			assertThat(player.isPregnant() , equalTo(false));
		}
		
		[Test]
		public function autoCreateVaginaOnBirth():void {
			player.knockUpForce(pregnancyType, 1);
			player.removeVagina();
			
			cut.updatePregnancy();
			
			assertThat(player.hasVagina() , equalTo(autoCreatesVaginaOnBirth));
		}
		
		[Test]
		public function chainDisplayUpdate():void {
			player.goIntoHeat(false);
			player.knockUpForce(pregnancyType, 1);
			
			assertThat(cut.updatePregnancy(), equalTo(true));
		}
		
		[Test]
		public function birthCounterIncremented():void {
			player.knockUpForce(pregnancyType, 1);
	
			cut.updatePregnancy();
			
			assertThat(player.statusEffectv1(StatusEffects.Birthed), equalTo(childrenOnBirth));
		}
	}
}

import classes.Scenes.PregnancyProgression;

class PregProgForTest extends PregnancyProgression {
	public var collectedOutput:Vector.<String> = new Vector.<String>(); 
	
	override protected function outputText(output:String):void {
		collectedOutput.push(output);
	}
	
	public function pregUpdate():Boolean {
		return updatePregnancy();
	}
}
