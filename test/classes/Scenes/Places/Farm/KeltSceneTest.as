package classes.Scenes.Places.Farm
{
	import classes.Appearance;
	import classes.BodyParts.Butt;
	import classes.StatusEffects;
	import classes.helper.DummyOutput;
	import classes.helper.FireButtonEvent;
	import classes.internals.RandomNumberGenerator;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.helper.StageLocator;
	
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Output;
	
	public class KeltSceneTest
	{
		private static const EVENT_ITERATIONS:int = 5;
		
		private var cut:KeltScene;
		private var player:Player;
		private var fireButtons:FireButtonEvent;
		private var output:DummyOutput;
		
		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
		public function setUp():void
		{
			output = new DummyOutput();
			cut = new KeltScene(output);
			
			player = new Player();
			kGAMECLASS.player = player;
			
			player.createStatusEffect(StatusEffects.Kelt, 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.Kelt, 3, 3);
			
			fireButtons = new FireButtonEvent(kGAMECLASS.mainView, Output.MAX_BUTTON_INDEX);
		}
		
		[Test]
		public function keltCommentsOnPcDuringStrip():void
		{
			cut.keltEncounter();
			
			fireButtons.fireButtonClick(0);
			
			assertThat(output.collectedOutput, hasItem(startsWith("You are uncomfortable with the idea ")));
		}
	}
}
