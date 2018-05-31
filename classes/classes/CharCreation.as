package classes {
	import classes.BodyParts.*;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.*;
	import classes.Items.Armors.GooArmor;
	import classes.Scenes.Inventory;
	import classes.internals.Utils;
	import classes.lists.BreastCup;
	import classes.lists.Gender;
	import classes.lists.PerkLists;
	import classes.display.SpriteDb;
	import coc.view.MainView;
	import com.bit101.components.ComboBox;
	import flash.events.Event;

	public class CharCreation extends BaseContent {
		public static const MAX_TOLERANCE_LEVEL:int = 20;
		public static const MAX_MORALSHIFTER_LEVEL:int = 10;
		public static const MAX_DESIRES_LEVEL:int = 10;
		public static const MAX_ENDURANCE_LEVEL:int = 10;
		public static const MAX_MYSTICALITY_LEVEL:int = 10;
		public static const MAX_WISDOM_LEVEL:int = 5;
		public static const MAX_FORTUNE_LEVEL:int = -1; //no max level
		public static const MAX_VIRILITY_LEVEL:int = 15;
		public static const MAX_FERTILITY_LEVEL:int = 15;
		public static const NEW_GAME_PLUS_RESET_CLIT_LENGTH_MAX:Number = 1.5;

		private var specialCharacters:CharSpecial = new CharSpecial();
		private var customPlayerProfile:Function;
		private var boxNames:ComboBox;

		public function CharCreation() {}

		public function newGameFromScratch():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 0;
			newGameGo();
		}

		public function newGamePlus():void {
				flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] === 0)
				flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
			while (player.level > 1) {
				flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
				player.level--;
			}
			flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
			newGameGo();
		}

		public function newGameGo():void {
			funcs = [];
			args = [];
			mainView.eventTestInput.x = -10207.5;
			mainView.eventTestInput.y = -1055.1;
			getGame().mainMenu.hideMainMenu();
			hideStats();
			hideUpDown();
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.hideMenuButton( MainView.MENU_NEW_MAIN );
			mainView.hideMenuButton( MainView.MENU_DATA );
			mainView.hideMenuButton( MainView.MENU_LEVEL );
			mainView.hideMenuButton( MainView.MENU_PERKS );
			mainView.aCb.visible = false; //Hide perk boxes
			mainView.setButtonText(0, "Newgame"); // b1Text.text = "Newgame";
			var showSpecialNames:Boolean = true; // achievements[kACHIEVEMENTS.STORY_FINALBOSS] > 0;			
			clearOutput();
			outputText(images.showImage("location-ingnam"));
			outputText("You grew up in the small village of Ingnam, a remote village with rich traditions, buried deep in the wilds.  Every year for as long as you can remember, your village has chosen a champion to send to the cursed Demon Realm.  Legend has it that in years Ingnam has failed to produce a champion, chaos has reigned over the countryside.  Children disappear, crops wilt, and disease spreads like wildfire.  This year, <b>you</b> have been selected to be the champion.\n\n");
			outputText("What is your name?");
			/*CODE FROM CMACLOAD HERE
			Multiple line case. A text field GeneralTextField, positioning a movieclip AskQuestions below it
			GeneralTextField.wordWrap = true;
			GeneralTextField.autoSize = true;
			GeneralTextField.htmlText = &quot;whatevevr.......&quot;;
			AskQuestions._x = GeneralTextField._x;
			AskQuestions._y = GeneralTextField._y + 3 + GeneralTextField._height;
			again replace _x, _y, _width with x, y, width*/
			//mainView.mainText.autoSize = true;
			//mainView.mainText.autoSize = TextFieldAutoSize.LEFT;
			menu();
			addButton(0, "OK", chooseName);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			mainView.promptCharacterName();
			var preList:Array = [];
			//function _add(element:Array):void{preList.push({label: element[0], data:element});}
			//if (CoC_Settings.debugBuild) preList.push( { label: "TestChar", data: [ "TestChar", customTestChar, true, "For debug." ]} );			
			for (var t:int = 0; t < specialCharacters.customs.length; t++) preList.push( { label: specialCharacters.customs[t][0], data:specialCharacters.customs[t] } );
			if (boxNames === null) {
				boxNames = new ComboBox();
				boxNames.width = 200; 
				boxNames.scaleY = 1.1;
				boxNames.defaultLabel = "Pre-defined characters";
				boxNames.x = mainView.nameBox.x + mainView.nameBox.width + 10;
				boxNames.y = mainView.nameBox.y;
				mainView.addChild(boxNames);
			}
			boxNames.addEventListener(Event.SELECT, selectName);
			boxNames.items = preList;
			if (showSpecialNames) boxNames.visible = true;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) {
				player.slotName = "VOID";
				player.autoSave = false; //Reset autosave
			}
			//RESET DUNGEON
			kGAMECLASS.inDungeon = false;
			kGAMECLASS.dungeonLoc = 0;
			kGAMECLASS.inRoomedDungeon = false;
			kGAMECLASS.inRoomedDungeonResume = null;
			//Hold onto old data for NG+
			var oldPlayer:Player = player;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) player = new Player(); //reset all standard stats
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) {
				player.str = 15;
				player.tou = 15;
				player.spe = 15;
				player.inte = 15;
				player.sens = 15;
				player.lib = 15;
			}
			player.cor = 15;
			player.hunger = 80;
			player.obey = 10;
			player.esteem = 50;
			player.will = 80;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) getGame().saves.notes = "No Notes Available.";
			player.lust = 15;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) {
				player.XP = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP];
				player.level = 1;
				player.gems = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS];
			}
			player.restoreHP();
			player.hair.length = 5;
			player.skin.type = Skin.PLAIN;
			player.underBody.restore();
			player.neck.restore();
			player.rearBody.restore();
			player.lowerBody.type = LowerBody.HUMAN;
			player.lowerBody.legCount = 2;
			player.face.type= Face.HUMAN;
			player.eyes.count = 2;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) player.tail.type = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) player.femininity = 50;
			player.beard.length = 0;
			player.beard.style = 0;
			player.tone = 50;
			player.thickness = 50;
			player.skin.desc = "skin";
			player.skin.adj = "";
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) {
				player.balls = 0;
				player.ballSize = 0;
			}
			player.hoursSinceCum = 0;
			player.cumMultiplier = 1;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) {
				player.horns.value = 0;
				player.tallness = 60;
				player.tail.venom = 0;
				player.tail.recharge = 0;

			}
			else {
				if (!(player.tail.type === Tail.FOX || player.tail.type === Tail.SPIDER_ABDOMEN || player.tail.type === Tail.BEE_ABDOMEN || player.tail.type === Tail.SCORPION)) {
					player.tail.venom = 0;
					player.tail.recharge = 0;
				}
			}
			player.wings.type = Wings.NONE;
			if (player.eyes.type === Eyes.BASILISK) player.eyes.type = Eyes.LIZARD; //Silently change them to be lizard eyes again. Simple and stupid ;)
			//Default
			player.skin.tone = "light";
			player.arms.claws.tone = "";
			player.hair.color = "brown";
			player.hair.type = Hair.NORMAL;
			player.beard.length = 0;
			player.beard.style = 0;
			//PIERCINGS
			player.nipplesPierced = 0;
			player.nipplesPShort = "";
			player.nipplesPLong = "";
			player.lipPierced = 0;
			player.lipPShort = "";
			player.lipPLong = "";
			player.tonguePierced = 0;
			player.tonguePShort = "";
			player.tonguePLong = "";
			player.eyebrowPierced = 0;
			player.eyebrowPShort = "";
			player.eyebrowPLong = "";
			player.earsPierced = 0;
			player.earsPShort = "";
			player.earsPLong = "";
			player.nosePierced = 0;
			player.nosePShort = "";
			player.nosePLong = "";
			//Exploration
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) {
				//Inventory clear
				player.itemSlot1.unlocked = true;
				player.itemSlot1.emptySlot();
				player.itemSlot2.unlocked = true;
				player.itemSlot2.emptySlot();
				player.itemSlot3.unlocked = true;
				player.itemSlot3.emptySlot();
				player.itemSlot4.unlocked = false;
				player.itemSlot4.emptySlot();
				player.itemSlot5.unlocked = false;
				player.itemSlot5.emptySlot();
			}
			//Init none-flag plot variables (The few there still are...)
			kGAMECLASS.isabellaScene.isabellaOffspringData = []; //CLEAR!
			//Lets get this bitch started
			kGAMECLASS.inCombat = false;
			kGAMECLASS.inDungeon = false;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) {
				//NG+ Clothes reset
				if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] !== 0) {
					flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 0; //clear Raphael's training variable so it does not effect
					if (!(oldPlayer.armor is GooArmor))
						 player.setArmor(oldPlayer.armor);
					else player.setArmor(armors.C_CLOTH);
					player.setWeapon(oldPlayer.weapon); //weapon strength post-newgame
				}
				else { //clothes clear
					player.setArmor(armors.C_CLOTH);
					player.setWeapon(WeaponLib.FISTS);
				}
				//Clear old camp slots
				inventory.clearStorage();
				inventory.clearGearStorage();
				inventory.initializeGearStorage(); //initialize gearStorage

				while(player.cocks.length > 0) {
					player.removeCock(0,1); //clear cocks
				//	trace("1 cock purged.");
				}
				while(player.vaginas.length > 0) {
					player.removeVagina(0,1); //clear vaginas
				//	trace("1 vagina purged.");
				}
				player.breastRows = new Vector.<BreastRowClass>(); //clear breasts
			}
			else {
				var hadOldCock:Boolean = player.hasCock();
				var hadOldVagina:Boolean = player.hasVagina();
				//TODO rework this when doing better multi-vagina support
				var oldClitLength:Number = -1;
				if (hadOldVagina)
					oldClitLength = player.getClitLength();
				while(player.cocks.length > 0) {
					player.removeCock(0,1); //clear cocks
				//	trace("1 cock purged.");
				}
				while(player.vaginas.length > 0) {
					player.removeVagina(0,1); //clear vaginas
				//	trace("1 vagina purged.");
				}
				//Keep gender and normalize genitals
				if (hadOldCock) player.createCock(5.5, 1, CockTypesEnum.HUMAN);
				if (hadOldVagina) {
					player.createVagina(true);
					if (player.hasVagina() && oldClitLength > NEW_GAME_PLUS_RESET_CLIT_LENGTH_MAX)
						 player.setClitLength(NEW_GAME_PLUS_RESET_CLIT_LENGTH_MAX);
					else player.setClitLength(oldClitLength);
				}
				if (player.balls > 2)
					player.balls = 2;
				if (player.ballSize > 2)
					player.ballSize = 2;
				while (player.breastRows.length > 1) player.removeBreastRow(1, 1);
				if (player.nippleLength > 1)
					player.nippleLength = 1;
				while (player.biggestTitSize() > 14) player.shrinkTits(true);
				if (!(oldPlayer.armor is GooArmor)) //sorry but you can't come, Valeria!
					 player.setArmor(oldPlayer.armor);
				else player.setArmor(armors.C_CLOTH);
			}
			//Clear Statuses
			var statusTemp:Array = [];
			for (var i:int = 0; i < player.statusEffects.length; i++) if (isSpell(player.statusEffects[i].stype))
				statusTemp.push(player.statusEffects[i]);
			player.removeStatuses(false);
			if (statusTemp.length > 0)
				for (i = 0; i < statusTemp.length; i++)
					player.createStatusEffect(statusTemp[i].stype, statusTemp[i].value1, statusTemp[i].value2, statusTemp[i].value3, statusTemp[i].value4, false);
			//Clear perks
			var ascendPerkTemp:Array = [];
			for (i = 0; i < player.perks.length; i++)
				if (isAscensionPerk(player.perks[i]))
					ascendPerkTemp.push(player.perks[i]);
			player.removePerks();
			if (ascendPerkTemp.length > 0)
				for (i = 0; i < ascendPerkTemp.length; i++)
					player.createPerk(ascendPerkTemp[i].ptype, ascendPerkTemp[i].value1, ascendPerkTemp[i].value2, ascendPerkTemp[i].value3, ascendPerkTemp[i].value4);
			//Clear key items
			var keyItemTemp:Array = [];
			for (i = 0; i < player.keyItems.length; i++)
				if (isSpecialKeyItem(player.keyItems[i].keyName))
					keyItemTemp.push(player.keyItems[i]);
			player.removeKeyItems();
			if (keyItemTemp.length > 0)
				for (i = 0; i < keyItemTemp.length; i++)
					player.createKeyItem(keyItemTemp[i].keyName, keyItemTemp[i].value1, keyItemTemp[i].value2, keyItemTemp[i].value3, keyItemTemp[i].value4);
