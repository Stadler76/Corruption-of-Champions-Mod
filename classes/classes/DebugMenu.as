package classes 
{
	import classes.*;
	import classes.BodyParts.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.*;
	import classes.internals.Profiling;
	import classes.menus.GenderDebug;
	import flash.events.TimerEvent;
	import flash.utils.*;
	import flash.utils.describeType;
	import flash.events.TextEvent;

	public class DebugMenu extends BaseContent
	{
		public var flagNames:XML = describeType(kFLAGS);
		private var lastMenu:Function = null;
		
		public var setArrays:Boolean = false;

		//Set up equipment arrays
		public var weaponArray:Array = [];
		public var shieldArray:Array = [];
		public var armourArray:Array = [];
		public var undergarmentArray:Array = [];
		public var accessoryArray:Array = [];
		
		//Set up item arrays
		public var transformativeArray:Array = [];
		public var consumableArray:Array = [];
		public var dyeArray:Array = [];
		public var materialArray:Array = [];
		public var rareArray:Array = [];
		
		
		public function DebugMenu() 
		{	
		}
		
		public function accessDebugMenu():void {
			//buildArray();
			Profiling.LogProfilingReport();
			if (!getGame().inCombat) {
				
				// initalizing the menu here due to order the required classes are inizalized
				var genderDebugMenu:GenderDebug = new GenderDebug(kGAMECLASS, kGAMECLASS.output, kGAMECLASS.player, accessDebugMenu);
				
				hideMenus();
				mainView.nameBox.visible = false;
				mainView.nameBox.text = "";
				mainView.nameBox.maxChars = 16;
				mainView.nameBox.restrict = null;
				mainView.nameBox.width = 140;
				clearOutput();
				outputText("Welcome to the super secret debug menu!");
				menu();
				addButton(0, "Spawn Items", itemSpawnMenu).hint("Spawn any items of your choice, including items usually not obtainable through gameplay.");
				addButton(1, "Change Stats", statChangeMenu).hint("Change your core stats.");
				addButton(2, "Flag Editor", flagEditor).hint("Edit any flag. \n\nCaution: This might screw up your save!");
				addButton(3, "Reset NPC", resetNPCMenu).hint("Choose a NPC to reset.");
				if (player.isPregnant()) addButton(4, "Abort Preg", abortPregnancy);
				addButton(5, "DumpEffects", dumpEffectsMenu).hint("Display your status effects");
				addButton(7, "HACK STUFFZ", styleHackMenu).hint("H4X0RZ");
				addButton(8, "Scene Test", testScene).hint("Manually Proc a Scene.");
				addButton(9, genderDebugMenu.getButtonText(), genderDebugMenu.enter).hint(genderDebugMenu.getButtonHint());
				addButton(14, "Exit", playerMenu);
			}
			if (getGame().inCombat) {
				clearOutput();
				outputText("You raise the wand and give it a twirl but nothing happens. Seems like it only works when you're not in the middle of a battle.");
				doNext(playerMenu);
			}
		}

		private var selectedScene:*;
		private function testScene(selected:*=null):void {
			clearOutput();
			if(!selected){selected = kGAMECLASS;}
			selectedScene = selected;
			mainView.mainText.addEventListener(TextEvent.LINK, linkhandler);
			getFun("variable",selected);
			getFun("method",selected);
			menu();
			addButton(0,"Back",linkhandler,new TextEvent(TextEvent.LINK,false,false,"-1"));

			function getFun(type:String, scene:*):void {
				var funsxml:XML = describeType(scene);
				var funs:Array = [];
				for each(var item:XML in funsxml[type]) {
					funs.push(item);
				}
				funs.sortOn("@name");
				if (funs.length > 0) {
					outputText("<b><u>"+type.toUpperCase()+"</u></b>\n");
				}
				for each (var fun:* in funs) {
					outputText("<u><a href=\"event:" + fun.@name+"\">" + fun.@name+"</a></u>\n");
				}
			}
			function linkhandler(e:TextEvent):void {
				mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
				if (e.text == "-1") {
					mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
					if(selectedScene != kGAMECLASS){testScene();}
					else{accessDebugMenu();}
					return;
				}
				if (selectedScene[e.text] is Function) {
					clearOutput();
					doNext(accessDebugMenu);
					var selected:Function = selectedScene[e.text];
					selectedScene = null;
					selected();
				} else {
					selectedScene = selectedScene[e.text];
					testScene(selectedScene);
				}
			}
		}
		private function  dumpEffectsMenu():void {
			clearOutput();
			for each (var effect:StatusEffectClass in player.statusEffects) {
				outputText("'"+effect.stype.id+"': "+effect.value1+" "+effect.value2+" "+effect.value3+" "+effect.value4+"\n");
			}
			doNext(accessDebugMenu);
		}

		//Spawn items menu
		private function itemSpawnMenu():void {
			setItemArrays();
			clearOutput();
			outputText("Select a category.");
			menu();
			addButton(0, "Transformatives", displayItemPage, transformativeArray, 1);
			addButton(1, "Consumables", displayItemPage, consumableArray, 1);
			addButton(2, "Dyes", displayItemPage, dyeArray, 1);
			addButton(3, "Materials", displayItemPage, materialArray, 1);
			addButton(4, "Rare Items", displayItemPage, rareArray, 1);
			addButton(5, "Weapons", displayItemPage, weaponArray, 1);
			addButton(6, "Shields", displayItemPage, shieldArray, 1);
			addButton(7, "Armours", displayItemPage, armourArray, 1);
			addButton(8, "Undergarments", displayItemPage, undergarmentArray, 1);
			addButton(9, "Accessories", displayItemPage, accessoryArray, 1);
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function displayItemPage(array:Array, page:int):void {
			clearOutput();
			outputText("What item would you like to spawn? ");
			menu();
			var buttonPos:int = 0; //Button positions 4 and 9 are reserved for next and previous.
			for (var i:int = 0; i < 12; i++) {
				if (array[((page-1) * 12) + i] != undefined) {
					if (array[((page-1) * 12) + i] != null) addButton(buttonPos, array[((page-1) * 12) + i].shortName, inventory.takeItem, array[((page-1) * 12) + i], curry(displayItemPage, array, page)).hint(array[((page-1) * 12) + i].description, capitalizeFirstLetter(array[((page-1) * 12) + i].longName));
				}
				buttonPos++;
				if (buttonPos == 4 || buttonPos == 9) buttonPos++;
			}
			if (!isNextPageEmpty(array, page)) addButton(4, "Next", displayItemPage, array, page+1);
			if (!isPreviousPageEmpty(array, page)) addButton(9, "Previous", displayItemPage, array, page-1);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function isPreviousPageEmpty(array:Array, page:int):Boolean {
			var isEmpty:Boolean = true;
			for (var i:int = 0; i < 12; i++) {
				if (array[((page-2) * 12) + i] != undefined) {
					isEmpty = false;
				}
			}
			return isEmpty;
		}
		
		private function isNextPageEmpty(array:Array, page:int):Boolean {
			var isEmpty:Boolean = true;
			for (var i:int = 0; i < 12; i++) {
				if (array[((page) * 12) + i] != undefined) {
					isEmpty = false;
				}
			}
			return isEmpty;
		}
		
		private function setItemArrays():void {
			if (setArrays) return; //Already set, cancel.
			//Build arrays here
			//------------
			// Transformatives
			//------------
			//Page 1
			transformativeArray.push(consumables.B_GOSSR);
			transformativeArray.push(consumables.BEEHONY);
			transformativeArray.push(consumables.BLACKPP);
			transformativeArray.push(consumables.BOARTRU);
			transformativeArray.push(consumables.BULBYPP);
			transformativeArray.push(consumables.CANINEP);
			transformativeArray.push(consumables.CLOVERS);
			transformativeArray.push(consumables.DBLPEPP);
			transformativeArray.push(consumables.DRAKHRT);
			transformativeArray.push(consumables.DRYTENT);
			transformativeArray.push(consumables.ECTOPLS);
			transformativeArray.push(consumables.EQUINUM);
			//Page 2
			transformativeArray.push(consumables.FOXBERY);
			transformativeArray.push(consumables.FOXJEWL);
			transformativeArray.push(consumables.FRRTFRT);
			transformativeArray.push(consumables.GLDRIND);
			transformativeArray.push(consumables.GLDSEED);
			transformativeArray.push(consumables.GOB_ALE);
			transformativeArray.push(consumables.HUMMUS_);
			transformativeArray.push(consumables.IMPFOOD);
			transformativeArray.push(consumables.INCUBID);
			transformativeArray.push(consumables.KANGAFT);
			transformativeArray.push(consumables.KNOTTYP);
			transformativeArray.push(consumables.LABOVA_);
			//Page 3
			transformativeArray.push(consumables.LARGEPP);
			transformativeArray.push(consumables.MAGSEED);
			transformativeArray.push(consumables.MGHTYVG);
			transformativeArray.push(consumables.MOUSECO);
			transformativeArray.push(consumables.MINOBLO);
			transformativeArray.push(consumables.MYSTJWL);
			transformativeArray.push(consumables.P_LBOVA);
			transformativeArray.push(consumables.PIGTRUF);
			transformativeArray.push(consumables.PRFRUIT);
			transformativeArray.push(consumables.PROBOVA);
			transformativeArray.push(consumables.P_DRAFT);
			transformativeArray.push(consumables.P_S_MLK);
			//Page 4
			transformativeArray.push(consumables.PSDELIT);
			transformativeArray.push(consumables.PURHONY);
			transformativeArray.push(consumables.SATYR_W);
			transformativeArray.push(consumables.SDELITE);
			transformativeArray.push(consumables.S_DREAM);
			transformativeArray.push(consumables.SUCMILK);
			transformativeArray.push(consumables.RDRROOT);
			transformativeArray.push(consumables.REPTLUM);
			transformativeArray.push(consumables.RINGFIG);
			transformativeArray.push(consumables.RIZZART);
			transformativeArray.push(consumables.S_GOSSR);
			transformativeArray.push(consumables.SALAMFW);
			//Page 5
			transformativeArray.push(consumables.SHARK_T);
			transformativeArray.push(consumables.SNAKOIL);
			transformativeArray.push(consumables.SPHONEY);
			transformativeArray.push(consumables.TAURICO);
			transformativeArray.push(consumables.TOTRICE);
			transformativeArray.push(consumables.TRAPOIL);
			transformativeArray.push(consumables.TSCROLL);
			transformativeArray.push(consumables.TSTOOTH);
			transformativeArray.push(consumables.VIXVIGR);
			transformativeArray.push(consumables.W_FRUIT);
			transformativeArray.push(consumables.WETCLTH);
			transformativeArray.push(consumables.WOLF_PP);
			transformativeArray.push(consumables.UBMBOTT);
			
			//------------
			// Consumables
			//------------
			//Page 1
			consumableArray.push(consumables.AKBALSL);
			consumableArray.push(consumables.C__MINT);
			consumableArray.push(consumables.CERUL_P);
			consumableArray.push(consumables.COAL___);
			consumableArray.push(consumables.DEBIMBO);
			consumableArray.push(consumables.EXTSERM);
			consumableArray.push(consumables.F_DRAFT);
			consumableArray.push(consumables.GROPLUS);
			consumableArray.push(consumables.H_PILL);
			consumableArray.push(consumables.HRBCNT);
			consumableArray.push(consumables.ICICLE_);
			consumableArray.push(consumables.KITGIFT);
			//Page 2
			consumableArray.push(consumables.L_DRAFT);
			consumableArray.push(consumables.LACTAID);
			consumableArray.push(consumables.LUSTSTK);
			consumableArray.push(consumables.MILKPTN);
			consumableArray.push(consumables.NUMBOIL);
			consumableArray.push(consumables.NUMBROX);
			consumableArray.push(consumables.OVIELIX);
			consumableArray.push(consumables.OVI_MAX);
			consumableArray.push(consumables.PEPPWHT);
			consumableArray.push(consumables.PPHILTR);
			consumableArray.push(consumables.PRNPKR);
			consumableArray.push(consumables.PROMEAD);
			//Page 3
			consumableArray.push(consumables.REDUCTO);
			consumableArray.push(consumables.SENSDRF);
			consumableArray.push(consumables.SMART_T);
			consumableArray.push(consumables.VITAL_T);
			consumableArray.push(consumables.B__BOOK);
			consumableArray.push(consumables.W__BOOK);
			consumableArray.push(consumables.BC_BEER);
			consumableArray.push(consumables.BHMTCUM);
			consumableArray.push(consumables.BIMBOCH);
			consumableArray.push(consumables.C_BREAD);
			consumableArray.push(consumables.CCUPCAK);
			consumableArray.push(consumables.FISHFIL);
			//Page 4
			consumableArray.push(consumables.FR_BEER);
			consumableArray.push(consumables.GODMEAD);
			consumableArray.push(consumables.H_BISCU);
			consumableArray.push(consumables.IZYMILK);
			consumableArray.push(consumables.M__MILK);
			consumableArray.push(consumables.MINOCUM);
			consumableArray.push(consumables.P_BREAD);
			consumableArray.push(consumables.P_WHSKY);
			consumableArray.push(consumables.PURPEAC);
			consumableArray.push(consumables.SHEEPMK);
			consumableArray.push(consumables.S_WATER);
			consumableArray.push(consumables.NPNKEGG);
			//Page 5
			consumableArray.push(consumables.DRGNEGG);
			consumableArray.push(consumables.W_PDDNG);
			consumableArray.push(consumables.TRAILMX);
			consumableArray.push(consumables.URTACUM);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			//Page 6
			consumableArray.push(consumables.BLACKEG);
			consumableArray.push(consumables.L_BLKEG);
			consumableArray.push(consumables.BLUEEGG);
			consumableArray.push(consumables.L_BLUEG);
			consumableArray.push(consumables.BROWNEG);
			consumableArray.push(consumables.L_BRNEG);
			consumableArray.push(consumables.PINKEGG);
			consumableArray.push(consumables.L_PNKEG);
			consumableArray.push(consumables.PURPLEG);
			consumableArray.push(consumables.L_PRPEG);
			consumableArray.push(consumables.WHITEEG);
			consumableArray.push(consumables.L_WHTEG);
			
			//------------
			// Dyes
			//------------
			//Page 1
			dyeArray.push(consumables.AUBURND);
			dyeArray.push(consumables.BLACK_D);
			dyeArray.push(consumables.BLOND_D);
			dyeArray.push(consumables.BLUEDYE);
			dyeArray.push(consumables.BROWN_D);
			dyeArray.push(consumables.GRAYDYE);
			dyeArray.push(consumables.GREEN_D);
			dyeArray.push(consumables.ORANGDY);
			dyeArray.push(consumables.PINKDYE);
			dyeArray.push(consumables.PURPDYE);
			dyeArray.push(consumables.RAINDYE);
			dyeArray.push(consumables.RED_DYE);
			//Page 2
			dyeArray.push(consumables.RUSSDYE);
			dyeArray.push(consumables.YELLODY);
			dyeArray.push(consumables.WHITEDY);
			
			//------------
			// Materials
			//------------
			//Page 1, which is the only page for material so far. :(
			materialArray.push(useables.GREENGL);
			materialArray.push(useables.B_CHITN);
			materialArray.push(useables.T_SSILK);
			materialArray.push(useables.D_SCALE);
			materialArray.push(useables.EBNFLWR);
			materialArray.push(useables.IMPSKLL);
			materialArray.push(useables.LETHITE);
			materialArray.push(useables.OBSHARD);
			materialArray.push(null);
			materialArray.push(null);
			materialArray.push(null);
			materialArray.push(useables.CONDOM);
			//------------
			// Rare Items
			//------------
			//Page 1, again the only page available.
			rareArray.push(consumables.BIMBOLQ);
			rareArray.push(consumables.BROBREW);
			rareArray.push(consumables.HUMMUS2);
			rareArray.push(consumables.P_PEARL);
			
			rareArray.push(useables.DBGWAND);
			rareArray.push(useables.GLDSTAT);
			
			//------------
			// Weapons
			//------------
			//Page 1
			weaponArray.push(weapons.B_SCARB);
			weaponArray.push(weapons.B_SWORD);
			weaponArray.push(weapons.BLUNDR0);
			weaponArray.push(weapons.CLAYMR0);
			weaponArray.push(weapons.CRSBOW0);
			weaponArray.push(weapons.DAGGER0);
			weaponArray.push(weapons.E_STAFF);
			weaponArray.push(weapons.FLAIL_0);
			weaponArray.push(weapons.FLNTLK0);
			weaponArray.push(weapons.HALBRD0);
			weaponArray.push(weapons.H_GAUNT);
			weaponArray.push(weapons.HNTCANE);
			//Page 2
			weaponArray.push(weapons.JRAPIER);
			weaponArray.push(weapons.KATANA0);
			weaponArray.push(weapons.L__AXE0);
			weaponArray.push(weapons.L_DAGR0);
			weaponArray.push(weapons.L_HAMR0);
			weaponArray.push(weapons.L_STAFF);
			weaponArray.push(weapons.L_WHIP);
			weaponArray.push(weapons.MACE__0);
			weaponArray.push(weapons.MRAPIER);
			weaponArray.push(weapons.PIPE);
			weaponArray.push(weapons.PTCHFRK);			
			weaponArray.push(weapons.RIDING0);
			//Page 3
			weaponArray.push(weapons.RRAPIER);
			weaponArray.push(weapons.RSBLADE);
			weaponArray.push(weapons.S_BLADE);
			//Page 3
			weaponArray.push(weapons.S_GAUNT);
			weaponArray.push(weapons.SCARBLD);
			weaponArray.push(weapons.SCIMTR0);
			weaponArray.push(weapons.SPEAR_0);
			weaponArray.push(weapons.SUCWHIP);
			weaponArray.push(weapons.W_STAFF);
			weaponArray.push(weapons.WARHAM0);
			weaponArray.push(weapons.WHIP__0);
			weaponArray.push(weapons.U_SWORD);
			
			//------------
			// Shields
			//------------
			//Page 1, poor shield category is so lonely. :(
			shieldArray.push(shields.BUCKLR0);
			shieldArray.push(shields.DRGNSHL);
			shieldArray.push(shields.GRTSHL0);
			shieldArray.push(shields.KITESH0);
			shieldArray.push(shields.TOWRSH0);
			
			//------------
			// Armours
			//------------
			//Page 1
			armourArray.push(armors.ADVCLTH);
			armourArray.push(armors.B_DRESS);
			armourArray.push(armors.BEEARMR);
			armourArray.push(armors.BIMBOSK);
			armourArray.push(armors.BONSTRP);
			armourArray.push(armors.C_CLOTH);
			armourArray.push(armors.CHBIKNI);
			armourArray.push(armors.CLSSYCL);
			armourArray.push(armors.DBARMOR);
			armourArray.push(armors.EBNARMR);
			armourArray.push(armors.EBNROBE);
			armourArray.push(armors.EBNJACK);
			//Page 2
			armourArray.push(armors.EBNIROB);
			armourArray.push(armors.FULLCHN);
			armourArray.push(armors.FULLPLT);
			armourArray.push(armors.GELARMR);
			armourArray.push(armors.GOOARMR);
			armourArray.push(armors.I_CORST);
			armourArray.push(armors.I_ROBES);
			armourArray.push(armors.INDECST);
			armourArray.push(armors.KIMONO);
			armourArray.push(armors.LEATHRA);
			armourArray.push(armors.URTALTA);
			armourArray.push(armors.LMARMOR);
			//Page 3
			armourArray.push(armors.LTHCARM);
			armourArray.push(armors.LTHRPNT);
			armourArray.push(armors.LTHRROB);
			armourArray.push(armors.M_ROBES);
			armourArray.push(armors.TBARMOR);
			armourArray.push(armors.NURSECL);
			armourArray.push(armors.OVERALL);
			armourArray.push(armors.R_BDYST);
			armourArray.push(armors.RBBRCLT);
			armourArray.push(armors.S_SWMWR);
			armourArray.push(armors.SAMUARM);
			armourArray.push(armors.SCALEML);
			//Page 4
			armourArray.push(armors.SEDUCTA);
			armourArray.push(armors.SEDUCTU);
			armourArray.push(armors.SS_ROBE);
			armourArray.push(armors.SSARMOR);
			armourArray.push(armors.T_BSUIT);
			armourArray.push(armors.TUBETOP);
			armourArray.push(armors.W_ROBES);
			
			//------------
			// Undergarments
			//------------
			//Page 1
			undergarmentArray.push(undergarments.C_BRA);
			undergarmentArray.push(undergarments.C_LOIN);
			undergarmentArray.push(undergarments.C_PANTY);
			undergarmentArray.push(undergarments.DS_BRA);
			undergarmentArray.push(undergarments.DS_LOIN);
			undergarmentArray.push(undergarments.DSTHONG);
			undergarmentArray.push(undergarments.FUNDOSH);
			undergarmentArray.push(undergarments.FURLOIN);
			undergarmentArray.push(undergarments.GARTERS);
			undergarmentArray.push(undergarments.LTX_BRA);
			undergarmentArray.push(undergarments.LTXSHRT);
			undergarmentArray.push(undergarments.LTXTHNG);
			//Page 2
			undergarmentArray.push(undergarments.SS_BRA);
			undergarmentArray.push(undergarments.SS_LOIN);
			undergarmentArray.push(undergarments.SSPANTY);
			undergarmentArray.push(undergarments.EBNCRST);
			undergarmentArray.push(undergarments.EBNVEST);
			undergarmentArray.push(undergarments.EBNJOCK);
			undergarmentArray.push(undergarments.EBNTHNG);
			undergarmentArray.push(undergarments.EBNCLTH);
			undergarmentArray.push(undergarments.EBNRJCK);
			undergarmentArray.push(undergarments.EBNRTNG);
			undergarmentArray.push(undergarments.EBNRLNC);
			
			//------------
			// Accessories
			//------------
			//Page 1
			accessoryArray.push(jewelries.SILVRNG);
			accessoryArray.push(jewelries.GOLDRNG);
			accessoryArray.push(jewelries.PLATRNG);
			accessoryArray.push(jewelries.DIAMRNG);
			accessoryArray.push(jewelries.LTHCRNG);
			accessoryArray.push(jewelries.PURERNG);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			//Page 2
			accessoryArray.push(jewelries.CRIMRN1);
			accessoryArray.push(jewelries.FERTRN1);
			accessoryArray.push(jewelries.ICE_RN1);
			accessoryArray.push(jewelries.CRITRN1);
			accessoryArray.push(jewelries.REGNRN1);
			accessoryArray.push(jewelries.LIFERN1);
			accessoryArray.push(jewelries.MYSTRN1);
			accessoryArray.push(jewelries.POWRRN1);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			//Page 3
			accessoryArray.push(jewelries.CRIMRN2);
			accessoryArray.push(jewelries.FERTRN2);
			accessoryArray.push(jewelries.ICE_RN2);
			accessoryArray.push(jewelries.CRITRN2);
			accessoryArray.push(jewelries.REGNRN2);
			accessoryArray.push(jewelries.LIFERN2);
			accessoryArray.push(jewelries.MYSTRN2);
			accessoryArray.push(jewelries.POWRRN2);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			//Page 4
			accessoryArray.push(jewelries.CRIMRN3);
			accessoryArray.push(jewelries.FERTRN3);
			accessoryArray.push(jewelries.ICE_RN3);
			accessoryArray.push(jewelries.CRITRN3);
			accessoryArray.push(jewelries.REGNRN3);
			accessoryArray.push(jewelries.LIFERN3);
			accessoryArray.push(jewelries.MYSTRN3);
			accessoryArray.push(jewelries.POWRRN3);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			setArrays = true;
		}
		

		
		private function statChangeMenu():void {
			clearOutput();
			outputText("Which attribute would you like to alter?");
			menu();
			addButton(0, "Strength", statChangeAttributeMenu, "str");
			addButton(1, "Toughness", statChangeAttributeMenu, "tou");
			addButton(2, "Speed", statChangeAttributeMenu, "spe");
			addButton(3, "Intelligence", statChangeAttributeMenu, "int");
			addButton(5, "Libido", statChangeAttributeMenu, "lib");
			addButton(6, "Sensitivity", statChangeAttributeMenu, "sen");
			addButton(7, "Corruption", statChangeAttributeMenu, "cor");
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function statChangeAttributeMenu(stats:String = ""):void {
			var attribute:* = stats;
			clearOutput();
			outputText("Increment or decrement by how much?");
			addButton(0, "Add 1", statChangeApply, stats, 1);
			addButton(1, "Add 5", statChangeApply, stats, 5);
			addButton(2, "Add 10", statChangeApply, stats, 10);
			addButton(3, "Add 25", statChangeApply, stats, 25);
			addButton(4, "Add 50", statChangeApply, stats, 50);
			addButton(5, "Subtract 1", statChangeApply, stats, -1);
			addButton(6, "Subtract 5", statChangeApply, stats, -5);
			addButton(7, "Subtract 10", statChangeApply, stats, -10);
			addButton(8, "Subtract 25", statChangeApply, stats, -25);
			addButton(9, "Subtract 50", statChangeApply, stats, -50);
			addButton(14, "Back", statChangeMenu);
		}
		
		private function statChangeApply(stats:String = "", increment:Number = 0):void {
			dynStats(stats, increment);
			statScreenRefresh();
			statChangeAttributeMenu(stats);
		}
		
		private function styleHackMenu():void {
			menu();
			clearOutput();
			outputText("TEST STUFFZ");
			addButton(0, "ASPLODE", styleHackMenu).hint("MAKE SHIT ASPLODE");
			addButton(1, "Scorpion Tail", changeScorpionTail);
			addButton(2, "Be Manticore", getManticoreKit).hint("Gain everything needed to become a Manticore-morph.");
			addButton(3, "Be Dragonne", getDragonneKit).hint("Gain everything needed to become a Dragonne-morph.");
			addButton(4, "Debug Prison", debugPrison);
			addButton(5, "Tooltips Ahoy", kGAMECLASS.doNothing).hint("Ahoy! I'm a tooltip! I will show up a lot in future updates!", "Tooltip 2.0");
			addButton(8, "BodyPartEditor", bodyPartEditorRoot).hint("Inspect and fine-tune the player body parts");
			addButton(9, "HP Colour Debug", debugHPColour);
			addButton(14, "Back", accessDebugMenu);
		}
		private function generateTagDemos(...tags:Array):String {
			return tags.map(function(tag:String,index:int,array:Array):String {
				return "\\["+tag+"\\] = " +
					   getGame().parser.recursiveParser("["+tag+"]").replace(' ','\xA0')
			}).join(",\t");
		}
		private function showChangeOptions(backFn:Function, page:int, constants:Array, functionPageIndex:Function):void {
			var N:int = 12;
			for (var i:int = N * page; i < constants.length && i < (page + 1) * N; i++) {
				var e:* = constants[i];
				if (!(e is Array)) e = [i,e];
				addButton(i % N, e[1], curry(functionPageIndex, page, e[0]));
			}
			if (page > 0) addButton(12, "PrevPage", curry(functionPageIndex, page - 1));
			if ((page +1)*N < constants.length) addButton(13, "NextPage", curry(functionPageIndex, page + 1));
			addButton(14, "Back", backFn);
		}
		private function dumpPlayerData():void {
			clearOutput();
			var pa:PlayerAppearance = getGame().playerAppearance;
			pa.appearance(); // Until the PlayerAppearance is properly refactored
			/* [INTERMOD: xianxia]
			pa.describeRace();
			pa.describeFaceShape();
			outputText("  It has " + player.faceDesc() + ".", false); //M/F stuff!
			pa.describeEyes();
			pa.describeHairAndEars();
			pa.describeBeard();
			pa.describeTongue();
			pa.describeHorns();
			outputText("[pg]");
			pa.describeBodyShape();
			pa.describeWings();
			pa.describeRearBody();
			pa.describeArms();
			pa.describeLowerBody();
			*/
			outputText("[pg]");
	/*		outputText("player.skin = " + JSON.stringify(player.skin.saveToObject())
											  .replace(/":"/g,'":&nbsp; "')
											  .replace(/,"/g, ', "') + "\n");
			outputText("player.facePart = " + JSON.stringify(player.facePart.saveToObject()).replace(/,/g, ", ") + "\n");
	*/	}
		private function bodyPartEditorRoot():void {
			menu();
			dumpPlayerData();
			addButton(0,"Head",bodyPartEditorHead);
			addButton(1,"Skin & Hair",bodyPartEditorSkin);
			addButton(2,"Torso & Limbs",bodyPartEditorTorso);
//			addButton(3,"",bodyPartEditorValues);
//			addButton(4,"",bodyPartEditorCocks);
//			addButton(5,"",bodyPartEditorVaginas);
//			addButton(6,"",bodyPartEditorBreasts);
//			addButton(7,"",bodyPartEditorPiercings);
//			addButton(,"",change);
//			addButton(13, "Page2", bodyPartEditor2);
			addButton(14, "Back", accessDebugMenu);
		}
		private function bodyPartEditorSkin():void {
			menu();
			dumpPlayerData();
			tagDemosSkin();
			/* [INTERMOD: xianxia]
			addButton(0,"Skin Coverage",changeSkinCoverage);
			*/

			addButton(1,"SkinType",curry(changeLayerType,true));
			addButton(2,"SkinColor",curry(changeLayerColor,true));
			addButton(3,"SkinAdj",curry(changeLayerAdj,true));
			addButton(4,"SkinDesc",curry(changeLayerDesc,true));
			addButton(7,"FurColor",curry(changeLayerColor,false));
			/* [INTERMOD: xianxia]
			addButton(1,"SkinBaseType",curry(changeLayerType,true));
			addButton(2,"SkinBaseColor",curry(changeLayerColor,true));
			addButton(3,"SkinBaseAdj",curry(changeLayerAdj,true));
			addButton(4,"SkinBaseDesc",curry(changeLayerDesc,true));
			addButton(6,"SkinCoatType",curry(changeLayerType,false));
			addButton(7,"SkinCoatColor",curry(changeLayerColor,false));
			addButton(8,"SkinCoatAdj",curry(changeLayerAdj,false));
			addButton(9,"SkinCoatDesc",curry(changeLayerDesc,false));
			*/
			addButton(10,"HairType",changeHairType);
			addButton(11,"HairColor",changeHairColor);
			addButton(12,"HairLength",changeHairLength);
			addButton(14, "Back", bodyPartEditorRoot);
		}

		private static const SKIN_BASE_TYPES:Array = [
			/* [INTERMOD: xianxia]
			[Skin.PLAIN,"(0) PLAIN"],
			[Skin.GOO,"(3) GOO"],
			[Skin.STONE,"(7) STONE"]
			*/
			[Skin.PLAIN,"(0) PLAIN"],
			[Skin.FUR,"(1) FUR"],
			[Skin.LIZARD_SCALES,"(2) LIZARD_SCALES"],
			[Skin.GOO,"(3) GOO"],
			[Skin.UNDEFINED,"(4) UNDEFINED"],
			[Skin.DRAGON_SCALES,"(5) DRAGON_SCALES"],
			[Skin.FISH_SCALES,"(6) FISH_SCALES"],
			[Skin.WOOL,"(7) WOOL"],
			[Skin.FEATHERED,"(8) FEATHERED"],
		];
		private static const SKIN_COAT_TYPES:Array = SKIN_BASE_TYPES;
		/* [INTERMOD: xianxia]
		private static const SKIN_COAT_TYPES:Array = [
			[Skin.FUR,"(1) FUR"],
			[Skin.SCALES,"(2) SCALES"],
			[Skin.CHITIN,"(5) CHITIN"],
			[Skin.BARK,"(6) BARK"],
			[Skin.STONE,"(7) STONE"],
			[Skin.TATTOED,"(8) TATTOED"],
			[Skin.AQUA_SCALES,"(9) AQUA_SCALES"],
			[Skin.DRAGON_SCALES,"(10) DRAGON_SCALES"],
			[Skin.MOSS,"(11) MOSS"]
		];
		*/
		private static const SKIN_TONE_CONSTANTS:Array = [
			"pale", "light", "dark", "green", "gray",
			"blue", "black", "white", "dirty red", "blueish yellow",
			"ghostly pale", "bubblegum pink",
		];
		private static const SKIN_ADJ_CONSTANTS:Array = [
			"(none)", "tough", "smooth", "rough", "sexy",
			"freckled", "glistering", "shiny", "slimy","goopey",
			"latex", "rubber"
		];
		private static const SKIN_DESC_CONSTANTS:Array = [
			"(default)", "covering", "feathers", "hide",
			"shell", "plastic", "skin", "fur",
			"scales", "bark", "stone", "chitin"
		];
		/* [INTERMOD: xianxia]
		private static const SKIN_COVERAGE_CONSTANTS:Array = [
				[Skin.COVERAGE_NONE, "NONE (0)"],
				[Skin.COVERAGE_LOW, "LOW (1, partial)"],
				[Skin.COVERAGE_MEDIUM, "MEDIUM (2, mixed)"],
				[Skin.COVERAGE_HIGH, "HIGH (3, full)"],
				[Skin.COVERAGE_COMPLETE, "COMPLETE (4, full+face)"]
		];
		*/
		private static const HAIR_TYPE_CONSTANTS:Array = [
			[Hair.NORMAL,"(0) NORMAL"],
			[Hair.FEATHER,"(1) FEATHER"],
			[Hair.GHOST,"(2) GHOST"],
			[Hair.GOO,"(3) GOO"],
			[Hair.ANEMONE,"(4) ANEMONE"],
			[Hair.QUILL,"(5) QUILL"],
			/* [INTERMOD: xianxia]
			[Hair.GORGON,"(6) GORGON"],
			[Hair.LEAF,"(7) LEAF"],
			[Hair.FLUFFY,"(8) FLUFFY"],
			[Hair.GRASS,"(9) GRASS"],
			*/
			[Hair.BASILISK_SPINES, "(6) BASILISK_SPINES"],
			[Hair.BASILISK_PLUME, "(7) BASILISK_PLUME"],
			[Hair.WOOL, "(8) WOOL"],
		];
		private static const HAIR_COLOR_CONSTANTS:Array = [
			"blond", "brown", "black", "red", "white",
			"silver blonde","sandy-blonde", "platinum blonde", "midnight black", "golden blonde",
			"rainbow", "seven-colored",
		];
		private static const HAIR_LENGTH_CONSTANTS:Array = [
			0,0.5,1,2,4,
			8,12,24,32,40,
			64,72
		];
		private function tagDemosSkin():void {
			outputText("[pg]");
			outputText(generateTagDemos(
					"hairorfur", "skin", "skin.noadj", "skinfurscales", "skintone",
					"underbody.skinfurscales", "underbody.skintone", "face"
			)+".\n");

			/* [INTERMOD: xianxia]
			outputText(generateTagDemos(
							"skin", "skin base", "skin coat", "skin full",
							"skin noadj", "skin base.noadj", "skin coat.noadj", "skin full.noadj",
							"skin notone", "skin base.notone", "skin coat.notone", "skin full.notone",
							"skin type", "skin base.type", "skin coat.type", "skin full.type",
							"skin color", "skin base.color", "skin coat.color",
							"skin isare", "skin base.isare", "skin coat.isare",
							"skin vs","skin base.vs", "skin coat.vs",
							"skinfurscales", "skintone") + ".\n");
			outputText(generateTagDemos("face","face deco","face full","player.facePart.isDecorated")+".\n");
			*/
		}
		private function changeLayerType(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			/* [INTERMOD: xianxia]
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).type = setIdx;
			*/
			if (setIdx>=0) player.skin.type = setIdx;
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, editBase?SKIN_BASE_TYPES:SKIN_COAT_TYPES, curry(changeLayerType,editBase));
		}
		private function changeLayerColor(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			/* [INTERMOD: xianxia]
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).color = SKIN_TONE_CONSTANTS[setIdx];
			*/
			if (setIdx>=0) {
				if (editBase) player.skin.tone = SKIN_TONE_CONSTANTS[setIdx];
				else player.skin.furColor = SKIN_TONE_CONSTANTS[setIdx];
			}
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_TONE_CONSTANTS, curry(changeLayerColor,editBase));
		}
		private function changeLayerAdj(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			/* [INTERMOD: xianxia]
			var tgt:SkinLayer = (editBase?player.skin.base:player.skin.coat);
			*/
			var tgt:Skin = player.skin;
			if (setIdx==0) tgt.adj = "";
			if (setIdx>0) tgt.adj = SKIN_ADJ_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_ADJ_CONSTANTS, curry(changeLayerAdj,editBase));
		}
		private function changeLayerDesc(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			/* [INTERMOD: xianxia]
			var tgt:SkinLayer = (editBase?player.skin.base:player.skin.coat);
			*/
			var tgt:Skin = player.skin;
			if (setIdx==0) tgt.desc = "";
			if (setIdx>0) tgt.desc = SKIN_DESC_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_DESC_CONSTANTS, curry(changeLayerDesc,editBase));
		}
		/* [INTERMOD: xianxia]
		private function changeSkinCoverage(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.skin.coverage = setIdx;
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_COVERAGE_CONSTANTS, changeSkinCoverage);
		}
		*/
		private function changeHairType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hair.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, HAIR_TYPE_CONSTANTS, changeHairType);
		}
		private function changeHairColor(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hair.color = HAIR_COLOR_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, HAIR_COLOR_CONSTANTS, changeHairColor);
		}
		private function changeHairLength(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hair.length = HAIR_LENGTH_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, HAIR_LENGTH_CONSTANTS, changeHairLength);
		}
		private function bodyPartEditorHead():void {
			menu();
			dumpPlayerData();
			addButton(0,"FaceType",changeFaceType);
			addButton(1,"TongueType",changeTongueType);
			addButton(2,"EyeType",changeEyeType);
			addButton(3,"EarType",changeEarType);
			addButton(4,"AntennaeType",changeAntennaeType);
			addButton(5,"HornType",changeHornType);
			addButton(6,"HornCount",changeHornCount);
			addButton(7,"GillType",changeGillType);
			addButton(8,"BeardStyle",changeBeardStyle);
			addButton(9,"BeardLength",changeBeardLength);
			/*addButton(,"FaceDecoType",changeFaceDecoType);
			addButton(,"FaceDecoAdj",changeFaceDecoAdj);*/
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const FACE_TYPE_CONSTANTS:Array = [
			[Face.HUMAN,"(0) HUMAN"],
			[Face.HORSE,"(1) HORSE"],
			[Face.DOG,"(2) DOG"],
			[Face.COW_MINOTAUR,"(3) COW_MINOTAUR"],
			[Face.SHARK_TEETH,"(4) SHARK_TEETH"],
			[Face.SNAKE_FANGS,"(5) SNAKE_FANGS"],
			[Face.CAT,"(6) CAT"],
			[Face.LIZARD,"(7) LIZARD"],
			[Face.BUNNY,"(8) BUNNY"],
			[Face.KANGAROO,"(9) KANGAROO"],
			[Face.SPIDER_FANGS,"(10) SPIDER_FANGS"],
			[Face.FOX,"(11) FOX"],
			[Face.DRAGON,"(12) DRAGON"],
			[Face.RACCOON_MASK,"(13) RACCOON_MASK"],
			[Face.RACCOON,"(14) RACCOON"],
			[Face.BUCKTEETH,"(15) BUCKTEETH"],
			[Face.MOUSE,"(16) MOUSE"],
			[Face.FERRET_MASK,"(17) FERRET_MASK"],
			[Face.FERRET,"(18) FERRET"],
			[Face.PIG,"(19) PIG"],
			[Face.BOAR,"(20) BOAR"],
			[Face.RHINO,"(21) RHINO"],
			[Face.ECHIDNA,"(22) ECHIDNA"],
			[Face.DEER,"(23) DEER"],
			[Face.WOLF,"(24) WOLF"],
			[Face.COCKATRICE,"(25) COCKATRICE"],
			//[Face.BEAK,"(26) BEAK"], // Unused placeholder
			[Face.RED_PANDA,"(27) RED_PANDA"],
			/* [INTERMOD: xianxia]
			[Face.MANTICORE,"(25) MANTICORE"],
			[Face.SALAMANDER_FANGS,"(26) SALAMANDER_FANGS"],
			[Face.YETI_FANGS,"(27) YETI_FANGS"],
			[Face.ORCA,"(28) ORCA"],
			[Face.PLANT_DRAGON,"(29) PLANT_DRAGON"]
			*/
		];
		/* [INTERMOD: xianxia]
		private static const DECO_DESC_CONSTANTS:Array = [
			[DECORATION_NONE,"(0) NONE"],
			[DECORATION_GENERIC,"(1) GENERIC"],
			[DECORATION_TATTOO,"(2) TATTOO"],
		];
		private static const DECO_ADJ_CONSTANTS:Array = [
			"(none)", "magic", "glowing", "sexy","",
			"", "", "mark", "burn", "scar"
		];
		*/
		private static const TONGUE_TYPE_CONSTANTS:Array = [
			[Tongue.HUMAN, "(0) HUMAN"],
			[Tongue.SNAKE, "(1) SNAKE"],
			[Tongue.DEMONIC, "(2) DEMONIC"],
			[Tongue.DRACONIC, "(3) DRACONIC"],
			[Tongue.ECHIDNA, "(4) ECHIDNA"],
			[Tongue.LIZARD, "(5) LIZARD"],
			/* [INTERMOD: xianxia]
			[Tongue.CAT, "(5) CAT"],
			*/
		];
		private static const EYE_TYPE_CONSTANTS:Array = [
			[Eyes.HUMAN, "(0) HUMAN"],
			[Eyes.BLACK_EYES_SAND_TRAP, "(2) BLACK_EYES_SAND_TRAP"],
			/* [INTERMOD: xianxia]
			[Eyes.CAT_SLITS, "(3) CAT_SLITS"],
			[Eyes.GORGON, "(4) GORGON"],
			[Eyes.FENRIR, "(5) FENRIR"],
			[Eyes.MANTICORE, "(6) MANTICORE"],
			[Eyes.FOX, "(7) FOX"],
			[Eyes.REPTILIAN, "(8) REPTILIAN"],
			[Eyes.SNAKE, "(9) SNAKE"],
			[Eyes.DRAGON, "(10) DRAGON"],
			*/
			[Eyes.LIZARD, "(3) LIZARD"],
			[Eyes.DRAGON, "(4) DRAGON"],
			[Eyes.BASILISK, "(5) BASILISK"],
			[Eyes.WOLF, "(6) WOLF"],
			[Eyes.SPIDER, "(7) SPIDER"],
			[Eyes.COCKATRICE, "(8) COCKATRICE"],
		];
		private static const EAR_TYPE_CONSTANTS:Array    = [
			[Ears.HUMAN, "(0) HUMAN"],
			[Ears.HORSE, "(1) HORSE"],
			[Ears.DOG, "(2) DOG"],
			[Ears.COW, "(3) COW"],
			[Ears.ELFIN, "(4) ELFIN"],
			[Ears.CAT, "(5) CAT"],
			[Ears.LIZARD, "(6) LIZARD"],
			[Ears.BUNNY, "(7) BUNNY"],
			[Ears.KANGAROO, "(8) KANGAROO"],
			[Ears.FOX, "(9) FOX"],
			[Ears.DRAGON, "(10) DRAGON"],
			[Ears.RACCOON, "(11) RACCOON"],
			[Ears.MOUSE, "(12) MOUSE"],
			[Ears.FERRET, "(13) FERRET"],
			[Ears.PIG, "(14) PIG"],
			[Ears.RHINO, "(15) RHINO"],
			[Ears.ECHIDNA, "(16) ECHIDNA"],
			[Ears.DEER, "(17) DEER"],
			[Ears.WOLF, "(18) WOLF"],
			/* [INTERMOD: xianxia]
			[Ears.LION, "(19) LION"],
			[Ears.YETI, "(20) YETI"],
			[Ears.ORCA, "(21) ORCA"],
			[Ears.SNAKE, "(22) SNAKE"],
			*/
			[Ears.SHEEP, "(19) SHEEP"],
			[Ears.IMP, "(20) IMP"],
			[Ears.COCKATRICE, "(21) COCKATRICE"],
			[Ears.RED_PANDA, "(22) RED_PANDA"],
		];
		private static const HORN_TYPE_CONSTANTS:Array    = [
			[Horns.NONE, "(0) NONE"],
			[Horns.DEMON, "(1) DEMON"],
			[Horns.COW_MINOTAUR, "(2) COW_MINOTAUR"],
			[Horns.DRACONIC_X2, "(3) DRACONIC_X2"],
			[Horns.DRACONIC_X4_12_INCH_LONG, "(4) DRACONIC_X4_12_INCH_LONG"],
			[Horns.ANTLERS, "(5) ANTLERS"],
			[Horns.GOAT, "(6) GOAT"],
			[Horns.UNICORN, "(7) UNICORN"],
			[Horns.RHINO, "(8) RHINO"],
			[Horns.SHEEP, "(9) SHEEP"],
			[Horns.RAM, "(10) RAM"],
			[Horns.IMP, "(11) IMP"],
			/* [INTERMOD: xianxia]
			[Horns.OAK, "(9) OAK"],
			[Horns.GARGOYLE, "(10) GARGOYLE"],
			[Horns.ORCHID, "(11) ORCHID"],
			*/
		];
		private static const HORN_COUNT_CONSTANTS:Array = [
				0,1,2,3,4,
				5,6,8,10,12,
				16,20
		];
		private static const ANTENNA_TYPE_CONSTANTS:Array = [
			[Antennae.NONE, "(0) NONE"],
			/* [INTERMOD: xianxia]
			[Antennae.MANTIS, "(1) MANTIS"],
			 */
			[Antennae.BEE, "(2) BEE"],
			[Antennae.COCKATRICE, "(3) COCKATRICE"],
		];
		private static const GILLS_TYPE_CONSTANTS:Array   = [
			[Gills.NONE, "(0) NONE"],
			[Gills.ANEMONE, "(1) ANEMONE"],
			[Gills.FISH, "(2) FISH"],
			/* [INTERMOD: xianxia]
			[Gills.IN_TENTACLE_LEGS, "(3) IN_TENTACLE_LEGS"],
			 */
		];
		private static const BEARD_STYLE_CONSTANTS:Array = [
			[Beard.NORMAL,"(0) NORMAL"],
			[Beard.GOATEE,"(1) GOATEE"],
			[Beard.CLEANCUT,"(2) CLEANCUT"],
			[Beard.MOUNTAINMAN,"(3) MOUNTAINMAN"],
		];
		private static const BEARD_LENGTH_CONSTANTS:Array = [
			0,0.1,0.3,2,4,
			8,12,16,32,64,
		];
		private function changeFaceType(page:int=0,setIdx:int=-1):void {
			/* [INTERMOD: xianxia]
			if (setIdx>=0) player.facePart.type = setIdx;
			*/
			if (setIdx>=0) player.face.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, FACE_TYPE_CONSTANTS, changeFaceType);
		}
		/* [INTERMOD: xianxia]
		private function changeFaceDecoType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.facePart.decoType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, DECO_DESC_CONSTANTS, changeFaceDecoType);
		}
		private function changeFaceDecoAdj(page:int=0,setIdx:int=-1):void {
			if (setIdx==0) player.facePart.decoAdj = "";
			if (setIdx>0) player.facePart.decoAdj = DECO_ADJ_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, DECO_ADJ_CONSTANTS, changeFaceDecoAdj);
		}
		*/
		private function changeTongueType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.tongue.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, TONGUE_TYPE_CONSTANTS, changeTongueType);
		}
		private function changeEyeType(page:int=0,setIdx:int=-1):void {
			if (setIdx >= 0) player.eyes.type = setIdx;
			if (player.eyes.type == Eyes.SPIDER) player.eyes.count = 4;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, EYE_TYPE_CONSTANTS, changeEyeType);
		}
		private function changeEarType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.ears.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, EAR_TYPE_CONSTANTS, changeEarType);
		}
		private function changeHornType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.horns.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, HORN_TYPE_CONSTANTS, changeHornType);
		}
		private function changeHornCount(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.horns.value = HORN_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorHead, page, HORN_COUNT_CONSTANTS, changeHornCount);
		}
		private function changeAntennaeType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.antennae.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, ANTENNA_TYPE_CONSTANTS, changeAntennaeType);
		}
		private function changeGillType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.gills.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, GILLS_TYPE_CONSTANTS, changeGillType);
		}
		private function changeBeardStyle(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.beard.style = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, BEARD_STYLE_CONSTANTS, changeBeardStyle);
		}
		private function changeBeardLength(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.beard.length = BEARD_LENGTH_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorHead, page, BEARD_LENGTH_CONSTANTS, changeBeardLength);
		}
		private function bodyPartEditorTorso():void {
			menu();
			dumpPlayerData();
			addButton(0,"ArmType",changeArmType);
			addButton(1,"ClawType",changeClawType);
			addButton(2,"ClawTone",changeClawTone);
			addButton(3,"TailType",changeTailType);
			addButton(4,"TailCount",changeTailCount);
			addButton(5,"WingType",changeWingType);
			addButton(6,"LowerBodyType",changeLowerBodyType);
			addButton(7,"LegCount",changeLegCount);
			/* [INTERMOD: xianxia]
			addButton(9,"ReadBodyType",changeRearBodyType);
			*/
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const ARM_TYPE_CONSTANTS:Array   = [
			[Arms.HUMAN, "(0) HUMAN"],
			[Arms.HARPY, "(1) HARPY"],
			[Arms.SPIDER, "(2) SPIDER"],
			[Arms.BEE, "(3) BEE"],
			/* [INTERMOD: xianxia]
			[Arms.MANTIS, "(3) MANTIS"],
			*/
			[Arms.SALAMANDER, "(5) SALAMANDER"],
			/* [INTERMOD: xianxia]
			[Arms.PHOENIX, "(6) PHOENIX"],
			[Arms.PLANT, "(7) PLANT"],
			[Arms.SHARK, "(8) SHARK"],
			[Arms.GARGOYLE, "(9) GARGOYLE"],
			[Arms.WOLF, "(10) WOLF"],
			[Arms.LION, "(11) LION"],
			[Arms.KITSUNE, "(12) KITSUNE"],
			[Arms.FOX, "(13) FOX"],
			[Arms.LIZARD, "(14) LIZARD"],
			[Arms.DRAGON, "(15) DRAGON"],
			[Arms.YETI, "(16) YETI"],
			[Arms.ORCA, "(17) ORCA"],
			[Arms.PLANT2, "(18) PLANT2"],
			*/
			[Arms.WOLF, "(6) WOLF"],
		];
		private static const CLAW_TYPE_CONSTANTS:Array = [
			[Claws.NORMAL,"(0) NORMAL"],
			[Claws.LIZARD,"(1) LIZARD"],
			[Claws.DRAGON,"(2) DRAGON"],
			[Claws.SALAMANDER,"(3) SALAMANDER"],
			[Claws.CAT,"(4) CAT"],
			[Claws.DOG,"(5) DOG"],
			[Claws.RAPTOR,"(6) RAPTOR"],
			[Claws.MANTIS,"(7) MANTIS"],
		];
		private static const TAIL_TYPE_CONSTANTS:Array  = [
			[Tail.NONE, "(0) NONE"],
			[Tail.HORSE, "(1) HORSE"],
			[Tail.DOG, "(2) DOG"],
			[Tail.DEMONIC, "(3) DEMONIC"],
			[Tail.COW, "(4) COW"],
			[Tail.SPIDER_ABDOMEN, "(5) SPIDER_ADBOMEN"],
			[Tail.BEE_ABDOMEN, "(6) BEE_ABDOMEN"],
			[Tail.SHARK, "(7) SHARK"],
			[Tail.CAT, "(8) CAT"],
			[Tail.LIZARD, "(9) LIZARD"],
			[Tail.RABBIT, "(10) RABBIT"],
			[Tail.HARPY, "(11) HARPY"],
			[Tail.KANGAROO, "(12) KANGAROO"],
			[Tail.FOX, "(13) FOX"],
			[Tail.DRACONIC, "(14) DRACONIC"],
			[Tail.RACCOON, "(15) RACCOON"],
			[Tail.MOUSE, "(16) MOUSE"],
			[Tail.FERRET, "(17) FERRET"],
			[Tail.BEHEMOTH, "(18) BEHEMOTH"],
			[Tail.PIG, "(19) PIG"],
			[Tail.SCORPION, "(20) SCORPION"],
			[Tail.GOAT, "(21) GOAT"],
			[Tail.RHINO, "(22) RHINO"],
			[Tail.ECHIDNA, "(23) ECHIDNA"],
			[Tail.DEER, "(24) DEER"],
			[Tail.SALAMANDER, "(25) SALAMANDER"],
			[Tail.WOLF, "(26) WOLF"],
			[Tail.SHEEP, "(27) SHEEP"],
			[Tail.IMP, "(28) IMP"],
			[Tail.COCKATRICE, "(29) COCKATRICE"],
			[Tail.RED_PANDA, "(30) RED_PANDA"],
			/* [INTERMOD: xianxia]
			[Tail.KITSHOO, "(26) KITSHOO"],
			[Tail.MANTIS_ABDOMEN, "(27) MANTIS_ABDOMEN"],
			[Tail.MANTICORE_PUSSYTAIL, "(28) MANTICORE_PUSSYTAIL"],
			[Tail.WOLF, "(29) WOLF"],
			[Tail.GARGOYLE, "(30) GARGOYLE"],
			[Tail.ORCA, "(31) ORCA"],
			[Tail.YGGDRASIL, "(32) YGGDRASIL"],
			*/
		];
		private static const TAIL_COUNT_CONSTANTS:Array = [
			[0,"0"],1,2,3,4,
			5,6,7,8,9,
			10,16
		];
		private static const WING_TYPE_CONSTANTS:Array  = [
			[Wings.NONE, "(0) NONE"],
			[Wings.BEE_LIKE_SMALL, "(1) BEE_LIKE_SMALL"],
			[Wings.BEE_LIKE_LARGE, "(2) BEE_LIKE_LARGE"],
			[Wings.HARPY, "(4) HARPY"],
			[Wings.IMP, "(5) IMP"],
			[Wings.BAT_LIKE_TINY, "(6) BAT_LIKE_TINY"],
			[Wings.BAT_LIKE_LARGE, "(7) BAT_LIKE_LARGE"],
			[Wings.FEATHERED_LARGE, "(9) FEATHERED_LARGE"],
			[Wings.DRACONIC_SMALL, "(10) DRACONIC_SMALL"],
			[Wings.DRACONIC_LARGE, "(11) DRACONIC_LARGE"],
			[Wings.GIANT_DRAGONFLY, "(12) GIANT_DRAGONFLY"],
			/* [INTERMOD: xianxia]
			[Wings.BAT_LIKE_LARGE_2, "(13) BAT_LIKE_LARGE_2"],
			[Wings.DRACONIC_HUGE, "(14) DRACONIC_HUGE"],
			[Wings.FEATHERED_PHOENIX, "(15) FEATHERED_PHOENIX"],
			[Wings.FEATHERED_ALICORN, "(16) FEATHERED_ALICORN"],
			[Wings.MANTIS_LIKE_SMALL, "(17) MANTIS_LIKE_SMALL"],
			[Wings.MANTIS_LIKE_LARGE, "(18) MANTIS_LIKE_LARGE"],
			[Wings.MANTIS_LIKE_LARGE_2, "(19) MANTIS_LIKE_LARGE_2"],
			[Wings.GARGOYLE_LIKE_LARGE, "(20) GARGOYLE_LIKE_LARGE"],
			[Wings.PLANT, "(21) PLANT"],
			[Wings.MANTICORE_LIKE_SMALL, "(22) MANTICORE_LIKE_SMALL"],
			[Wings.MANTICORE_LIKE_LARGE, "(23) MANTICORE_LIKE_LARGE"],
			*/
			[Wings.IMP_LARGE, "(13) IMP_LARGE"],
		];
		private static const WING_DESC_CONSTANTS:Array = [
			"(none)","non-existent","tiny hidden","huge","small",
			"giant gragonfly","large bee-like","small bee-like",
			"large, feathered","fluffy featherly","large white feathered","large crimson feathered",
			"large, bat-like","two large pairs of bat-like",
			"imp","small black faerie wings",
			"large, draconic","large, majestic draconic","small, draconic",
			"large manticore-like","small manticore-like",
			"large mantis-like","small mantis-like",
		];
		private static const LOWER_TYPE_CONSTANTS:Array = [
			[LowerBody.HUMAN, "(0) HUMAN"],
			[LowerBody.HOOFED, "(1) HOOFED"],
			[LowerBody.DOG, "(2) DOG"],
			[LowerBody.NAGA, "(3) NAGA"],
			[LowerBody.DEMONIC_HIGH_HEELS, "(5) DEMONIC_HIGH_HEELS"],
			[LowerBody.DEMONIC_CLAWS, "(6) DEMONIC_CLAWS"],
			[LowerBody.BEE, "(7) BEE"],
			[LowerBody.GOO, "(8) GOO"],
			[LowerBody.CAT, "(9) CAT"],
			[LowerBody.LIZARD, "(10) LIZARD"],
			[LowerBody.PONY, "(11) PONY"],
			[LowerBody.BUNNY, "(12) BUNNY"],
			[LowerBody.HARPY, "(13) HARPY"],
			[LowerBody.KANGAROO, "(14) KANGAROO"],
			[LowerBody.CHITINOUS_SPIDER_LEGS, "(15) CHITINOUS_SPIDER_LEGS"],
			[LowerBody.DRIDER, "(16) DRIDER"],
			[LowerBody.FOX, "(17) FOX"],
			[LowerBody.DRAGON, "(18) DRAGON"],
			[LowerBody.RACCOON, "(19) RACCOON"],
			[LowerBody.FERRET, "(20) FERRET"],
			[LowerBody.CLOVEN_HOOFED, "(21) CLOVEN_HOOFED"],
			[LowerBody.ECHIDNA, "(23) ECHIDNA"],
			[LowerBody.SALAMANDER, "(25) SALAMANDER"],
			[LowerBody.WOLF, "(26) WOLF"],
			[LowerBody.IMP, "(27) IMP"],
			[LowerBody.COCKATRICE, "(28) COCKATRICE"],
			[LowerBody.RED_PANDA, "(29) RED_PANDA"],
			/* [INTERMOD: xianxia]
			[LowerBody.SCYLLA, "(26) SCYLLA"],
			[LowerBody.MANTIS, "(27) MANTIS"],
			[LowerBody.SHARK, "(29) SHARK"],
			[LowerBody.GARGOYLE, "(30) GARGOYLE"],
			[LowerBody.PLANT_HIGH_HEELS, "(31) PLANT_HIGH_HEELS"],
			[LowerBody.PLANT_ROOT_CLAWS, "(32) PLANT_ROOT_CLAWS"],
			[LowerBody.WOLF, "(33) WOLF"],
			[LowerBody.PLANT_FLOWER, "(34) PLANT_FLOWER"],
			[LowerBody.LION, "(35) LION"],
			[LowerBody.YETI, "(36) YETI"],
			[LowerBody.ORCA, "(37) ORCA"],
			[LowerBody.YGG_ROOT_CLAWS, "(38) YGG_ROOT_CLAWS"],
			*/
		];
		private static const LEG_COUNT_CONSTANTS:Array = [
			1,2,4,6,8,
			10,12,16
		];
		/* [INTERMOD: xianxia]
		private static const REAR_TYPE_CONSTANTS:Array  = [
			[RearBody.NONE, "(0) NONE"],
			[RearBody.DRACONIC_MANE, "(1) DRACONIC_MANE"],
			[RearBody.DRACONIC_SPIKES, "(2) DRACONIC_SPIKES"],
			[RearBody.FENRIR_ICE_SPIKES, "(3) FENRIR_ICE_SPIKES"],
			[RearBody.LION_MANE, "(4) LION_MANE"],
			[RearBody.BEHEMOTH, "(5) BEHEMOTH"],
			[RearBody.SHARK_FIN, "(6) SHARK_FIN"],
			[RearBody.ORCA_BLOWHOLE, "(7) ORCA_BLOWHOLE"],
		];
		*/
		private function changeArmType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.arms.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, ARM_TYPE_CONSTANTS, changeArmType);
		}
		private function changeClawType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.arms.claws.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, CLAW_TYPE_CONSTANTS, changeClawType);
		}
		private function changeClawTone(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.arms.claws.tone = SKIN_TONE_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, SKIN_TONE_CONSTANTS, changeClawTone);
		}
		private function changeTailType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.tail.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, TAIL_TYPE_CONSTANTS, changeTailType);
		}
		private function changeTailCount(page:int=0,setIdx:int=-1):void {
			/* [INTERMOD: xianxia]
			if (setIdx>=0) player.tailCount = TAIL_COUNT_CONSTANTS[setIdx];
			*/
			if (setIdx>=0) player.tail.venom = TAIL_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, TAIL_COUNT_CONSTANTS, changeTailCount);
		}
		private function changeWingType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.wings.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, WING_TYPE_CONSTANTS, changeWingType);
		}
		private function changeLowerBodyType(page:int=0,setIdx:int=-1):void {
			/* [INTERMOD: xianxia]
			if (setIdx>=0) player.lowerBodyPart.typePart.type = setIdx;
			*/
			if (setIdx>=0) player.lowerBody.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, LOWER_TYPE_CONSTANTS, changeLowerBodyType);
		}
		private function changeLegCount(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.lowerBody.legCount = LEG_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, LEG_COUNT_CONSTANTS, changeLegCount);
		}
		/* [INTERMOD: xianxia]
		private function changeRearBodyType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.rearBody = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, REAR_TYPE_CONSTANTS, changeRearBodyType);
		}
		*/
		private function changeScorpionTail():void {
			clearOutput();
			outputText("<b>Your tail is now that of a scorpion's. Currently, scorpion tail has no use but it will eventually be useful for stinging.</b>");
			player.tail.type = Tail.SCORPION;
			player.tail.venom = 100;
			player.tail.recharge = 5;
			doNext(styleHackMenu);
		}
		
		private function getManticoreKit():void {
			clearOutput();
			outputText("<b>You are now a Manticore!</b>");
			//Cat TF
			player.face.type = Face.CAT;
			player.ears.type = Ears.CAT;
			player.lowerBody.type = LowerBody.CAT;
			player.lowerBody.legCount = 2;
			player.skin.type = Skin.FUR;
			player.skin.desc = "fur";
			player.underBody.restore(); // Restore the underbody for now
			//Draconic TF
			player.horns.type = Horns.DRACONIC_X2;
			player.horns.value = 4;
			player.wings.type = Wings.BAT_LIKE_LARGE;
			//Scorpion TF
			player.tail.type = Tail.SCORPION;
			player.tail.venom = 100;
			player.tail.recharge = 5;
			doNext(styleHackMenu);
		}
		
		private function getDragonneKit():void {
			clearOutput();
			outputText("<b>You are now a Dragonne!</b>");
			//Cat TF
			player.face.type = Face.CAT;
			player.ears.type = Ears.CAT;
			player.tail.type = Tail.CAT;
			player.lowerBody.type = LowerBody.CAT;
			player.lowerBody.legCount = 2;
			//Draconic TF
			player.skin.type = Skin.DRAGON_SCALES;
			player.skin.adj = "tough";
			player.skin.desc = "shield-shaped dragon scales";
			player.skin.furColor = player.hair.color;
			player.underBody.type = UnderBody.REPTILE;
			player.copySkinToUnderBody({       // copy the main skin props to the underBody skin ...
				desc: "ventral dragon scales"  // ... and only override the desc
			});
			player.tongue.type = Tongue.DRACONIC;
			player.horns.type = Horns.DRACONIC_X2;
			player.horns.value = 4;
			player.wings.type = Wings.DRACONIC_LARGE;
			doNext(styleHackMenu);
		}
		
		private function debugHPColour():void {
			var normalHP:int = player.HP;
			player.HP = 0;
			statScreenRefresh();
			var t:Timer = new Timer(3000, 1);
			t.addEventListener(TimerEvent.TIMER, createCallBackFunction(messWithHP, normalHP));
			t.start();
		}
		private function messWithHP(normalHP:int):void {
			player.HP = player.maxHP();
			statScreenRefresh();
		}
		
		private function debugPrison():void {
			clearOutput();
			doNext(styleHackMenu);
			//Stored equipment
			outputText("<b><u>Stored equipment:</u></b>");
			outputText("\n<b>Stored armour:</b> ");
			if (flags[kFLAGS.PRISON_STORAGE_ARMOR] != 0) {
				outputText("" + ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_ARMOR]));
			}
			else outputText("None");
			outputText("\n<b>Stored weapon:</b> ");
			if (flags[kFLAGS.PRISON_STORAGE_WEAPON] != 0) {
				outputText("" + ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_WEAPON]));
			}
			else outputText("None");
			outputText("\n<b>Stored shield:</b> ");
			if (flags[kFLAGS.PRISON_STORAGE_SHIELD] != 0) {
				outputText("" + ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_SHIELD]));
			}
			else outputText("None");
			//Stored items
			outputText("\n\n<b><u>Stored items:</u></b>");
			for (var i:int = 0; i < 10; i++) {
				if (player.prisonItemSlots[i*2] != null && player.prisonItemSlots[i*2] != undefined) {
					outputText("\n" + player.prisonItemSlots[i*2]);
					outputText(" x" + player.prisonItemSlots[(i*2) +1]);
				}
			}
			output.flush();
		}

		private function toggleMeaninglessCorruption():void {
			clearOutput();
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] == 0) {
				flags[kFLAGS.MEANINGLESS_CORRUPTION] = 1;
				outputText("<b>Set MEANINGLESS_CORRUPTION flag to 1.</b>");
			}
			else {
				flags[kFLAGS.MEANINGLESS_CORRUPTION] = 0;
				outputText("<b>Set MEANINGLESS_CORRUPTION flag to 0.</b>");
			}
		}
		
		private function resetNPCMenu():void {
			clearOutput();
			outputText("Which NPC would you like to reset?");
			menu();
			if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] < 0 || flags[kFLAGS.URTA_QUEST_STATUS] == -1) addButton(0, "Urta", resetUrta);
			if (flags[kFLAGS.JOJO_STATUS] >= 5 || flags[kFLAGS.JOJO_DEAD_OR_GONE] > 0) addButton(1, "Jojo", resetJojo);
			if (flags[kFLAGS.EGG_BROKEN] > 0) addButton(2, "Ember", resetEmber);
			if (flags[kFLAGS.SHEILA_DISABLED] > 0 || flags[kFLAGS.SHEILA_DEMON] > 0 || flags[kFLAGS.SHEILA_CITE] < 0 || flags[kFLAGS.SHEILA_CITE] >= 6) addButton(6, "Sheila", resetSheila);
			
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function resetUrta():void {
			clearOutput();
			outputText("Did you do something wrong and get Urta heartbroken or did you fail Urta's quest? You can reset if you want to.");
			doYesNo(reallyResetUrta, resetNPCMenu);
		}
		private function reallyResetUrta():void {
			clearOutput();
			if (flags[kFLAGS.URTA_QUEST_STATUS] == -1) {
				outputText("Somehow, you have a feeling that Urta somehow went back to Tel'Adre.  ");
				flags[kFLAGS.URTA_QUEST_STATUS] = 0;
			}
			if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] < 0) {
				outputText("You have a feeling that Urta finally got over with her depression and went back to normal.  ");
				flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function resetSheila():void {
			clearOutput();
			outputText("Did you do something wrong with Sheila? Turned her into demon? Lost the opportunity to get her lethicite? No problem, you can just reset her!");
			doYesNo(reallyResetSheila, resetNPCMenu);
		}
		private function reallyResetSheila():void {
			clearOutput();
			if (flags[kFLAGS.SHEILA_DISABLED] > 0) {
				outputText("You can finally encounter Sheila again!  ");
				flags[kFLAGS.SHEILA_DISABLED] = 0;
			}
			if (flags[kFLAGS.SHEILA_DEMON] > 0) {
				outputText("Sheila is no longer a demon; she is now back to normal.  ");
				flags[kFLAGS.SHEILA_DEMON] = 0;
				flags[kFLAGS.SHEILA_CORRUPTION] = 30;
			}
			if (flags[kFLAGS.SHEILA_CITE] < 0) {
				outputText("Any lost Lethicite opportunity is now regained.  ");
				flags[kFLAGS.SHEILA_CITE] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function resetJojo():void {
			clearOutput();
			outputText("Did you do something wrong with Jojo? Corrupted him? Accidentally removed him from the game? No problem!");
			doYesNo(reallyResetJojo, resetNPCMenu);
		}
		private function reallyResetJojo():void {
			clearOutput();
			if (flags[kFLAGS.JOJO_STATUS] > 1) {
				outputText("Jojo is no longer corrupted!  ");
				flags[kFLAGS.JOJO_STATUS] = 0;
			}
			if (flags[kFLAGS.JOJO_DEAD_OR_GONE] > 0) {
				outputText("Jojo has respawned.  ");
				flags[kFLAGS.JOJO_DEAD_OR_GONE] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function resetEmber():void {
			clearOutput();
			outputText("Did you destroy the egg containing Ember? Want to restore the egg so you can take it?");
			doYesNo(reallyResetEmber, resetNPCMenu);
		}
		private function reallyResetEmber():void {
			clearOutput();
			if (flags[kFLAGS.EGG_BROKEN] > 0) {
				outputText("Egg is now restored. Go find it in swamp! And try not to destroy it next time.  ");
				flags[kFLAGS.EGG_BROKEN] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function abortPregnancy():void {
			clearOutput();
			outputText("You feel as if something's dissolving inside your womb. Liquid flows out of your [vagina] and your womb feels empty now. <b>You are no longer pregnant!</b>");
			player.knockUpForce();
			doNext(accessDebugMenu);
		}
		
		//[Flag Editor]
		private function flagEditor():void {
			clearOutput();
			menu();
			outputText("This is the Flag Editor.  You can edit flags from here.  For flags reference, look at kFLAGS.as class file.  Please input any number from 0 to 2999.");
			outputText("\n\n<b>WARNING: This might screw up your save file so backup your saves before using this!</b>");
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 4;
			mainView.nameBox.restrict = "0-9";
			addButton(0, "OK", editFlag);
			addButton(4, "Done", accessDebugMenu);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		}
		
		private function editFlag():void {
			var flagId:int = int(mainView.nameBox.text);
			clearOutput();
			menu();
			if (flagId < 0 || flagId >= 3000) {
				mainView.nameBox.visible = false;
				outputText("That flag does not exist!");
				doNext(flagEditor);
				return;
			}
			mainView.nameBox.visible = true;
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			mainView.nameBox.maxChars = 127;
			mainView.nameBox.restrict = null;
			mainView.nameBox.text = flags[flagId];
			addButton(0, "Save", saveFlag, flagId);
			addButton(1, "Discard", flagEditor);
		}
		
		private function saveFlag(flagId:int = 0):void {
			var temp:* = Number(mainView.nameBox.text);
			if (temp is Number || temp is int) flags[flagId] = temp;
			else flags[flagId] = mainView.nameBox.text;
			flagEditor();
		}

	}

}
