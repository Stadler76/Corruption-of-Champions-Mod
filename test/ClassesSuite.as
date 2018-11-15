package {
	import classes.AppearanceTest;
	import classes.HelperSuite;
	import classes.InternalsSuite;
	import classes.PlayerTest;
	import classes.ScenesSuite;
	import classes.ItemsSuite;

	import classes.CreatureTest;
	import classes.CoCTest;
	import classes.CharSpecialTest;
	import classes.CharCreationTest;
	import classes.MonsterTest;
	import classes.VaginaTest;
	import classes.CockTest;
	import classes.SavesTest;
	import classes.PlayerEventsTest;
	import classes.PlayerEventsVaginaLoosenessRecoveryTest;
	import classes.MenusSuite;
	import classes.CockKnotSupportTest;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
	public class ClassesSuite
	{
		 public var helperSuit:HelperSuite;
		 public var scenesSuit:ScenesSuite;
		 public var itemsSuit:ItemsSuite;
		
		 public var coCTest:CoCTest;
		 public var charSpecialTest:CharSpecialTest;
		 public var charCreationTest:CharCreationTest; 
		 public var monsterTest:MonsterTest;
		 public var creaturTest:CreatureTest;
		 public var playerTest:PlayerTest;
		 public var vaginaClass:VaginaTest;
		 public var cockTest:CockTest;
		 public var savesTest:SavesTest;
		 public var playerEventsTest:PlayerEventsTest;
		 public var playerEventsVaginaLoosenessRecoveryTest:PlayerEventsVaginaLoosenessRecoveryTest;
		 public var internalsSuit:InternalsSuite;
		 public var menusSuit:MenusSuite;
		 public var appearanceTest:AppearanceTest;
		 public var cockKnotSupportTest:CockKnotSupportTest;
	}
}