//			player.perkPoints = player.level - 1;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) {
				var newGamePlusLevel:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				var difficulty:int = flags[kFLAGS.GAME_DIFFICULTY];
				var gameMode:Number = flags[kFLAGS.HUNGER_ENABLED];
				var hardcoreMode:int = flags[kFLAGS.HARDCORE_MODE];
				var hardcoreSlot:String = flags[kFLAGS.HARDCORE_SLOT];
				var mrapierBought:int = flags[kFLAGS.MRAPIER_BOUGHT];
			}
			//Clear plot storage array!
			flags = new DefaultDict();
			kGAMECLASS.saves.loadPermObject();
			//Carry over data if new game plus
			if (newGamePlusLevel > 0) {
				flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = newGamePlusLevel;
				flags[kFLAGS.GAME_DIFFICULTY] = difficulty;
				flags[kFLAGS.HUNGER_ENABLED] = gameMode;
				flags[kFLAGS.HARDCORE_MODE] = hardcoreMode;
				flags[kFLAGS.HARDCORE_SLOT] = hardcoreSlot;
				flags[kFLAGS.MRAPIER_BOUGHT] = mrapierBought;
				if (player.findPerk(PerkLib.Misdirection) > 0) flags[kFLAGS.RAPHAEL_INTELLIGENCE_TRAINING];
				if (player.findPerk(PerkLib.RapierTraining) > 0) flags[kFLAGS.RAPHAEL_RAPIER_TRANING] === 4;
			}
			//Time reset
			getGame().time.days = 0;
			getGame().time.hours = 0;
			getGame().time.minutes = 0;
		}

		private function chooseName():void {
			if (mainView.nameBox.text === "") {
				//If part of newgame+, don't fully wipe. Isn't this redundant? This is covered in `newGameGo`
				if (player.XP > 0) {
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
					if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] === 0)
						flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
					while (player.level > 1) {
						flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
						player.level--;
					}
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
				}
				if (flags[kFLAGS.LETHICE_DEFEATED] > 0) renamePrompt();
				else newGameGo();
				outputText("\n\n\n<b>You must select a name.</b>");
				return;
			}
			clearOutput();
			if (boxNames !== null) boxNames.visible = false;
			mainView.nameBox.visible = false;
			player.short = mainView.nameBox.text;
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) { //dirty checking as the NG+ flag is incremented after reincarnating
				clearOutput();
				outputText("You shall be known as " + player.short + " now.");
				ascensionMenu();
				return;
			}
			customPlayerProfile = customName(mainView.nameBox.text);
			menu();
			if (customPlayerProfile !== null) {
				outputText(images.showImage("event-question"));
				outputText("This name, like you, is special.  Do you live up to your name or continue on, assuming it to be coincidence?");
				addButton(0, "SpecialName", useCustomProfile);
				addButton(1, "Continue On", noCustomProfile);
			}
			else genericGenderChoice(); //proceed with normal character creation
		}

		private function genericGenderChoice():void {
			outputText(images.showImage("event-question"));
			outputText("Are you a man or a woman?");
			menu();
			addButton(0, "Man", isAMan);
			addButton(1, "Woman", isAWoman);
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] > 0) {
				outputText("\n\nOr a hermaphrodite as you've unlocked hermaphrodite option!");
				addButton(2, "Herm", isAHerm);
			}
		}

		private function useCustomProfile():void {
			clearOutput();
			if (specialName(player.short) !== null) {
				outputText("Your name defines everything about you, and as such, it is time to wake...\n\n");
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				completeCharacterCreation(); //skip character creation, customPlayerProfile will be called in completeCharacterCreation
			}
			else {
				outputText("There is something different about you, but first, what is your basic gender?  An individual such as you may later overcome this, of course...\n\n");
				genericGenderChoice(); //after character creation the fact that customPlayerProfile is not null will activate a custom player setup
			}
		}

		private function noCustomProfile():void {
			clearOutput();
			outputText(images.showImage("event-question"));
			customPlayerProfile = null;
			outputText("Your name carries little significance beyond it being your name.  What is your gender?");
			menu();
			addButton(0, "Man", isAMan);
			addButton(1, "Woman", isAWoman);
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] > 0)
				addButton(2, "Herm", isAHerm);
		}

		private function selectName(event:Event):void {
			if (ComboBox(event.target).selectedItem.data[0].length > 16) return; //not a name
			clearOutput();
			outputText("<b>" + ComboBox(event.target).selectedItem.data[0] + ":</b> " + ComboBox(event.target).selectedItem.data[3]);
			if (ComboBox(event.target).selectedItem.data[2]) outputText("\n\nThis character have pre-defined history.");
			else outputText("\n\nThis character have no pre-defined history.");
			output.flush();
			mainView.nameBox.text = ComboBox(event.target).selectedItem.data[0];
		}
		//Determines if has character creation bonuses
		internal function customName(arg:String):Function {
			for (var i:int = 0; i < specialCharacters.customs.length; i++)
				if (specialCharacters.customs[i][0] === arg && !specialCharacters.customs[i][2])
					return specialCharacters.customs[i][1];
			return specialName(arg); //must check against the special name list as well
		}
		//Does PC skip creation?
		private function specialName(arg:String):Function {
			for (var i:int = 0; i < specialCharacters.customs.length; i++)
				if (specialCharacters.customs[i][0] === arg && specialCharacters.customs[i][2])
					return specialCharacters.customs[i][1];
			return null;
		}

		private function isAMan():void {
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) { //attributes
				player.str += 3;
				player.tou += 2;
			}
			//Body attributes
			player.fertility = 5;
			player.hair.length = 1;
			player.tallness = 71;
			player.tone = 60;
			//Genetalia
			player.balls = 2;
			player.ballSize = 1;
			player.createCock();
			player.cocks[0].cockLength = 5.5;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.cocks[0].knotMultiplier = 1;
			player.createBreastRow(); //breasts
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("You are a man.  Your upbringing has provided you an advantage in strength and toughness.\n\nWhat type of build do you have?");
			menu(); //choices
			addButton(0, "Lean", buildLeanMale);
			addButton(1, "Average", buildAverageMale);
			addButton(2, "Thick", buildThickMale);
			addButton(3, "Girly", buildGirlyMale);
		}

		internal function isAWoman():void {
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) { //attributes
				player.spe += 3;
				player.inte += 2;
			}
			//Body attributes
			player.fertility = 10;
			player.hair.length = 10;
			player.tallness = 67;
			player.tone = 30;
			//Genetalia
			player.balls = 0;
			player.ballSize = 0;
			player.createVagina();
			player.createBreastRow(); //breasts
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("You are a woman.  Your upbringing has provided you an advantage in speed and intellect.\n\nWhat type of build do you have?");
			menu(); //choices
			addButton(0, "Slender", buildSlenderFemale);
			addButton(1, "Average", buildAverageFemale);
			addButton(2, "Curvy", buildCurvyFemale);
			addButton(3, "Tomboyish", buildTomboyishFemale);
		}

		internal function isAHerm():void {
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) { //attributes
				player.str+=1;
				player.tou+=1;
				player.spe+=1;
				player.inte+= 1;
			}
			//Body attributes
			player.fertility = 10;
			player.hair.length = 10;
			player.tallness = 69;
			player.tone = 45;
			//Genetalia
			player.balls = 2;
			player.ballSize = 1;
			player.createVagina();
			player.createCock();
			player.cocks[0].cockLength = 5.5;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.cocks[0].knotMultiplier = 1;
			player.createBreastRow(); //breasts
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("You are a hermaphrodite.  Your upbringing has provided you an average in stats.\n\nWhat type of build do you have?");
			menu(); //choices
			addButton(0, "Fem. Slender", buildSlenderFemale).hint("Feminine build.\n\nWill make you a futanari.", "Feminine, Slender");
			addButton(1, "Fem. Average", buildAverageFemale).hint("Feminine build.\n\nWill make you a futanari.", "Feminine, Average");
			addButton(2, "Fem. Curvy", buildCurvyFemale).hint("Feminine build.\n\nWill make you a futanari.", "Feminine, Curvy");
			addButton(3, "Fem. Tomboy", buildTomboyishFemale).hint("Androgynous build.\n\nA bit feminine, but fit and slender.", "Feminine, Tomboyish");
