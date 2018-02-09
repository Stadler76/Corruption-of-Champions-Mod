package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import flash.display.Stage;
	
	import classes.CoC;
	import classes.helper.StageLocator;
	import classes.helper.FireButtonEvent;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class CoCTest {
		private var cut:CoC;
		private var fireButton:FireButtonEvent;
		
		[Before]
		public function runBeforeEveryTest():void {
			assertThat(StageLocator.stage, not(nullValue()));
			
			cut = new CoC(StageLocator.stage);
			cut.player.createVagina();
			
			fireButton = new FireButtonEvent(kGAMECLASS.mainView, CoC.MAX_BUTTON_INDEX);
		}

		[Test] 
		public function injectStageForTest():void {
			cut = new CoC(StageLocator.stage);
		}
		
		[Test(expected="TypeError")] 
		public function noInjectedStage():void {
			cut = new CoC();
		}
		
		[Test]
		public function parserSmokeTest(): void {
			cut.doThatTestingThang();
		}
		
		[Test]
		public function eventTesterSmokeTest(): void {
			cut.eventTester();
			
			//Button presses are required to stop the test from hanging
			fireButton.fireButtonClick(0); //press 'proceed' button
			fireButton.fireButtonClick(4); //press 'exit' button
		}
	}
}
