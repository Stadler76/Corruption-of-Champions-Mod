package classes.Scenes 
{
	import classes.Scenes.Areas.BogSuit;
	import classes.Scenes.Areas.DeepWoodsTest;
	import classes.Scenes.Areas.ForestSuit;
	import classes.Scenes.Areas.MountainSuit;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AreasSuit 
	{
		public var mountainSuit:MountainSuit;
		public var forestSuit:ForestSuit;
		public var bogSuit:BogSuit;
		
		public var deepWoodsTest:DeepWoodsTest;
	}
}
