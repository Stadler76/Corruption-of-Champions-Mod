package classes.helper 
{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	public class DummyOutputTest 
	{
		private static const TEST_TEXT:String = "foo bar";
		private static const TEST_TEXT2:String = "baz";
		
		private var cut:DummyOutput;
		
		[Before]
		public function setUp(): void {
			cut = new DummyOutput();
		}
		
		[Test]
		public function storesText(): void {
			cut.text(TEST_TEXT);
			cut.text(TEST_TEXT2);
			
			assertThat(cut.collectedOutput, hasItems(TEST_TEXT, TEST_TEXT2));
		}
		
		[Test]
		public function textReturnsSelf(): void {
			assertThat(cut.text(TEST_TEXT), strictlyEqualTo(cut));
		}
		
		[Test]
		public function headerReturnsSelf(): void {
			assertThat(cut.header(TEST_TEXT), strictlyEqualTo(cut));
		}
		
		[Test]
		public function clearReturnsSelf(): void {
			assertThat(cut.clear(), strictlyEqualTo(cut));
		}
		
		[Test]
		public function clearClearsVector(): void {
			cut.text(TEST_TEXT);
			cut.text(TEST_TEXT2);
			
			cut.clear();
			
			assertThat(cut.collectedOutput, emptyArray());
		}
	}
}
