package classes.Scenes.NPCs{
	import classes.GlobalFlags.kFLAGS;
	import org.hamcrest.assertThat;
	import org.hamcrest.number.greaterThan;
	import org.hamcrest.object.equalTo;

	import classes.helper.StageLocator;
	
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Player;
	import classes.CoC;
	import classes.CockTypesEnum;

	public class JojoTest {
		private static const JOJO_LUST:int = 45;
		private static const JOJO_FULL_CORRUPTION_COCK_LENGTH:Number = 13;
		
		private var cut:JojoForTest;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}

		[Before]
		public function setUp():void {  
			createCut(3);
		}
		
		private function createCut(jojoStatus:int): void {
			kGAMECLASS.flags[kFLAGS.JOJO_STATUS] = jojoStatus;
			
			cut = new JojoForTest();
		}
		
		[Test]
		public function jojoStatus3Lust(): void {
			assertThat(cut.lust, equalTo(JOJO_LUST));
		}
		
		[Test]
		public function jojoSelfCorruptionDuringCombat(): void {
			for (var i:int = 0; i < 10; i++) {
				cut.combatActionTest();
			}
			
			assertThat(cut.lust, greaterThan(JOJO_LUST));
		}

		[Test]
		public function jojoCockType(): void {
			assertThat(cut.cocks[0].cockType, equalTo(CockTypesEnum.HUMAN));
		}
		
		[Test]
		public function jojoCorruptCockLength(): void {
			createCut(5);
			
			assertThat(cut.cocks[0].cockLength, equalTo(JOJO_FULL_CORRUPTION_COCK_LENGTH));
		}
		
		[Test]
		public function jojoSlaveCockLength(): void {
			createCut(6);
			
			assertThat(cut.cocks[0].cockLength, equalTo(JOJO_FULL_CORRUPTION_COCK_LENGTH));
		}
	}
}

import classes.Scenes.NPCs.Jojo;

class JojoForTest extends Jojo {
	public var collectedOutput:Vector.<String> = new Vector.<String>();
	
	public function combatActionTest(): void {
		performCombatAction();
	}
}
