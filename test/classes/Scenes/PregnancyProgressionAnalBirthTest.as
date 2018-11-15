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
	import classes.Vagina;
	import classes.StatusEffects;
	import classes.Scenes.Areas.Bog;
	
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class PregnancyProgressionAnalBirthTest 
	{
		private static var cut:PregProgForTest; // static so I can be lazy and don't need to pass it as a parameter
		private var player:Player;
		private var output:GuiOutput;
		
		private var pregnancyType:int;

		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Parameters]
		public static var testData:Array =
		[
			[PregnancyStore.PREGNANCY_FROG_GIRL],
			[PregnancyStore.PREGNANCY_SATYR],
			[PregnancyStore.PREGNANCY_DRIDER_EGGS],
			[PregnancyStore.PREGNANCY_BEE_EGGS],
			[PregnancyStore.PREGNANCY_SANDTRAP_FERTILE],
		];

		public function PregnancyProgressionAnalBirthTest(pregnancyType:int):void
		{
			this.pregnancyType = pregnancyType;
		}
		
		[Before]
		public function setUp():void
		{
			player = new Player();
			kGAMECLASS.player = player;
			
			kGAMECLASS.flags = new DefaultDict();
			
			output = new DummyOutput();
			
			cut = new PregProgForTest();
			kGAMECLASS.createScenes(cut);
			
			player.buttKnockUpForce(pregnancyType, 1);
		}
		
		[Test]
		public function giveBirth():void
		{
			cut.updatePregnancy();
			
			assertThat(cut.senseAnalBirth, hasItem(pregnancyType));
		}
		
		[Test]
		public function displayText():void
		{
			assertThat(cut.updatePregnancy(), equalTo(true));
		}
		
		[Test]
		public function pregnancyCleared():void
		{
			cut.updatePregnancy();
			
			assertThat(player.isButtPregnant(), equalTo(false));
		}
		
		[Test]
		public function chainDisplayUpdate():void
		{
			player.goIntoHeat(false);
			player.buttKnockUpForce(pregnancyType, 1);
			
			assertThat(cut.updatePregnancy(), equalTo(true));
		}
	}
}

import classes.Scenes.PregnancyProgression;

class PregProgForTest extends PregnancyProgression
{
	public var collectedOutput:Vector.<String> = new Vector.<String>(); 
	
	override protected function outputText(output:String):void
	{
		collectedOutput.push(output);
	}
	
	public function pregUpdate():Boolean
	{
		return updatePregnancy();
	}
}
