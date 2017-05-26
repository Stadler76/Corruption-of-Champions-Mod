package classes.Items
{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import classes.helper.StageLocator;
	
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Mutations;
	import classes.Player;
	import classes.CoC;
	import classes.StatusEffects;
	
	public class ConsumableTest
	{
		private static const RECOVERY_PROGRESS:int = 5;
		
		private var player:Player;
		private var cut:Consumable;
		
		[BeforeClass]
		public static function setUpClass():void
		{
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
		public function setUp():void
		{
			cut = new TestConsumable();
			player = new Player();
			
			kGAMECLASS.player = player;
		}
		
		[Test]
		public function statChangeOnItemUse():void
		{
			cut.useItem();
			
			assertThat(player.str, equalTo(100))
		}
	}
}

import classes.Items.Consumable;

class TestConsumable extends Consumable
{
	public function TestConsumable() 
	{
		super("test", "test", "test item",0,"Just testing!");
	}
	
	override public function useItem():Boolean
	{
		dynStats('str', +100);
		return false;
	}
}
