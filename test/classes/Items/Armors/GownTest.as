package classes.Items.Armors 
{
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.helper.StageLocator;
	import classes.lists.BreastCup;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	public class GownTest 
	{
		private static const PLAYER_FEMININITY:Number = 100;
		
		private var cut:Gown;
		private var player:Player;
		
		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
		public function setUp(): void
		{
			cut = new Gown();
			
			kGAMECLASS.player = new Player();
			player = kGAMECLASS.player;
			
			player.hips.rating = 5;
			player.butt.rating = 5;
			player.createBreastRow(BreastCup.D);
			player.femininity = PLAYER_FEMININITY;
		}
		
		[Test]
		public function dryadProgressionBreastRatingIncrease(): void
		{
			player.breastRows[0].breastRating = BreastCup.B;
			
			cut.dryadProgression();
			
			assertThat(player.breastRows[0].breastRating, equalTo(BreastCup.D));
		}
		
		[Test]
		public function dryadProgressionRemoveBreasts(): void
		{
			player.createBreastRow(5);
			player.createBreastRow(4);
			
			cut.dryadProgression();
			
			assertThat(player.bRows(), equalTo(1));
		}
		
		[Test]
		public function dryadProgressionBreastRatingIncreaseDoesNotChangeFemininity(): void
		{
			player.breastRows[0].breastRating = BreastCup.B;
			
			cut.dryadProgression();
			
			assertThat(player.femininity, equalTo(PLAYER_FEMININITY));
		}
	}
}
