package classes{
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import flash.display.Stage;
	
	import classes.CoC;
	import classes.Scenes.Inventory;
	import classes.Saves;
	import classes.helper.StageLocator;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class SavesTest {
		private static const TEST_VERSION:String = "test";
		private static const TEST_SAVE_GAME:String = "test";
		
		private static const CLIT_LENGTH:Number = 5;
		private static const VAGINA_RECOVERY_PROGRESS:int = 6;
		
		private static const NUMBER_OF_COCKS:int = 3;
		private static const TEST_SOCK:String = "testSock";
		private static const VIRIDIAN_SOCK:String = "viridian";
		
		private var player:Player;
		private var cut:SavesForTest;

		private var saveFile:*;
		
		[BeforeClass]
		public static function setUpClass():void {
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
		[Before]
		public function setUp():void {
			player = new Player();
		
			createPlayerCocks();
			
			kGAMECLASS.player = player;
			kGAMECLASS.ver = TEST_VERSION;
			kGAMECLASS.version = TEST_VERSION;
			
			cut = new SavesForTest(kGAMECLASS.gameStateDirectGet, kGAMECLASS.gameStateDirectSet);
			kGAMECLASS.inventory = new Inventory(cut);
			
			saveGame();

			kGAMECLASS.flags[kFLAGS.JOJO_STATUS] = 5;
			saveFile = [];
			saveFile.data = [];
		}
		
		private function saveGame():void {
			cut.saveGame(TEST_SAVE_GAME, false);
		}
		
		private function loadGame():void {
			kGAMECLASS.player = new Player();
			
			cut.loadGame(TEST_SAVE_GAME);
			
			this.player = kGAMECLASS.player;
		}
		
		private function createPlayerCocks():void {
			player.removeCock(0, int.MAX_VALUE);
			
			player.createCock(1, 1, CockTypesEnum.CAT);
			player.createCock(2, 2, CockTypesEnum.DOG);
			player.createCock(3, 3, CockTypesEnum.HORSE);
		}
		
		[Test]
		public function testClitLengthSaved():void {
			player.createVagina();
			player.setClitLength(CLIT_LENGTH);
			cut.saveGame(TEST_SAVE_GAME, false);
			player.setClitLength(0);
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.getClitLength(), equalTo(CLIT_LENGTH));
		}
		
		[Test] 
		public function testRecoveryProgressSaved():void {
			player.createVagina();
			player.vaginas[0].recoveryProgress = VAGINA_RECOVERY_PROGRESS;
			cut.saveGame(TEST_SAVE_GAME, false);
			player.vaginas[0].resetRecoveryProgress();
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.vaginas[0].recoveryProgress, equalTo(VAGINA_RECOVERY_PROGRESS));
		}
		
		[Test]
		public function playerHasThreeCocks():void {
			assertThat(player.cocks.length, equalTo(NUMBER_OF_COCKS));
		}
		
		[Test]
		public function cocksAreStored():void {
			player.removeCock(0, 3);
			assertThat(player.cocks.length, equalTo(0));
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.cocks.length, equalTo(NUMBER_OF_COCKS));
		}

		[Test]
		public function cocksLoadOrder():void {
			player.removeCock(0, 3);
			assertThat(player.cocks.length, equalTo(0));
			
			cut.loadGame(TEST_SAVE_GAME);
			
			assertThat(kGAMECLASS.player.cocks[0].cockType, equalTo(CockTypesEnum.CAT));
			assertThat(kGAMECLASS.player.cocks[2].cockType, equalTo(CockTypesEnum.HORSE));
		}
		
		[Test]
		public function cockLoadViridianSockGrantsLustyRegenerationPerk():void {
			player.cocks[0].sock = VIRIDIAN_SOCK;
			
			saveGame();
			loadGame();
			
			assertThat(player.hasPerk(PerkLib.LustyRegeneration), equalTo(true));
		}
		
		[Test]
		public function cockLoadNoLustyRegenerationPerkWithoutViridianSock():void {
			player.cocks[0].sock = TEST_SOCK;
			
			saveGame();
			loadGame();
			
			assertThat(player.hasPerk(PerkLib.LustyRegeneration), equalTo(false));
		}

		[Test]
		public function jojoLegacyStatusLoadJojoIsSlave():void {
			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(6));
		}

		[Test]
		public function jojoLegacyStatusLoadJojoEncountersInProgress():void {
			var jojoStatus:int = 3;
			kGAMECLASS.flags[kFLAGS.JOJO_STATUS] = jojoStatus;
			
			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(jojoStatus));
		}

		[Test]
		public function jojoNewStatusLoadUpdateSlaveStatus():void {
			saveFile.data.npcs = [];
			saveFile.data.npcs.jojo = [];
			saveFile.data.npcs.jojo.serializationVersion = 1;

			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(5));
		}

		[Test]
		public function loadWithMissingNpcs():void {
			saveFile.data = [];

			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(6));
		}

		[Test]
		public function loadWithMissingJojoNpc():void {
			saveFile.data.npcs = [];

			cut.loadNPCstest(saveFile);

			assertThat(kGAMECLASS.flags[kFLAGS.JOJO_STATUS], equalTo(6));
		}
	}
}

import classes.Saves

class SavesForTest extends Saves {
	public function SavesForTest(gameStateDirectGet:Function, gameStateDirectSet:Function) {
		super(gameStateDirectGet, gameStateDirectSet);
	}

	public function saveNPCstest(saveFile:*):void {
		this.saveNPCs(saveFile);
	}

	public function loadNPCstest(saveFile:*):void {
		this.loadNPCs(saveFile);
	}
}