//			addButton(4, "Androgynous", chooseBodyTypeAndrogynous).hint("Confusing build.\n\nWill make you as average as possible.", "Androgynous");
			addButton(5, "Mas. Lean", buildLeanMale).hint("Masculine build.\n\nWill make you a maleherm.", "Masculine, Lean");
			addButton(6, "Mas. Average", buildAverageMale).hint("Masculine build.\n\nWill make you a maleherm.", "Masculine, Average");
			addButton(7, "Mas. Thick", buildThickMale).hint("Masculine build.\n\nWill make you a maleherm.", "Masculine, Thick");
			addButton(8, "Mas. Girly", buildGirlyMale).hint("Androgynous build.\n\nA bit masculine, but soft and slender.", "Masculine, Girly");
		}

		private function buildLeanMale():void {
			player.str -= 1;
			player.spe += 1;
			player.femininity = 34;
			player.thickness = 30;
			player.tone += 5;
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.rating = Butt.RATING_TIGHT;
			player.hips.rating = Hips.RATING_SLENDER;
			chooseComplexion();
		}
		private function buildSlenderFemale():void {
			player.str -= 1;
			player.spe += 1;
			player.femininity = 66;
			player.thickness = 30;
			player.tone += 5;
			player.breastRows[0].breastRating = BreastCup.B;
			player.butt.rating = Butt.RATING_TIGHT;
			player.hips.rating = Hips.RATING_AMPLE;
			chooseComplexion();
		}
		private function buildAverageMale():void {
			player.femininity = 30;
			player.thickness = 50;
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.rating = Butt.RATING_AVERAGE;
			player.hips.rating = Hips.RATING_AVERAGE;
			chooseComplexion();
		}
		private function buildAverageFemale():void {
			player.femininity = 70;
			player.thickness = 50;
			player.breastRows[0].breastRating = BreastCup.C;
			player.butt.rating = Butt.RATING_NOTICEABLE;
			player.hips.rating = Hips.RATING_AMPLE;
			chooseComplexion();
		}
		private function buildThickMale():void {
			player.spe -= 4;
			player.str += 2;
			player.tou += 2;
			player.femininity = 29;
			player.thickness = 70;
			player.tone -= 5;
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.rating = Butt.RATING_NOTICEABLE;
			player.hips.rating = Hips.RATING_AVERAGE;
			chooseComplexion();
		}
		private function buildCurvyFemale():void {
			player.spe -= 2;
			player.str += 1;
			player.tou += 1;
			player.femininity = 71;
			player.thickness = 70;
			player.breastRows[0].breastRating = BreastCup.D;
			player.butt.rating = Butt.RATING_LARGE;
			player.hips.rating = Hips.RATING_CURVY;
			chooseComplexion();
		}
		private function buildGirlyMale():void {
			player.str -= 2;
			player.spe += 2;
			player.femininity = player.hasVagina() ? 49 : 50;
			player.thickness = 50;
			player.tone = 26;
			player.breastRows[0].breastRating = BreastCup.A;
			player.butt.rating = Butt.RATING_NOTICEABLE;
			player.hips.rating = Hips.RATING_SLENDER;
			chooseComplexion();
		}
		private function buildTomboyishFemale():void {
			player.str += 1;
			player.spe -= 1;
			player.femininity = player.hasCock() ? 55 : 56;
			player.thickness = 50;
			player.tone = 50;
			player.breastRows[0].breastRating = BreastCup.A;
			player.butt.rating = Butt.RATING_TIGHT;
			player.hips.rating = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function chooseComplexion():void {
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("What is your complexion?");
			menu();
			addButton(0, "Light", setComplexion, "light");
			addButton(1, "Fair", setComplexion, "fair");
			addButton(2, "Olive", setComplexion, "olive");
			addButton(3, "Dark", setComplexion, "dark");
			addButton(4, "Ebony", setComplexion, "ebony");
			addButton(5, "Mahogany", setComplexion, "mahogany");
			addButton(6, "Russet", setComplexion, "russet");
		}
		private function setComplexion(choice:String):void {
			player.skin.tone = choice;
			player.arms.claws.tone = "";
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("You selected a " + choice + " complexion.\n\nWhat color is your hair?");
			menu(); //and choose hair
			addButton(0, "Blonde", setHair, "blonde");
			addButton(1, "Brown", setHair, "brown");
			addButton(2, "Black", setHair, "black");
			addButton(3, "Red", setHair, "red");
			addButton(4, "Gray", setHair, "gray");
			addButton(5, "White", setHair, "white");
			addButton(6, "Auburn", setHair, "auburn");
		}
		private function setHair(choice:String):void {
			player.hair.color = choice;
			clearOutput();
			outputText("You have " + player.hairDescript() + ".\n\nYou will proceed to customization.");
		//	chooseEndowment(false);
			genericStyleCustomizeMenu();
		}
		//----------------- GENERAL STYLE -----------------
		private function genericStyleCustomizeMenu():void {
			clearOutput();
			mainView.nameBox.visible = false;
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			outputText(images.showImage("event-creation"));
			outputText("You can finalize your appearance customization before you proceed to perk selection. You will be able to alter your appearance through the usage of certain items.\n\n");
			outputText("Height: " + Math.floor(player.tallness / 12) + "'" + player.tallness % 12 + "\"\n");
			outputText("Skin tone: " + player.skin.tone + "\n");
			outputText("Hair color: " + player.hair.color + "\n");
			if (player.hasCock()) outputText("Cock size: " + player.cocks[0].cockLength + "\" long, " + player.cocks[0].cockThickness + "\" thick\n");
			outputText("Breast size: " + player.breastCup(0) + "\n");
			menu();
			addButton(0, "Complexion", menuSkinComplexion);
			addButton(1, "Hair Color", menuHairColor);
			if (player.mf("m", "f") === "m") {
				if (player.hasBeard()) outputText("Beard: " + player.beardDescript() + "\n");
				addButton(2, "Beard Style", menuBeardSettings);
			}
			addButton(3, "Set Height", setHeight);
			if (player.hasCock())addButton(5, "Cock Size", menuCockLength);
			addButton(6, "Breast Size", menuBreastSize);
			addButton(9, "Done", chooseEndowment);
		}
		//----------------- SKIN COLOURS -----------------
		private function menuSkinComplexion():void {
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("What is your complexion?");
			menu();
			addButton(0, "Light", confirmComplexion, "light");
			addButton(1, "Fair", confirmComplexion, "fair");
			addButton(2, "Olive", confirmComplexion, "olive");
			addButton(3, "Dark", confirmComplexion, "dark");
			addButton(4, "Ebony", confirmComplexion, "ebony");
			addButton(5, "Mahogany", confirmComplexion, "mahogany");
			addButton(6, "Russet", confirmComplexion, "russet");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}	
		private function confirmComplexion(complexion:String):void {
			player.skin.tone = complexion;
			genericStyleCustomizeMenu();
		}
		//----------------- HAIR COLOURS -----------------
		private function menuHairColor():void {
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("What is your hair color?");
			menu();
			addButton(0, "Blonde", chooseHairColor, "blonde");
			addButton(1, "Brown", chooseHairColor, "brown");
			addButton(2, "Black", chooseHairColor, "black");
			addButton(3, "Red", chooseHairColor, "red");
			addButton(4, "Gray", chooseHairColor, "gray");
			addButton(5, "White", chooseHairColor, "white");
			addButton(6, "Auburn", chooseHairColor, "auburn");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function chooseHairColor(color:String = ""):void {
			player.hair.color = color;
			genericStyleCustomizeMenu();
		}
		//----------------- BEARD STYLE -----------------
		private function menuBeardSettings():void {
			clearOutput();
			outputText("You can choose your beard length and style.\n\n");
			outputText("Beard: " + player.beardDescript());
			menu();
			addButton(0, "Style", menuBeardStyle);
			addButton(1, "Length", menuBeardLength);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function menuBeardStyle():void {
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("What beard style would you like?");
			menu();
			addButton(0, "Normal", chooseBeardStyle, 0);
			addButton(1, "Goatee", chooseBeardStyle, 1);
			addButton(2, "Clean-cut", chooseBeardStyle, 2);
			addButton(3, "Mountainman", chooseBeardStyle, 3);
			addButton(14, "Back", menuBeardSettings);
		}
		private function chooseBeardStyle(choiceStyle:int = 0):void {
			player.beard.style = choiceStyle;
			menuBeardSettings();
		}
		private function menuBeardLength():void {
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("How long would you like your beard be? \n\nNote: Beard will slowly grow over time, just like in the real world. Unless you have no beard. You can change your beard style later in the game.");
			menu();
			addButton(0, "No Beard", chooseBeardLength, 0);
			addButton(1, "Trim", chooseBeardLength, 0.1);
			addButton(2, "Short", chooseBeardLength, 0.2);
			addButton(3, "Medium", chooseBeardLength, 0.5);
			addButton(4, "Mod. Long", chooseBeardLength, 1.5);
			addButton(5, "Long", chooseBeardLength, 3);
			addButton(6, "Very Long", chooseBeardLength, 6);
			addButton(14, "Back", chooseBeardLength);
		}
		private function chooseBeardLength(choiceLength:Number = 0):void {
			player.beard.length = choiceLength;
			menuBeardSettings();
		}
		//----------------- HEIGHT -----------------
		private function setHeight():void {
			clearOutput();
			outputText("Set your height in inches.");
			outputText("\nYou can choose any height between 4 feet (48 inches) and 8 feet (96 inches).");
			mainView.nameBox.visible = true;
			mainView.nameBox.maxChars = 2;
			mainView.nameBox.restrict = "0-9";
			if (player.gender === 0) mainView.nameBox.text = "69";
			if (player.gender === 1) mainView.nameBox.text = "71";
			if (player.gender === 2) mainView.nameBox.text = "67";
			if (player.gender === 3) mainView.nameBox.text = "69";
			menu();
			addButton(0, "OK", confirmHeight);
			addButton(4, "Back", genericStyleCustomizeMenu);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		}
		private function confirmHeight():void {
			mainView.nameBox.visible = false;
			if (int(mainView.nameBox.text) < 48) {
				clearOutput();
				outputText("That is below your minimum height choices!");
				doNext(setHeight); //off to the height selection!
				return;
			}
			if (int(mainView.nameBox.text) > 96) {
				clearOutput();
				outputText("That is above your maximum height choices!");
				doNext(setHeight); //off to the height selection!
				return;
			}
			if (mainView.nameBox.text === "") {
				clearOutput();
				outputText("Please input your height. Off you go to the height selection!");
				doNext(setHeight); //off to the height selection!
				return;
			}
			player.tallness = int(mainView.nameBox.text);
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			clearOutput();
			outputText("You'll be " + Math.floor(player.tallness / 12) + " feet and " + player.tallness % 12 + " inches tall. Is this okay with you?");
			doYesNo(genericStyleCustomizeMenu, setHeight);
		}
		//----------------- COCK LENGTH -----------------
		private function menuCockLength():void {
			clearOutput();
			outputText("You can choose a cock length between 4 and 8 inches. Your starting cock length will also affect starting cock thickness.\n\nCock type and size can be altered later in the game through certain items.");
			menu();
			addButton(0, "4\"", chooseCockLength, 4);
			addButton(1, "4.5\"", chooseCockLength, 4.5);
			addButton(2, "5\"", chooseCockLength, 5);
			addButton(3, "5.5\"", chooseCockLength, 5.5);
			addButton(4, "6\"", chooseCockLength, 6);
			addButton(5, "6.5\"", chooseCockLength, 6.5);
			addButton(6, "7\"", chooseCockLength, 7);
			addButton(7, "7.5\"", chooseCockLength, 7.5);
			addButton(8, "8\"", chooseCockLength, 8);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function chooseCockLength(length:Number):void {
			player.cocks[0].cockLength = length;
			player.cocks[0].cockThickness = Utils.floor(((length / 5) - 0.1),1);
			genericStyleCustomizeMenu();
		}
		//----------------- BREAST SIZE -----------------
		private function menuBreastSize():void {
			clearOutput();
			outputText("You can choose a breast size. Breast size may be altered later in the game.");
			menu();
			if (player.femininity < 50) addButton(0, "Flat", chooseBreastSize, 0);
			if (player.femininity < 60) addButton(1, "A-cup", chooseBreastSize, 1);
			if (player.femininity >= 40) addButton(2, "B-cup", chooseBreastSize, 2);
			if (player.femininity >= 50) addButton(3, "C-cup", chooseBreastSize, 3);
			if (player.femininity >= 60) addButton(4, "D-cup", chooseBreastSize, 4);
			if (player.femininity >= 70) addButton(5, "DD-cup", chooseBreastSize, 5);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function chooseBreastSize(size:int):void {
			player.breastRows[0].breastRating = size;
			genericStyleCustomizeMenu();
		}
		//----------------- STARTER PERKS -----------------
		private function chooseEndowment():void {
			clearOutput();
			outputText(images.showImage("event-question"));
			outputText("Every person is born with a gift.  What's yours?");
			menu();
			var totalStartingPerks:int = 0;
			var button:int = 0;
			//Attribute Perks
			var endowmentPerks:Array = PerkLists.ENDOWMENT_ATTRIBUTE;
			//Endowment Perks
			if (player.hasCock()) {
				endowmentPerks = endowmentPerks.concat(PerkLists.ENDOWMENT_COCK);
			}
			if (player.hasVagina()) {
				endowmentPerks = endowmentPerks.concat(PerkLists.ENDOWMENT_VAGINA);
			}
			//Add buttons
			for each (var p:Object in endowmentPerks) {
				if (!player.hasPerk(p.perk)) {
					addButton(button++, p.text, confirmEndowment, p.perk);
				} else {
					addButtonDisabled(button++, p.text, "You already have this starting perk.");
					totalStartingPerks++;
				}
			}
			if (totalStartingPerks >= 4) //option to skip if you have enough starting perks
				addButton(14, "Skip", chooseHistory);
		}

		private function confirmEndowment(choice:PerkType):void {
			clearOutput();
			outputText(images.showImage("event-question"));
			switch(choice) {
				//Attributes
				case PerkLib.Strong: outputText("Are you stronger than normal? (+5 Strength)\n\nStrength increases your combat damage, and your ability to hold on to an enemy or pull yourself away."); break;
				case PerkLib.Tough: outputText("Are you unusually tough? (+5 Toughness)\n\nToughness gives you more HP and increases the chances an attack against you will fail to wound you."); break;
				case PerkLib.Fast: outputText("Are you very quick?  (+5 Speed)\n\nSpeed makes it easier to escape combat and grapples.  It also boosts your chances of evading an enemy attack and successfully catching up to enemies who try to run."); break;
				case PerkLib.Smart: outputText("Are you a quick learner?  (+5 Intellect)\n\nIntellect can help you avoid dangerous monsters or work with machinery.  It will also boost the power of any spells you may learn in your travels."); break;
				case PerkLib.Lusty: outputText("Do you have an unusually high sex-drive?  (+5 Libido)\n\nLibido affects how quickly your lust builds over time.  You may find a high libido to be more trouble than it's worth..."); break;
				case PerkLib.Sensitive: outputText("Is your skin unusually sensitive?  (+5 Sensitivity)\n\nSensitivity affects how easily touches and certain magics will raise your lust.  Very low sensitivity will make it difficult to orgasm."); break;
				case PerkLib.Pervert: outputText("Are you unusually perverted?  (+5 Corruption)\n\Corruption affects certain scenes and having a higher corruption makes you more prone to Bad Ends.\n"); break;
				//Gender-specific
				case PerkLib.BigCock: outputText("Do you have a big cock?  (+2\" Cock Length)\n\nA bigger cock will make it easier to get off any sexual partners, but only if they can take your size."); break;
				case PerkLib.MessyOrgasms: outputText("Are your orgasms particularly messy?  (+50% Cum Multiplier)\n\nA higher cum multiplier will cause your orgasms to be messier."); break;
				case PerkLib.BigTits: outputText("Are your breasts bigger than average? (+1 Cup Size)\n\nLarger breasts will allow you to lactate greater amounts, tit-fuck larger cocks, and generally be a sexy bitch."); break;
				case PerkLib.BigClit: outputText("Do you have a big clit?  (1\" Long)\n\nA large enough clit may eventually become as large as a cock.  It also makes you gain lust much faster during oral or manual stimulation."); break;
				case PerkLib.Fertile: outputText("Is your family particularly fertile?  (+15% Fertility)\n\nA high fertility will cause you to become pregnant much more easily.  Pregnancy may result in: Strange children, larger bust, larger hips, a bigger ass, and other weirdness."); break;
				case PerkLib.WetPussy: outputText("Does your pussy get particularly wet?  (+1 Vaginal Wetness)\n\nVaginal wetness will make it easier to take larger cocks, in turn helping you bring the well-endowed to orgasm quicker."); break;
				default: outputText("Something broke!");
			}
			menu();
			addButton(0, "Yes", setEndowment, choice);
			addButton(1, "No", chooseEndowment);
		}

		protected function setEndowment(choice:PerkType):void {
			switch(choice) {
				//Attribute-specific
				case PerkLib.Strong:
					player.str += 5;
					player.tone += 7;
					player.thickness += 3;
					player.createPerk(PerkLib.Strong, 0.25, 0, 0, 0);
					break;
				case PerkLib.Tough:
					player.tou += 5;
					player.tone += 5;
					player.thickness += 5;
					player.createPerk(PerkLib.Tough, 0.25, 0, 0, 0);
					player.restoreHP();
					break;
				case PerkLib.Fast:
					player.spe += 5;
					player.tone += 10;
					player.createPerk(PerkLib.Fast, 0.25, 0, 0, 0);
					break;
				case PerkLib.Smart:
					player.inte += 5;
					player.thickness -= 5;
					player.createPerk(PerkLib.Smart, 0.25, 0, 0, 0);
					break;
				case PerkLib.Lusty:
					player.lib += 5;
					player.createPerk(PerkLib.Lusty, 0.25, 0, 0, 0);
					break;
				case PerkLib.Sensitive:
					player.sens += 5;
					player.createPerk(PerkLib.Sensitive, 0.25, 0, 0, 0);
					break;
				case PerkLib.Pervert:
					player.cor += 5;
					player.createPerk(PerkLib.Pervert, 0.25, 0, 0, 0);
					break;
				//Genital-specific
				case PerkLib.BigCock:
					player.femininity -= 5;
					player.cocks[0].cockLength = 8;
					player.cocks[0].cockThickness = 1.5;
					player.createPerk(PerkLib.BigCock, 1.25, 0, 0, 0);
					break;
				case PerkLib.MessyOrgasms:
					player.femininity -= 2;
					player.cumMultiplier = 1.5;
					player.createPerk(PerkLib.MessyOrgasms, 1.25, 0, 0, 0);
					break;
				case PerkLib.BigTits:
					player.femininity += 5;
					player.breastRows[0].breastRating += 2;
					player.createPerk(PerkLib.BigTits, 1.5, 0, 0, 0);
					break;
				case PerkLib.BigClit:
					player.femininity -= 5;
					player.setClitLength(1);
					player.createPerk(PerkLib.BigClit, 1.25, 0, 0, 0);
					break;
				case PerkLib.Fertile:
					player.femininity += 5;
					player.fertility += 25;
					player.hips.rating += 2;
					player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
					break;
				case PerkLib.WetPussy:
					player.femininity += 7;
					player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_WET;
					player.createPerk(PerkLib.WetPussy, 2, 0, 0, 0);
					break;
				default: //move along, nothing happens in this defaultness
			}
			chooseHistory();
		}
		//----------------- HISTORY PERKS -----------------
		public function chooseHistory():void {
			clearOutput();
			outputText(images.showImage("event-question"));
			if (flags[kFLAGS.HISTORY_PERK_SELECTED] !== 0) //this flag can only be non-zero if chooseHistory is called from camp.as
				outputText("<b>New history perks are available during creation.  Since this character was created before they were available, you may choose one now!</b>\n\n");
			outputText("Before you became a champion, you had other plans for your life.  What were you doing before?");
			menu();
			var totalHistoryPerks:int = 0;
			var button:int = 0;
			//Attribute Perks
			for each (var p:Object in PerkLists.HISTORY) {
				if (!player.hasPerk(p.perk))
					addButton(button++, p.text, confirmHistory, p.perk);
				else {
					addButtonDisabled(button++, p.text, "You already have this history perk.");
					totalHistoryPerks++;
				}
			}
			if (totalHistoryPerks >= 3) addButton(14, "Skip", completeCharacterCreation);
		}

		private function confirmHistory(choice:PerkType):void {
			clearOutput();
			outputText(images.showImage("event-question"));
			switch (choice) {
				case PerkLib.HistoryAlchemist: outputText("You spent some time as an alchemist's assistant, and alchemical items always seem to be more reactive in your hands.  Is this your history?"); break;
				case PerkLib.HistoryFighter: outputText("You spent much of your time fighting other children, and you had plans to find work as a guard when you grew up.  You do 10% more damage with physical attacks.  You will also start out with 50 gems.  Is this your history?"); break;
				case PerkLib.HistoryFortune: outputText("You always feel lucky when it comes to fortune.  Because of that, you have always managed to save up gems until whatever's needed and how to make the most out it (+15% gems on victory).  You will also start out with 250 gems.  Is this your history?"); break;
				case PerkLib.HistoryHealer: outputText("You often spent your free time with the village healer, learning how to tend to wounds.  Healing items and effects are 20% more effective.  Is this your history?"); break;
				case PerkLib.HistoryReligious: outputText("You spent a lot of time at the village temple, and learned how to meditate.  The 'masturbation' option is replaced with 'meditate' when corruption is at or below 66.  Is this your history?"); break;
				case PerkLib.HistoryScholar: outputText("You spent much of your time in school, and even begged the richest man in town, Mr. " + (silly() ? "Savin" : "Sellet") + ", to let you read some of his books.  You are much better at focusing, and spellcasting uses 20% less fatigue.  Is this your history?"); break;
				case PerkLib.HistorySlacker: outputText("You spent a lot of time slacking, avoiding work, and otherwise making a nuisance of yourself.  Your efforts at slacking have made you quite adept at resting, and your fatigue comes back 20% faster.  Is this your history?"); break;
				case PerkLib.HistorySlut: outputText("You managed to spend most of your time having sex.  Quite simply, when it came to sex, you were the village bicycle - everyone got a ride.  Because of this, your body is a bit more resistant to penetrative stretching, and has a higher upper limit on what exactly can be inserted.  Is this your history?"); break;
				case PerkLib.HistorySmith: outputText("You managed to get an apprenticeship with the local blacksmith.  Because of your time spent at the blacksmith's side, you've learned how to fit armor for maximum protection.  Is this your history?"); break;
				default: outputText("You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).  Is this your history?");
			}
			menu();
			addButton(0, "Yes", setHistory, choice);
			addButton(1, "No", chooseHistory);
		}

		private function setHistory(choice:PerkType):void {
			player.createPerk(choice, 0, 0, 0, 0);
			if (choice === PerkLib.HistorySlut || choice === PerkLib.HistoryWhore) {
				if (player.hasVagina()) {
					player.vaginas[0].virgin = false;
					player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_LOOSE;
				}
				player.ass.analLooseness = 1;
			}
			if (choice === PerkLib.HistoryFighter || choice === PerkLib.HistoryWhore) player.gems += 50;
			if (choice === PerkLib.HistoryFortune) player.gems += 250;
			if (flags[kFLAGS.HISTORY_PERK_SELECTED] === 0) {
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				completeCharacterCreation();
			}
			else {
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1; //Special escape clause for very old saves that do not have a history perk. This is used to allow them the chance to select a perk at camp on load
				playerMenu();
			}
		}

		private function completeCharacterCreation():void {
			clearOutput();
			if (customPlayerProfile !== null) {
				customPlayerProfile();
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) doNext(chooseGameModes);
				else doNext(startTheGame);
				return;
			}
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) chooseGameModes();
			else startTheGame();
		}

		public function arrival():void {
			showStats();
			statScreenRefresh();
			getGame().time.hours = 11;
			clearOutput();
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) {
				outputText("You are prepared for what is to come. Most of the last year has been spent honing your body and mind to prepare for the challenges ahead. You are the Champion of Ingnam. The one who will journey to the demon realm and guarantee the safety of your friends and family, even though you'll never see them again. You wipe away a tear as you enter the courtyard and see Elder... Wait a minute...\n\n");
				outputText("Something is not right. Elder Nomur is already dead. Ingnam has been mysteriously pulled into the demon realm and the surroundings look much worse than you've expected. A ruined portal frame stands in the courtyard, obviously no longer functional and instead serves as a grim reminder on the now-ceased tradition of annual sacrifice of Champions. Wooden palisades surround the town of Ingnam and outside the walls, spears are set out and angled as a mean to make the defenses more intimidating. As if that wasn't enough, some of the spears have demonic skulls impaled on them.");
				flags[kFLAGS.IN_INGNAM] = 1;
				doNext(playerMenu);
				return;
			}
			outputText("You are prepared for what is to come.  Most of the last year has been spent honing your body and mind to prepare for the challenges ahead.  You are the Champion of Ingnam.  The one who will journey to the demon realm and guarantee the safety of your friends and family, even though you'll never see them again.  You wipe away a tear as you enter the courtyard and see Elder Nomur waiting for you.  You are ready.\n\n");
			outputText("The walk to the tainted cave is long and silent.  Elder Nomur does not speak.  There is nothing left to say.  The two of you journey in companionable silence.  Slowly the black rock of Mount Ilgast looms closer and closer, and the temperature of the air drops.  You shiver and glance at the Elder, noticing he doesn't betray any sign of the cold.  Despite his age of nearly 80, he maintains the vigor of a man half his age.  You're glad for his strength, as assisting him across this distance would be draining, and you must save your energy for the trials ahead.\n");
			outputText(images.showImage("camp-arrival"));
			outputText("The entrance of the cave gapes open, sharp stalactites hanging over the entrance, giving it the appearance of a monstrous mouth.  Elder Nomur stops and nods to you, gesturing for you to proceed alone.\n\n");
			outputText("The cave is unusually warm and damp, ");
			if (player.gender === Gender.FEMALE) outputText("and your body seems to feel the same way, flushing as you feel a warmth and dampness between your thighs. ");
			else outputText("and your body reacts with a sense of growing warmth focusing in your groin, your manhood hardening for no apparent reason. ");
			outputText("You were warned of this and press forward, ignoring your body's growing needs.  A glowing purple-pink portal swirls and flares with demonic light along the back wall.  Cringing, you press forward, keenly aware that your body seems to be anticipating coming in contact with the tainted magical construct.  Closing your eyes, you gather your resolve and leap forwards.  Vertigo overwhelms you and you black out...");
			dynStats("lus", 15);
			doNext(arrivalPartTwo);
		}
		private function arrivalPartTwo():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", 40, "cor", 2);
			getGame().time.hours = 18;
			outputText(images.showImage("encounter-zetaz"));
			spriteSelect(SpriteDb.s_zetaz_imp);
			outputText("You wake with a splitting headache and a body full of burning desire.  A shadow darkens your view momentarily and your training kicks in.  You roll to the side across the bare ground and leap to your feet.  A surprised looking imp stands a few feet away, holding an empty vial.  He's completely naked, an improbably sized pulsing red cock hanging between his spindly legs.  You flush with desire as a wave of lust washes over you, your mind reeling as you fight ");
			if (player.gender === Gender.FEMALE) outputText("the urge to chase down his rod and impale yourself on it.\n\n");
			else outputText("the urge to ram your cock down his throat.  The strangeness of the thought surprises you.\n\n");
			outputText("The imp says, \"<i>I'm amazed you aren't already chasing down my cock, human.  The last Champion was an eager whore for me by the time she woke up.  This lust draft made sure of it.</i>\"");
			doNext(arrivalPartThree);
		}
		private function arrivalPartThree():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", -30);
			outputText(images.showImage("item-draft-lust"));
			outputText("The imp shakes the empty vial to emphasize his point.  You reel in shock at this revelation - you've just entered the demon realm and you've already been drugged!  You tremble with the aching need in your groin, but resist, righteous anger lending you strength.\n\nIn desperation you leap towards the imp, watching with glee as his cocky smile changes to an expression of sheer terror.  The smaller creature is no match for your brute strength as you pummel him mercilessly.  You pick up the diminutive demon and punt him into the air, frowning grimly as he spreads his wings and begins speeding into the distance.\n\n");
			doNext(arrivalPartFour);
		}
		private function arrivalPartFour():void {
			clearOutput();
			hideUpDown();
			outputText(images.showImage("zetaz-runaway"));
			outputText("The imp says, \"<i>FOOL!  You could have had pleasure unending... but should we ever cross paths again you will regret humiliating me!  Remember the name Zetaz, as you'll soon face the wrath of my master!</i>\"\n\n");
			outputText("Your pleasure at defeating the demon ebbs as you consider how you've already been defiled.  You swear to yourself you will find the demon responsible for doing this to you and the other Champions, and destroy him AND his pet imp.");
			doNext(arrivalPartFive);
		}
		private function arrivalPartFive():void {
			clearOutput();
			hideUpDown();
			outputText(images.showImage("camp-portal"));
			spriteSelect(null);
			outputText("You look around, surveying the hellish landscape as you plot your next move.  The portal is a few yards away, nestled between a formation of rocks.  It does not seem to exude the arousing influence it had on the other side.  The ground and sky are both tinted different shades of red, though the earth beneath your feet feels as normal as any other lifeless patch of dirt.   You settle on the idea of making a camp here and fortifying this side of the portal.  No demons will ravage your beloved hometown on your watch.\n\nIt does not take long to set up your tent and a few simple traps.  You'll need to explore and gather more supplies to fortify it any further.  Perhaps you will even manage to track down the demons who have been abducting the other champions!");
			awardAchievement("Newcomer", kACHIEVEMENTS.STORY_NEWCOMER, true, true);
			doNext(playerMenu);
		}
		//----------------- GAME MODES -----------------
		private function chooseModeDifficulty():void {
			if (flags[kFLAGS.GAME_DIFFICULTY] < 3) flags[kFLAGS.GAME_DIFFICULTY]++;
			else flags[kFLAGS.GAME_DIFFICULTY] = 0;
			chooseGameModes();
		}
		private function chooseModeSurvival():void {
			if (flags[kFLAGS.HUNGER_ENABLED] < 1) {
				flags[kFLAGS.HUNGER_ENABLED] += 0.5;
				player.hunger = 80;
			}
			else {
				flags[kFLAGS.HUNGER_ENABLED] = 0;
				player.hunger = 0;
			}
			chooseGameModes();
		}
		private function chooseModeHardcore():void {
			if (flags[kFLAGS.HARDCORE_MODE] === 0) flags[kFLAGS.HARDCORE_MODE] = 1;
			else flags[kFLAGS.HARDCORE_MODE] = 0;
			chooseGameModes();
		}
		private function chooseModeHardcoreSlot():void {
			clearOutput();
			outputText("You have chosen Hardcore Mode. In this mode, the game forces autosave and if you encounter a Bad End, your save file is <b>DELETED</b>! \n\nDebug Mode and Easy Mode are disabled in this game mode. \n\nPlease choose a slot to save in. You may not make multiple copies of saves.");
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), function(slot:int):* {
					flags[kFLAGS.HARDCORE_SLOT] = "CoC_" + slot;
					startTheGame();
				}, i + 1);
			}
			addButton(14, "Back", chooseGameModes);
		}
		//GRIMDARK!
		private function chooseModeGrimdark():void {
			clearOutput();
			outputText("You have chosen Grimdark Mode. This will drastically alter gameplay and there will be a lot of new obstacles. Enemies are beefed up and the game will be much darker and edgier with plenty of environment changes. Is this what you choose?");
			flags[kFLAGS.GRIMDARK_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 3;
			if (flags[kFLAGS.GRIMDARK_BACKGROUND_UNLOCKED] === 0) flags[kFLAGS.BACKGROUND_STYLE] = 9;
			player.hunger = 80;
			doNext(startTheGame);
		}
		//Choose the game mode when called!
		private function chooseGameModes():void {
			clearOutput();
			outputText(images.showImage("event-creation"));
			outputText("Choose a game mode.\n\n");
			outputText("<b>Survival:</b> ");
			if (flags[kFLAGS.HUNGER_ENABLED] === 0) outputText("Normal Mode. You don't have to eat.\n");
			if (flags[kFLAGS.HUNGER_ENABLED] === 0.5) outputText("Survival Mode. You get hungry from time to time.\n");
			if (flags[kFLAGS.HUNGER_ENABLED] === 1) outputText("Realistic Mode. You get hungry from time to time and cum production is capped. In addition, it's a bad idea to have oversized parts.\n");
			outputText("<b>Hardcore:</b> ");
			if (flags[kFLAGS.HARDCORE_MODE] === 0) outputText("Normal Mode. You choose when you want to save and load.\n");
			if (flags[kFLAGS.HARDCORE_MODE] === 1) outputText("Hardcore Mode. The game forces save and if you get a Bad End, your save file is deleted. Disables difficulty selection, debug mode, Low Standarts and Hyper Happy mode once the game is started. For the veteran CoC players only.\n");
			outputText("<b>Difficulty:</b> ");
			if (flags[kFLAGS.GAME_DIFFICULTY] === 0) outputText("Normal Mode. No stats changes. Game is nice and simple.\n");
			if (flags[kFLAGS.GAME_DIFFICULTY] === 1) outputText("Hard Mode. Enemies have would have extra 25% HP and 15% damage.\n");
			if (flags[kFLAGS.GAME_DIFFICULTY] === 2) outputText("Nightmare Mode. Enemies would have extra 50% HP and 30% damage.\n");
			if (flags[kFLAGS.GAME_DIFFICULTY] === 3) outputText("Extreme Mode. Enemies would have extra 100% HP and 50% damage.\n");
			if (debug) outputText("<b>Grimdark mode:</b> (In dev) In the grimdark future, there are only rape and corruptions. Lots of things are changed and Lethice has sent out her minions to wall the borders and put up a lot of puzzles. Can you defeat her in this mode in as few bad ends as possible?\n");
			menu();
			addButton(0, "Survival", chooseModeSurvival);
			addButton(1, "Hardcore", chooseModeHardcore);
			addButton(2, "Difficulty", chooseModeDifficulty);
			if (debug) addButton(3, "Grimdark", chooseModeGrimdark);
			addButton(4, "Start!", flags[kFLAGS.HARDCORE_MODE] === 1 ? chooseModeHardcoreSlot : startTheGame);
		}

		private function startTheGame():void {
			player.startingRace = player.race;
			if (flags[kFLAGS.HARDCORE_MODE] > 0) getGame().saves.saveGame(flags[kFLAGS.HARDCORE_SLOT])
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) flags[kFLAGS.BACKGROUND_STYLE] = 9;
			kGAMECLASS.saves.loadPermObject();
			flags[kFLAGS.MOD_SAVE_VERSION] = kGAMECLASS.modSaveVersion;
			statScreenRefresh();
			chooseToPlay();
			return;
		}
		public function chooseToPlay():void {
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] === 0) {
				if (player.femininity >= 55) player.setUndergarment(undergarments.C_PANTY);
				else player.setUndergarment(undergarments.C_LOIN);
				if (player.biggestTitSize() >= 2) player.setUndergarment(undergarments.C_BRA);
			}
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) {
				arrival();
				return;
			}
			clearOutput();
			outputText(images.showImage("location-ingnam"));
			outputText("Would you like to play through the 3-day prologue in Ingnam or just skip?");
			doYesNo(goToIngnam, arrival);
		}
		public function goToIngnam():void {
			getGame().time.days = -3;
			getGame().time.hours = 8;
			flags[kFLAGS.IN_INGNAM] = 1;
			kGAMECLASS.ingnam.menuIngnam();
		}
		//------------ ASCENSION ------------
		public function ascensionMenu():void {
			hideStats();
			clearOutput();
			hideMenus();
			mainView.nameBox.visible = false;
			if (player.hasVagina()) outputText(images.showImage("camp-ascension-female"));
			else outputText(images.showImage("camp-ascension-male"));
			kGAMECLASS.displayHeader("Ascension");
			outputText("The world you have departed is irrelevant and you are in an endless black void dotted with tens of thousands of stars. You encompass everything and everything encompasses you.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			outputText("\n\n(When you're done, select Reincarnate.)");
			menu();
			addButton(0, "Perk Select",   ascensionPerkMenu).hint("Spend Ascension Perk Points on special perks!", "Perk Selection");
			addButton(1, "Perm Perks", ascensionPermeryMenu).hint("Spend Ascension Perk Points to make certain perks permanent.", "Perk Selection");
			addButton(2, "Respec", 		   respecLevelPerks).hint("Respec all level-up perks for 5 Ascension Perk Points?");
			addButton(3, "Rename", 			   renamePrompt).hint("Change your name at no charge?");
			addButton(4, "Reincarnate",   reincarnatePrompt).hint("Reincarnate and start an entirely new adventure?");
		}
		//Perk Selection
		private function ascensionPerkMenu():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			addButton(0, "Desires", ascensionPerkSelection, PerkLib.AscensionDesires, MAX_DESIRES_LEVEL, null, PerkLib.AscensionDesires.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionDesires) + " / " + MAX_DESIRES_LEVEL);
			addButton(1, "Endurance", ascensionPerkSelection, PerkLib.AscensionEndurance, MAX_ENDURANCE_LEVEL, null, PerkLib.AscensionEndurance.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionEndurance) + " / " + MAX_ENDURANCE_LEVEL);
			addButton(2, "Fertility", ascensionPerkSelection, PerkLib.AscensionFertility, MAX_FERTILITY_LEVEL, null, PerkLib.AscensionFertility.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFertility) + " / " + MAX_FERTILITY_LEVEL);
			addButton(3, "Fortune", ascensionPerkSelection, PerkLib.AscensionFortune, MAX_FORTUNE_LEVEL, null, PerkLib.AscensionFortune.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFortune) + " (No maximum level)");
			addButton(4, "Moral Shifter", ascensionPerkSelection, PerkLib.AscensionMoralShifter, MAX_MORALSHIFTER_LEVEL, null, PerkLib.AscensionMoralShifter.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMoralShifter) + " / " + MAX_MORALSHIFTER_LEVEL);
			addButton(5, "Mysticality", ascensionPerkSelection, PerkLib.AscensionMysticality, MAX_MYSTICALITY_LEVEL, null, PerkLib.AscensionMysticality.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMysticality) + " / " + MAX_MYSTICALITY_LEVEL);
			addButton(6, "Tolerance", ascensionPerkSelection, PerkLib.AscensionTolerance, MAX_TOLERANCE_LEVEL, null, PerkLib.AscensionTolerance.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTolerance) + " / " + MAX_TOLERANCE_LEVEL);
			addButton(7, "Virility", ascensionPerkSelection, PerkLib.AscensionVirility, MAX_VIRILITY_LEVEL, null, PerkLib.AscensionVirility.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionVirility) + " / " + MAX_VIRILITY_LEVEL);
			addButton(8, "Wisdom", ascensionPerkSelection, PerkLib.AscensionWisdom, MAX_WISDOM_LEVEL, null, PerkLib.AscensionWisdom.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionWisdom) + " / " + MAX_WISDOM_LEVEL);
			addButton(14, "Back", ascensionMenu);
		}
		private function ascensionPerkSelection(perk:* = null, maxLevel:int = 10):void {
			clearOutput();
			outputText("Perk Effect: " + perk.longDesc);
			outputText("\nCurrent level: " + player.perkv1(perk) + (maxLevel > 0 ? " / " + maxLevel : " (No maximum level)") + "");
			if (player.perkv1(perk) >= maxLevel && maxLevel > 0) outputText(" <b>(Maximum)</b>");
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			if (player.perkv1(perk) < maxLevel || maxLevel < 0) outputText("\nCost for next level: " + cost);
			else outputText("\nCost for next level: <b>N/A</b>");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (player.ascensionPerkPoints >= cost && (player.perkv1(perk) < maxLevel || maxLevel < 0)) addButton(0, "Add 1 level", addAscensionPerk, perk, maxLevel);
			addButton(4, "Back", ascensionPerkMenu);
		}
		private function addAscensionPerk(perk:* = null, maxLevel:int = 10):void {
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			player.ascensionPerkPoints -= cost;
			if (player.findPerk(perk) >= 0) player.addPerkValue(perk, 1, 1);
			else player.createPerk(perk, 1, 0, 0, 0);
			ascensionPerkSelection(perk, maxLevel);
		}
		//Perk Permery
		private function ascensionPermeryMenu(page:int = 1):void {
			clearOutput();
			outputText("For the price of a few points, you can make certain perks permanent and they will carry over in future ascensions. In addition, if the perks come from transformations, they will stay even if you no longer meet the requirements.");
			outputText("\n\nCurrent Cost: " + permanentizeCost() + " Ascension Points");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			var button:int = 0;
			var countBeforeAdding:int = (page - 1) * 12;
			menu();
			for (var i:int = 0; i < player.perks.length; i++) {
				if (isPermable(player.perks[i].ptype) && button < 14) {
					if (countBeforeAdding > 0)
						countBeforeAdding--; //decrement count before adding buttons
					else { //add buttons when the count reaches zero
						if (player.perks[i].value4 === 0)
							 addButton(button++, player.perks[i].ptype.id, permanentizePerk, player.perks[i].ptype, null, null, player.perks[i].ptype.desc(player.perks[i]));
						else addButtonDisabled(button++, player.perks[i].ptype.id, "This perk is already made permanent and will carry over in all subsequent ascensions.");
					}
				}
				//Skip slots reserved for next and previous
				if (button === 4) button++;
				if (button === 9) button++;
			}
			//Next and previous page buttons depending on conditions
			if (button >= 14) addButton(4, "Next", ascensionPermeryMenu, page + 1);
			if (page > 1) addButton(9, "Previous", ascensionPermeryMenu, page - 1);
			addButton(14, "Back", ascensionMenu);
		}
		private function permanentizePerk(perk:PerkType):void {
			if (player.ascensionPerkPoints < permanentizeCost()) return; //Not enough points? Cancel
			if (player.perkv4(perk) > 0) return; //Perk already permed? Cancel
			player.ascensionPerkPoints -= permanentizeCost(); //deduct points
			player.addPerkValue(perk, 4, 1); //permanentize a perk
			ascensionPermeryMenu();
		}
		private function permanentizeCost():int {
			var count:int = 1;
			for each (var perk:PerkType in PerkLists.PERMEABLE)
				if (player.perkv4(perk) > 0) count++;
			return count;
		}
		private function isPermable(perk:PerkType):Boolean { return PerkLists.PERMEABLE.indexOf(perk) !== -1; }
		//Respec
		private function respecLevelPerks():void {
			clearOutput();
			if (player.ascensionPerkPoints < 5) {
				outputText("You need at least 5 Ascension Perk Points to respec level-up perks. You have " + player.ascensionPerkPoints + ".");
				doNext(ascensionMenu);
				return;
			}
			if (player.perkPoints === player.level - 1) {
				outputText("There is no need to respec as you've already resetted your level-up perks.");
				doNext(ascensionMenu);
				return;
			}
			player.ascensionPerkPoints -= 5;
			player.perkPoints = player.level - 1;
			var ascendPerkTemp:Array = [];
			for (var i:int = 0; i < player.perks.length; i++)
				if (isAscensionPerk(player.perks[i], true)) ascendPerkTemp.push(player.perks[i]);
			player.removePerks();
			if (ascendPerkTemp.length > 0)
				for (i = 0; i < ascendPerkTemp.length; i++)
					player.createPerk(ascendPerkTemp[i].ptype, ascendPerkTemp[i].value1, ascendPerkTemp[i].value2, ascendPerkTemp[i].value3, ascendPerkTemp[i].value4);
			outputText("Your level-up perks are now reset and you are refunded the perk points.");
			doNext(ascensionMenu);
		}
		//Rename
		private function renamePrompt():void {
			clearOutput();
			outputText("You may choose to change your name.");
			mainView.promptCharacterName();
			mainView.nameBox.text = player.short;
			menu();
			addButton(0, "OK", chooseName);
			addButton(4, "Back", ascensionMenu);
			//Workaround
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		}
		private function reincarnatePrompt():void {
			clearOutput();
			outputText("Would you like to reincarnate and start a new life as a Champion?");
			doYesNo(reincarnate, ascensionMenu);
		}
		protected function reincarnate():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL]++;
			customPlayerProfile = null;
			newGameGo();
			clearOutput();
			mainView.nameBox.visible = false;
			boxNames.visible = false;
			outputText("Everything fades to white and finally... black. You can feel yourself being whisked back to reality as you slowly awaken in your room. You survey your surroundings and recognize almost immediately; you are in your room inside the inn in Ingnam! You get up and look around. ");
			if (player.hasKeyItem("Camp - Chest") >= 0 || player.hasKeyItem("Equipment Rack - Weapons") >= 0 || player.hasKeyItem("Equipment Rack - Armor") >= 0 || player.hasKeyItem(Inventory.STORAGE_JEWELRY_BOX) >= 0) {
				if (player.hasKeyItem("Camp - Chest") >= 0) {
					outputText("\n\nYou take a glance at the chest; you don't remember having it inside your room. You open the chest and look inside. ");
					if (inventory.hasItemsInStorage()) outputText("Something clicks in your mind; they must be the old stuff you had from your previous incarnation");
					else outputText("It's empty and you let out a disappointed sigh.");
				}
				if (player.hasKeyItem("Equipment Rack - Weapons") >= 0) {
					outputText("\n\nThere is a weapon rack. You look at it. ");
					if (inventory.weaponRackDescription()) outputText(" Something clicks in your mind; they must be the old weapons you had from your previous incarnation!");
					else outputText("It's empty and you let out a sigh but you know you can bring it to Mareth.");
				}
				if (player.hasKeyItem("Equipment Rack - Armor") >= 0) {
					outputText("\n\nThere is an armor rack. You look at it. ");
					if (inventory.armorRackDescription()) outputText(" Something clicks in your mind; they must be the old armors you had from your previous incarnation!");
					else outputText("It's empty and you let out a sigh but you know you can bring it to Mareth.");
				}
				if (player.hasKeyItem("Equipment Rack - Shields") >= 0) {
					outputText("\n\nThere is a shield rack. You look at it. ");
					if (inventory.shieldRackDescription()) outputText(" Something clicks in your mind; they must be the old shields you had from your previous incarnation!");
					else outputText("It's empty and you let out a sigh but you know you can bring it to Mareth.");
				}
				if (player.hasKeyItem(Inventory.STORAGE_JEWELRY_BOX) >= 0) {
					outputText("\n\nThere is a jewelry box on the dresser. You walk over to the box, open it, and look inside. ");
					if (inventory.jewelryBoxDescription()) outputText(" It's making sense! The contents must be from your past adventures.");
					else outputText("It's empty and you let out a sigh but you know you can bring it to Mareth.");	
				}
			}
			outputText("\n\nAfter looking around the room for a while, you look into the mirror and begin to recollect who you are...");
			player.breastRows = new Vector.<BreastRowClass>();
			player.cocks = new Vector.<Cock>();
			player.vaginas = new Vector.<VaginaClass>();
			doNext(routeToGenderChoiceReincarnation);
		}
		private function routeToGenderChoiceReincarnation():void {
			clearOutput();
			genericGenderChoice();
		}
		private function isAscensionPerk(perk:PerkClass, respec:Boolean = false):Boolean { return perk.ptype.keepOnAscension(respec) || perk.value4 > 0; }
		private function isSpecialKeyItem(keyName:* = null):Boolean { return (keyName === "Camp - Chest" || keyName === "Camp - Murky Chest" || keyName === "Camp - Ornate Chest" || keyName === "Equipment Rack - Weapons" || keyName === "Equipment Rack - Armor" || keyName === "Equipment Rack - Shields" || keyName === Inventory.STORAGE_JEWELRY_BOX || keyName === "Backpack" || keyName === "Nieve's Tear"); }
		private function isSpell(statusEffect:* = null):Boolean { return (statusEffect === StatusEffects.KnowsCharge || statusEffect === StatusEffects.KnowsBlind || statusEffect === StatusEffects.KnowsWhitefire || statusEffect === StatusEffects.KnowsArouse || statusEffect === StatusEffects.KnowsHeal || statusEffect === StatusEffects.KnowsMight || statusEffect === StatusEffects.KnowsBlackfire); }
	}
}