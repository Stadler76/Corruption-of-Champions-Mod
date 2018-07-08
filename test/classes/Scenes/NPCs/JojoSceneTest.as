package classes.Scenes.NPCs{
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.PregnancyProgression;
	import classes.helper.DummyOutput;
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
     
    public class JojoSceneTest {
		private const ALWAYS_EXPECTED_TEXT:String = "You crawl further up his body and grin down at him as you press";
		private const WET_ONLY_EXPECTED_TEXT:String = "You moan as he works, your juices flowing liberally across his muzzle and into his";
		
        private var cut:JojoSceneForTest;
		private var player:Player;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
         
        [Before]
        public function setUp():void {  
			cut = new JojoSceneForTest(new PregnancyProgression(), new DummyOutput());
			player = new Player();
			kGAMECLASS.player = player;
			kGAMECLASS.flags[kFLAGS.JOJO_STATUS] = 1;
        }
		
		[Test] 
        public function testCorruptJojoVaginalSmotherNotWetEnough():void {
			player.createVagina();
			
			cut.testCorruptJojoVaginalSmother();
			
			assertThat(cut.collectedOutput, hasItem(startsWith(ALWAYS_EXPECTED_TEXT)));
			assertThat(cut.collectedOutput, not(hasItem(startsWith(WET_ONLY_EXPECTED_TEXT))));
		}
		
				
		[Test] 
        public function testCorruptJojoVaginalSmotherEnough():void {
			player.createVagina(false,5,1);
			
			cut.testCorruptJojoVaginalSmother();
			
			assertThat(cut.collectedOutput, hasItem(startsWith(ALWAYS_EXPECTED_TEXT)));
			assertThat(cut.collectedOutput, hasItem(startsWith(WET_ONLY_EXPECTED_TEXT)));
		}
		
		[Test]
		public function jojoCorruptFemalePCrapeUsesCockArea(): void {
			kGAMECLASS.flags[kFLAGS.JOJO_STATUS] = 5;
			kGAMECLASS.monster = new Jojo();
			
			player.createVagina(false, 1, 2);
			player.lust = player.maxLust();
			
			cut.loseToJojo();
			
			assertThat(player.vaginas[0].vaginalLooseness, equalTo(3));
		}
		
		[Test]
		public function jojoNotFullyCorrupted(): void {
			assertThat(cut.isJojoCorrupted(), equalTo(false));
		}
		
		[Test]
		public function jojoFullyCorrupted(): void {
			kGAMECLASS.flags[kFLAGS.JOJO_STATUS] = 6;
			
			assertThat(cut.isJojoCorrupted(), equalTo(true));
		}
	}
}

import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.PregnancyProgression;
import classes.internals.GuiOutput;

class JojoSceneForTest extends JojoScene {
	public var collectedOutput:Vector.<String> = new Vector.<String>();
	
	public function JojoSceneForTest(pregnancyProgression:PregnancyProgression, output:GuiOutput) 
	{
		super(pregnancyProgression, output);
	}
	
	public function testCorruptJojoVaginalSmother():void {
		corruptJojoVaginalSmother();
	}
	
	override protected function outputText(output:String):void {
		collectedOutput.push(output);
	}
}
