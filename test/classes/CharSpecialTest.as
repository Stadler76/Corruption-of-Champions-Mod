package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import classes.CharSpecial;
	import classes.CoC;
	import classes.Player;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.helper.StageLocator;
	
    public class CharSpecialTest {
		private static const CHAR_NAME_INDEX:int = 0;
		private static const CHAR_FUNCTION_INDEX:int = 1;
		
        private var cut:CharSpecial;
		private var player : Player;
		
		private function findCharFunction(name:String):Function {
			for (var t:Number = 0; t < cut.customs.length; t++) {
				if(cut.customs[t][0] == name) {
					return cut.customs[t][1];
				}
			}
			
			fail("No special character found with the name: " + name);
			return null;
		}
		
		private function createCharByName(name:String):void {
			var func:Function = findCharFunction(name);
			
			func();
		}
		
		[BeforeClass]
		public static function runOnceForTestClass():void { 
			kGAMECLASS = new CoC(StageLocator.stage);
		}
		
        [Before]
        public function setUp():void {
			cut = new CharSpecial();
			resetPlayer();
			
			// guard asserts
			assertThat(kGAMECLASS.player.isFemaleOrHerm(), equalTo(false));
			assertThat(kGAMECLASS.player.isMaleOrHerm(), equalTo(false));
        }
		
		private function resetPlayer() : void {
			kGAMECLASS.player = new Player();
			this.player = kGAMECLASS.player;
		}
		
		[Test(descrition="Execute every custom character function to see what breaks")]
		public function testCheckForRuntimeErrors():void {
			var failedCharInit:Vector.<String> = new Vector.<String>();
			
			for (var index:int = 1; index < cut.customs.length; index++) {
					// reset the player, as the init functions will change the instance state
					resetPlayer();
					
					var charCreation:Function = cut.customs[index][CHAR_FUNCTION_INDEX];
					
					try{
						if (charCreation != null) {
							charCreation();
						}
					}catch (error:Error) {
						failedCharInit.push(cut.customs[index][CHAR_NAME_INDEX]);
					}
			}
			
			if (failedCharInit.length != 0) {	
				fail("The following char creations failed: " + failedCharInit.join());
			}
		}
     
		[Test] 
        public function testEtisNonVirgin():void {
			var func:Function = findCharFunction("Etis");
			
			func();
			
			assertThat(kGAMECLASS.player.isFemaleOrHerm(), equalTo(true));
			assertThat(kGAMECLASS.player.hasVirginVagina(), equalTo(false));
        }
		
		[Test] 
        public function testChimeraNonVirgin():void {
			var func:Function = findCharFunction("Chimera");
			
			func();
			
			assertThat(kGAMECLASS.player.isFemaleOrHerm(), equalTo(true));
			assertThat(kGAMECLASS.player.hasVirginVagina(), equalTo(false));
        }
		
		[Test] 
        public function testMirvanna():void {
			var func:Function = findCharFunction(CharSpecial.MIRVANNA_NAME);
			
			func();
			
			assertThat(kGAMECLASS.player.isFemaleOrHerm(), equalTo(true));
			assertThat(kGAMECLASS.player.hasVirginVagina(), equalTo(false));
        }
		
		[Test]
		public function testAriaHasBreastrow() : void {
			var func : Function = findCharFunction(CharSpecial.ARIA_NAME);
			
			func();
			
			assertThat(kGAMECLASS.player.bRows(), equalTo(1));
		}
		
		[Test]
		public function testAriaBreastRating() : void {
			var func : Function = findCharFunction(CharSpecial.ARIA_NAME);
			
			func();
			
			assertThat(kGAMECLASS.player.breastRows[0].breastRating, equalTo(5));
		}
		
		[Test]
		public function testCharaunBreastRows() : void {
			var func : Function = findCharFunction(CharSpecial.CHARAUN_NAME);
			
			func();
			
			assertThat(player.bRows(), equalTo(4));
		}
		
		[Test]
		public function testCharaunBreastFuckable() : void {
			var func : Function = findCharFunction(CharSpecial.CHARAUN_NAME);
			
			func();
			
			assertThat(player.breastRows[0].fuckable, equalTo(true));
			assertThat(player.breastRows[1].fuckable, equalTo(true));
			assertThat(player.breastRows[2].fuckable, equalTo(true));
			assertThat(player.breastRows[3].fuckable, equalTo(true));
		}
		
		[Test]
		public function testCharaunBreastRating() : void {
			var func : Function = findCharFunction(CharSpecial.CHARAUN_NAME);
			
			func();
			
			assertThat(player.breastRows[0].breastRating, equalTo(4));
			assertThat(player.breastRows[1].breastRating, equalTo(3));
			assertThat(player.breastRows[2].breastRating, equalTo(2));
			assertThat(player.breastRows[3].breastRating, equalTo(1));
		}
		
			
		[Test]
		public function testGalateaBreastRowCount() : void {
			var func : Function = findCharFunction(CharSpecial.GALATEA_NAME);
			
			func();
			
			assertThat(player.bRows(), equalTo(1));
		}
		
		[Test]
		public function testGalateaBreastRating() : void {
			var func : Function = findCharFunction(CharSpecial.GALATEA_NAME);
			
			func();
			
			assertThat(player.breastRows[0].breastRating, equalTo(21));
		}
		
		[Test]
		public function testHikariBreastRowCount() : void {
			var func : Function = findCharFunction(CharSpecial.HIKARI_NAME);
			
			func();
			
			assertThat(player.bRows(), equalTo(1));
		}
		
		[Test]
		public function testHikariBreastRating() : void {
			var func : Function = findCharFunction(CharSpecial.HIKARI_NAME);
			
			func();
			
			assertThat(player.breastRows[0].breastRating, equalTo(4));
		}
		
		[Test]
		public function testKattiBreastRowCount() : void {
			var func : Function = findCharFunction(CharSpecial.KATTI_NAME);
			
			func();
			
			assertThat(player.bRows(), equalTo(1));
		}

		[Test]
		public function testKattiBreastRating() : void {
			var func : Function = findCharFunction(CharSpecial.KATTI_NAME);
			
			func();
			
			assertThat(player.breastRows[0].breastRating, equalTo(19));
		}
		
		[Test]
		public function testKattiNippleLength() : void {
			var func : Function = findCharFunction(CharSpecial.KATTI_NAME);
			
			func();
			
			assertThat(player.nippleLength, equalTo(4.5));
		}
		
		[Test]
		public function leahHpRestored():void {
			createCharByName(CharSpecial.LEAH_NAME);
			
			assertThat(player.HP, equalTo(80));
		}
		
		[Test]
		public function testKattiBreastFuckable() : void {
			var func : Function = findCharFunction(CharSpecial.KATTI_NAME);
			
			func();
			
			assertThat(player.breastRows[0].fuckable, equalTo(true));
		}
		
		[Test]
		public function testLucinaBreastRowCount() : void {
			var func : Function = findCharFunction(CharSpecial.LUCINA_NAME);
			
			func();
			
			assertThat(player.bRows(), equalTo(1));
		}

		[Test]
		public function testLucinaBreastRating() : void {
			var func : Function = findCharFunction(CharSpecial.LUCINA_NAME);
			
			func();
			
			assertThat(player.breastRows[0].breastRating, equalTo(4));
		}
		
		[Test]
		public function testNavornBreastRows() : void {
			var func : Function = findCharFunction(CharSpecial.NAVORN_NAME);
			
			func();
			
			assertThat(player.bRows(), equalTo(4));
		}
		
		[Test]
		public function testNavornBreastFuckable() : void {
			var func : Function = findCharFunction(CharSpecial.NAVORN_NAME);
			
			func();
			
			assertThat(player.breastRows[0].fuckable, equalTo(true));
			assertThat(player.breastRows[1].fuckable, equalTo(true));
			assertThat(player.breastRows[2].fuckable, equalTo(true));
			assertThat(player.breastRows[3].fuckable, equalTo(true));
		}
		
		[Test]
		public function testNavornBreastRating() : void {
			var func : Function = findCharFunction(CharSpecial.NAVORN_NAME);
			
			func();
			
			assertThat(player.breastRows[0].breastRating, equalTo(5));
			assertThat(player.breastRows[1].breastRating, equalTo(5));
			assertThat(player.breastRows[2].breastRating, equalTo(5));
			assertThat(player.breastRows[3].breastRating, equalTo(5));
		}
		
		[Test]
		public function testNavornNippelsPerBreast() : void {
			var func : Function = findCharFunction(CharSpecial.NAVORN_NAME);
			
			func();
			
			assertThat(player.breastRows[0].nipplesPerBreast, equalTo(4));
			assertThat(player.breastRows[1].nipplesPerBreast, equalTo(4));
			assertThat(player.breastRows[2].nipplesPerBreast, equalTo(4));
			assertThat(player.breastRows[3].nipplesPerBreast, equalTo(4));
		}
		
		[Test]
		public function nixiHpRestored(): void {
			createCharByName(CharSpecial.NIXI_NAME);
			
			assertThat(player.HP, equalTo(80));
		}
		
				
		[Test]
		public function testLukazIsMale() : void {
			var func : Function = findCharFunction(CharSpecial.LUKAZ_NAME);
			
			func();
			
			assertThat(player.isMale(), equalTo(true));
		}
		
		[Test]
		public function lukazHPRestored():void {
			createCharByName(CharSpecial.LUKAZ_NAME);
			
			assertThat(player.HP, equalTo(84));
		}
		
		[Test]
		public function testMaraClitLength() : void {
			var func : Function = findCharFunction(CharSpecial.MARA_NAME);
			
			func();
			
			assertThat(player.getClitLength(), equalTo(0.5));
		}
		
		[Test]
		public function vahdunbriiHpRestored(): void {
			createCharByName(CharSpecial.VAHDUNBRII_NAME);
			
			assertThat(player.HP, equalTo(80));
		}
		
		[Test]
		public function etisHpRestored(): void {
			createCharByName(CharSpecial.ETIS_NAME);
			
			assertThat(player.HP, equalTo(50));
		}
		
		[Test]
		public function chimeraHpRestored(): void {
			createCharByName(CharSpecial.CHIMERA_NAME);
			
			assertThat(player.HP, equalTo(50));
		}
	}
}
