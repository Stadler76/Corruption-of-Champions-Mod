package classes.Scenes.Areas 
{
	import classes.Scenes.PregnancyProgression;
	import classes.helper.DummyOutput;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.helper.StageLocator;
	
	public class DeepWoodsTest 
	{
		private var cut:DeepWoods;
		private var forest:Forest;
		
		[Before]
		public function setUp():void
		{
			this.forest = new Forest(new PregnancyProgression(), new DummyOutput());
		}
		
		[Test(expected='ArgumentError')]
		public function throwExceptionOnNullForest():void
		{
			new DeepWoods(null);
		}
		
		[Test(expected='ArgumentError')]
		public function throwExceptionOnUndefinedForest():void
		{
			new DeepWoods(undefined);
		}
		
		[Test]
		public function createDeepwoodsWithValidForest():void
		{
			new DeepWoods(forest);
		}
	}
}
