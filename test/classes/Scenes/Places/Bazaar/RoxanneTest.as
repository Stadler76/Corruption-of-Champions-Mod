package classes.Scenes.Places.Bazaar{
	import classes.Appearance;
	import classes.helper.FireButtonEvent;
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
     
    public class RoxanneTest {
		private static const EVENT_ITERATIONS:int = 20;
		
        private var cut:RoxanneForTest;
		private var player:Player;
		private var fireButtons:FireButtonEvent;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
         
        [Before]
        public function setUp():void {  
			cut = new RoxanneForTest();
			player = new Player();
			kGAMECLASS.player = player;
			fireButtons = new FireButtonEvent(kGAMECLASS.mainView, CoC.MAX_BUTTON_INDEX);
			
			player.flags[kFLAGS.ROXANNE_TIME_WITHOUT_SEX] = 10;
			player.flags[kFLAGS.ROXANNE_DRINKING_CONTEST_LOSE_ON_PURPOSE] = 1;
			
			assertThat(player.ass.analLooseness, equalTo(0));
        }
		
		/**
		 * Many loops needed due to non-deterministic nature of buttChangeNoDisplay().
		 * @param	testFunction function to call multiple times
		 */
		private function repeatEvent(testFunction:Function):void {
			for (var i:int = 0; i < EVENT_ITERATIONS; i++) {
				testFunction();
			}
		}
		
		[Test(description="This test may show sporadic failures due to the use of rand() in the code under test")] 
        public function roxanneStretchLowTime():void {
			
			var testFunction:Function = function():void {
				cut.roxanneDrinkingContestTest();
				fireButtons.fireNextButtonEvent();
			};

			repeatEvent(testFunction);
			
			assertThat(kGAMECLASS.player.ass.analLooseness, equalTo(3));
			assertThat(cut.collectedOutput, hasItem(startsWith("A foot interposes itself")));
		}
		
		[Test] 
        public function roxanneResetCounterLowTime():void {
			cut.roxanneDrinkingContestTest();
			fireButtons.fireNextButtonEvent();

			assertThat(player.flags[kFLAGS.ROXANNE_TIME_WITHOUT_SEX],equalTo(1));
			assertThat(cut.collectedOutput, hasItem(startsWith("A foot interposes itself")));
		}
		
		private function setRoxanneLargeSize():void {
			player.flags[kFLAGS.ROXANNE_TIME_WITHOUT_SEX] = 290;
		}
		
		[Test(description="This test may show sporadic failures due to the use of rand() in the code under test")] 
        public function roxanneRepeatedStretchingWithHighTime():void {
			setRoxanneLargeSize();
			

			var testFunction:Function = function():void {
				cut.roxanneDrinkingContestTest();
				fireButtons.fireNextButtonEvent();
				setRoxanneLargeSize();
			};
			
			repeatEvent(testFunction);
			
			assertThat(kGAMECLASS.player.ass.analLooseness, equalTo(5));
			assertThat(cut.collectedOutput, hasItem(startsWith("Gosh, Roxanne is so strong...")));
		}
		
		[Test] 
        public function roxanneCounterResetWithHighTime():void {
			setRoxanneLargeSize();
			cut.roxanneDrinkingContestTest();
			fireButtons.fireNextButtonEvent();
			
			assertThat(player.flags[kFLAGS.ROXANNE_TIME_WITHOUT_SEX],equalTo(1));
			assertThat(cut.collectedOutput, hasItem(startsWith("Gosh, Roxanne is so strong...")));
		}
		
		[Ignore(description="Needs injected RNG")]
		[Test(description="This test may show sporadic failures due to the use of rand() in the code under test")] 
        public function roxanneRepeatedStretchingWithBigBooty():void {
			setRoxanneLargeSize();
			player.buttRating = Appearance.BUTT_RATING_EXPANSIVE;

			var testFunction:Function = function():void {
				cut.roxanneDrinkingContestTest();
				fireButtons.fireNextButtonEvent();
				setRoxanneLargeSize();
			};
			
			repeatEvent(testFunction);
			
			assertThat(kGAMECLASS.player.ass.analLooseness, equalTo(5));
			assertThat(cut.collectedOutput, hasItem(startsWith("Gods, your head is swimming!")));
		}
		
		[Ignore(description="Needs injected RNG")]
		[Test(description="This test may show sporadic failures due to the use of rand() in the code under test")] 
        public function roxanneCounterResetWithBigBooty():void {
			setRoxanneLargeSize();
			player.buttRating = Appearance.BUTT_RATING_EXPANSIVE;

			var testFunction:Function = function():void {
				cut.roxanneDrinkingContestTest();
				fireButtons.fireNextButtonEvent();
			};
			
			repeatEvent(testFunction);
			
			assertThat(player.flags[kFLAGS.ROXANNE_TIME_WITHOUT_SEX], equalTo(1));
			assertThat(cut.collectedOutput, hasItem(startsWith("Gods, your head is swimming!")));
		}
    }
}

import classes.Scenes.Places.Bazaar.Roxanne;

class RoxanneForTest extends Roxanne {
	public var collectedOutput:Vector.<String> = new Vector.<String>(); 

	public function roxanneDrinkingContestTest():void {
		super.roxanneDrinkingContest();
	}
	
	override protected function outputText(output:String, purgeText:Boolean = false, parseAsMarkdown:Boolean = false):void {
		collectedOutput.push(output);
	}
}