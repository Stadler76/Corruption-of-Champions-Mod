package classes.Scenes.Areas.Bog
{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.helper.StageLocator;
	
	public class PhoukaSceneTest
	{
		private static const SCENE_TEXT:String = "You scream as the ";
		
		private var cut:SceneForTest;
		private var player:Player;
		
		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
		public function setUp():void
		{
			player = new Player();
			player.createVagina();
			kGAMECLASS.player = player;
			
			cut = new SceneForTest(kGAMECLASS.pregnancyProgress);
		}
		
		[Test(description="Exposes bug #1116, sex scene skipped")]
		public function doNotClearSexScene():void {
			cut.horseScene();
			
			assertThat(cut.collectedOutput, hasItem(startsWith(SCENE_TEXT)));
		}
	}
}

import classes.Scenes.Areas.Bog.PhoukaScene;
import classes.Scenes.PregnancyProgression;

class SceneForTest extends PhoukaScene {
	public var collectedOutput:Vector.<String> = new Vector.<String>();

	public function SceneForTest(pregnancyProgression:PregnancyProgression) {
		super(pregnancyProgression);
	}
	
	public function horseScene():void {
		this.phoukaSexHorseChoice();
	}
	
	override protected function outputText(output:String):void {
		collectedOutput.push(output);
	}
	
	override protected function clearOutput():void {
		collectedOutput = new Vector.<String>();
	}
}
