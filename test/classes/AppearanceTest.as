package classes 
{
	import org.hamcrest.*
	import org.hamcrest.collection.*
	
	import classes.BodyParts.Hair;
	public class AppearanceTest 
	{
		private var creature:Creature;
		
		[Before]
		public function setUp():void
		{
			creature = new Creature();
		}
		
		[Test]
		public function woolHairDescription():void {
			var expected:Array =
								[
									"short, black woolen hair",
									"short, black poofy hair",
									"short, black soft wool",
									"short, black untameable woolen hair"
								];
								
			creature.hair.type = Hair.WOOL;
			creature.hair.length = 2;
			creature.hair.color = "black";
			
			var hairDescription:String = Appearance.hairDescription(creature);
			
			
			// assert is reversed because RNG and the hamcrest library does not have a 'any of' matcher
			assertThat(expected, hasItem(hairDescription));
		}
	}
}
