package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.collection.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import flash.display.Stage;
	
	import classes.CoC;
	import classes.helper.StageLocator;
	import classes.helper.FireButtonEvent;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class CoCTest {
		private var cut:CoCForTest;
		private var fireButton:FireButtonEvent;
		
		[Before]
		public function runBeforeEveryTest():void {
			assertThat(StageLocator.stage, not(nullValue()));
			
			cut = new CoCForTest(StageLocator.stage);
			cut.player.createVagina();
			
			fireButton = new FireButtonEvent(kGAMECLASS.mainView, Output.MAX_BUTTON_INDEX);
		}

		[Test] 
		public function injectStageForTest():void {
			var coc:CoC = new CoC(StageLocator.stage);
		}
		
		[Test(expected="TypeError")] 
		public function noInjectedStage():void {
			var coc:CoC = new CoC();
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

import classes.CoC;
import flash.display.Stage;

class CoCForTest extends CoC {
	public var calls:Vector.<Number> = new Vector.<Number>();
	public var collectedOutput:Vector.<String> = new Vector.<String>();
	
	public function CoCForTest(injectedStage:Stage) 
	{
		super(injectedStage);
	}
}
