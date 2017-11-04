package classes.internals
{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	public class UtilsTest
	{
		private static const RANDOM_NUMBER_ITERATIONS:int = 10000;
		private static const RANDOM_NUMBER_MAX:int = 5;
		
		private var cut:Utils;
		
		[Before]
		public function setUp():void
		{
			cut = new Utils();
		}
		
		[Test]
		public function genratedRandomNumber():void
		{
			var randomNumbers:Vector.<Number> = new Vector.<Number>();
			
			for (var i:int = 0; i < RANDOM_NUMBER_ITERATIONS; i++ ){
				randomNumbers.push(Utils.rand(RANDOM_NUMBER_MAX));
			}
			
			assertThat(randomNumbers, hasItems(0, 1, 2, 3, 4));
		}
	}
}
