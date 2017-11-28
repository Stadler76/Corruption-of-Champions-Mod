package classes.Scenes.Places.Bazaar{
	import classes.Appearance;
	import classes.BodyParts.Butt;
	import classes.helper.FireButtonEvent;
	import classes.internals.IRandomNumber;
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
		private static const EVENT_ITERATIONS:int = 5;
		
        private var cut:RoxanneForTest;
		private var player:Player;
		private var fireButtons:FireButtonEvent;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
         
        [Before]
        public function setUp():void {
			var rng:IRandomNumber = new RngMock();
			
			cut = new RoxanneForTest(rng);
			
			player = new Player();
			player.rng = rng;
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
		
		[Test] 
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
		
		[Test] 
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
		
		[Test] 
        public function roxanneRepeatedStretchingWithBigBooty():void {
			setRoxanneLargeSize();
			player.butt.rating = Butt.RATING_EXPANSIVE;

			var testFunction:Function = function():void {
				cut.roxanneDrinkingContestTest();
				fireButtons.fireNextButtonEvent();
				setRoxanneLargeSize();
			};
			
			repeatEvent(testFunction);
			
			assertThat(kGAMECLASS.player.ass.analLooseness, equalTo(5));
			assertThat(cut.collectedOutput, hasItem(startsWith("Gods, your head is swimming!")));
		}
		

		[Test] 
        public function roxanneCounterResetWithBigBooty():void {
			setRoxanneLargeSize();
			player.butt.rating = Butt.RATING_EXPANSIVE;

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
import classes.internals.IRandomNumber;

class RoxanneForTest extends Roxanne {
	public var collectedOutput:Vector.<String> = new Vector.<String>();
	
	public function RoxanneForTest(rng:IRandomNumber) 
	{
		super(rng);
	}

	public function roxanneDrinkingContestTest():void {
		super.roxanneDrinkingContest();
	}
	
	override protected function outputText(output:String):void {
		collectedOutput.push(output);
	}
}

class RngMock implements IRandomNumber {
	public var randomValue:int = 0;
	
	public function random(max:int):int 
	{
		return randomValue;
	}
	
	public function randomCorrected(max:int):int 
	{
		return randomValue;
	}
}
