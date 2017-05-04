package classes.helper
{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.helper.FireButtonEvent;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.CoC;
	
	public class FireButtonEventTest
	{
		private static const TEST_BUTTON_INDEX:int = 5;
		private static const TEST_BUTTON_TEXT:String = "Testing!";
		
		private var cut:FireButtonEvent;
		private var eventTriggeredFlag:Boolean;
		
		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
		public function setUp():void
		{
			cut = new FireButtonEvent(kGAMECLASS.mainView, CoC.MAX_BUTTON_INDEX);
			eventTriggeredFlag = false;
		}
		
		private function setFlagEvent():void {
			eventTriggeredFlag = true;
		}
		
		[Test(expected = "ArgumentError")]
		public function buttonIndexOutOfRange():void {
			cut.fireButtonClick(int.MAX_VALUE);
		}
		
		[Test(expected = "ArgumentError")]
		public function buttonIndexNegative():void {
			cut.fireButtonClick(int.MIN_VALUE);
		}
		
		[Test]
		public function buttonEventNotTriggered():void {
			kGAMECLASS.addButton(TEST_BUTTON_INDEX, TEST_BUTTON_TEXT, setFlagEvent);
			
			assertThat(eventTriggeredFlag, equalTo(false));
		}
		
		[Test]
		public function buttonEventTriggered():void {
			kGAMECLASS.addButton(TEST_BUTTON_INDEX, TEST_BUTTON_TEXT, setFlagEvent);
			
			cut.fireButtonClick(TEST_BUTTON_INDEX);
			
			assertThat(eventTriggeredFlag, equalTo(true));
		}
		
		[Test]
		public function doNextEventNotTriggered():void {
			kGAMECLASS.doNext(setFlagEvent);
			
			assertThat(eventTriggeredFlag, equalTo(false));
		}
		
		[Test]
		public function doNextEventTriggered():void {
			kGAMECLASS.doNext(setFlagEvent);
			
			cut.fireNextButtonEvent();
			
			assertThat(eventTriggeredFlag, equalTo(true));
		}
	}
}
