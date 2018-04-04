package classes.internals 
{
	import classes.Player;
	import classes.helper.DummyOutput;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	import org.hamcrest.collection.*;
	
	public class PregnancyUtilsTest 
	{
		private var output:DummyOutput;
		private var player:Player;
		
		[Before]
		public function setUp(): void {
			output = new DummyOutput();
			player = new Player();
		}
		
		[Test]
		public function outputCreationMessage(): void {
			PregnancyUtils.createVaginaIfMissing(output, player);
			
			assertThat(output.collectedOutput, hasItem(containsString("You feel a terrible pressure in your groin")));
		}
		
		[Test]
		public function createsVaginaOnMales(): void {
			PregnancyUtils.createVaginaIfMissing(output, player)
			
			assertThat(player.hasVagina(), equalTo(true));
		}
		
		[Test]
		public function doesNotcreateVaginaOnFemales(): void {
			player.createVagina();
			
			PregnancyUtils.createVaginaIfMissing(output, player)
			
			assertThat(player.vaginas.length, equalTo(1));
		}
	}
}
