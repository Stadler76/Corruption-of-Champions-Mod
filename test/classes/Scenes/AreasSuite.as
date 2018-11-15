package classes.Scenes 
{
	import classes.Scenes.Areas.BogSuite;
	import classes.Scenes.Areas.DeepWoodsTest;
	import classes.Scenes.Areas.ForestSuite;
	import classes.Scenes.Areas.MountainSuite;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AreasSuite 
	{
		public var mountainSuit:MountainSuite;
		public var forestSuit:ForestSuite;
		public var bogSuit:BogSuite;
		
		public var deepWoodsTest:DeepWoodsTest;
	}
}
