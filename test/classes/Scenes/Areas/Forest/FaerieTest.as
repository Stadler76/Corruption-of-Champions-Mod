package classes.Scenes.Areas.Forest
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
	
	public class FaerieTest
	{
		private var cut:FaerieForTest;
		private var player:Player;
		
		public function FaerieTest()
		{
		}
		
		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
		public function setUp():void
		{
			player = new Player();
			kGAMECLASS.player = player;
			
			cut = new FaerieForTest();
		}
		
		[Test(description = "Wrong order of checks causes an exception to be thrown")]
		public function doNothingWithNoVagina():void
		{
			cut.testFaerieDoNothing();
		}
	}
}

import classes.Scenes.Areas.Forest.Faerie;

class FaerieForTest extends Faerie {
	public function testFaerieDoNothing():void {
		super.faerieDoNothing();
	}
}
