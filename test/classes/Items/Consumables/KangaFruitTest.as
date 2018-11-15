package classes.Items.Consumables 
{
	import classes.CoC;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Consumable;
	import classes.Player;
	import classes.helper.StageLocator;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class KangaFruitTest 
	{
		private static const DEFAULT_KNOT_MULTIPLIER:Number = 1;
		private static const KNOT_MULTIPLIER:Number = 2.3;
		private static const ITEM_USE_COUNT:int = 20;
		
		private var standard:KangaFruit;
		private var enhanced:KangaFruit;
		
		private var player:Player;
		
		private function useItemMultipleTimes(consumable:Consumable):void
		{
			for (var i:int = 0; i < ITEM_USE_COUNT; i++) {
				consumable.useItem();
			}
		}
		
		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
			kGAMECLASS.saves.setPermObjectFilename("TestPermObject");
		}

		[Before]
		public function setUp():void {
			standard = new KangaFruit(KangaFruit.STANDARD);
			enhanced = new KangaFruit(KangaFruit.ENHANCED);
			player = new Player();
			
			kGAMECLASS.player = player;
		}
		
		[Test] 
		public function cockTransformationResetsKnot():void {
			player.createCock(5.5, 1, CockTypesEnum.DOG);
			player.cocks[0].knotMultiplier = KNOT_MULTIPLIER;
			
			useItemMultipleTimes(enhanced);
			
			assertThat(player.cocks[0].knotMultiplier, equalTo(DEFAULT_KNOT_MULTIPLIER));
		}
		
		[Test] 
		public function standardDoesNotTransformCock():void {
			player.createCock(5.5, 1, CockTypesEnum.DOG);
			
			useItemMultipleTimes(standard);
			
			assertThat(player.cocks[0].cockType , equalTo(CockTypesEnum.DOG));
		}
	}
}
