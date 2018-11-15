package classes.Scenes.Places.TelAdre 
{
	import classes.*;
	import classes.display.*;
	import classes.GlobalFlags.*;
	
	public class CarpentryShop extends TelAdreAbstractContent
	{
		public var nails:Number = 0;
		public var wood:Number = 0;
		public var stone:Number = 0;
		
		public function CarpentryShop() { }
		
		//-----------------
		//-- CARPENTRY SHOP
		//-----------------
		public function enter():void {
			clearOutput();
			spriteSelect(SpriteDb.s_carpenter);
			outputText("You enter the shop marked by a sign with hammer and saw symbol painted on it. There are array of tools all hung neatly. A six feet tall zebra-morph stallion stands behind the counter. He appears to be wearing typical lumberjack outfit.\n\n");
			outputText("\"<i>Welcome to my hardware shop dear customer. Feel free to look around,</i>\" he says. \n\n");
			unlockCodexEntry("Zebra-Morphs", kFLAGS.CODEX_ENTRY_ZEBRAS, false, false);
			doNext(carpentryShopInside);
		}

		public function carpentryShopInside():void {
			clearOutput();
			outputText("\"<i>So what will it be?</i>\"\n\n");
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0) camp.cabinProgress.checkMaterials();
			menu();
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
				addButton(0, "Buy Nails", carpentryShopBuyNails);
			} else {
				addDisabledButton(0, "Buy Nails", "You don't have a toolbox. How are you going to carry nails safely?");
			}
			addButton(1, "Buy Wood", carpentryShopBuyWood);
			addButton(2, "Buy Stones", carpentryShopBuyStone);
			if (player.keyItemv1("Carpenter's Toolbox") > 0) {
				addButton(5, "Sell Nails", carpentryShopSellNails);
			} else {
				addDisabledButton(5, "Sell Nails", "You have no nails to sell.");
			}
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 0) {
				addButton(6, "Sell Wood", carpentryShopSellWood);
			} else {
				addDisabledButton(6, "Sell Wood", "You have no wood to sell.");
			}
			if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 0) {
				addButton(7, "Sell Stones", carpentryShopSellStone);
			} else {
				addDisabledButton(7, "Sell Stones", "You have no stones to sell.");
			}
			if (player.hasKeyItem("Carpenter's Toolbox") < 0) {
				addButton(10, "Toolbox", carpentryShopBuySet);
				addDisabledButton(11, "Nail box", "You need a Carpenter's Toolbox to make use of this.");
			} else {
				addDisabledButton(10, "Toolbox", "You already own a set of carpentry tools.");
				if (player.hasKeyItem("Carpenter's Nail Box") < 0) {
					addButton(11, "Nail box", carpentryShopBuyNailbox);
				} else {
					addDisabledButton(11, "Nail box", "You already own a nail box.");
				}
			}

			//addButton(12, "StoneBuildingsGuide", carpentryShopBuySet3);
			addButton(14, "Leave", telAdre.telAdreMenu);
		}
		//Buy nails
		public function carpentryShopBuyNails():void {
			clearOutput();
			outputText("You ask him if he has nails for sale. He replies \"<i>Certainly! I've got nails. Your toolbox can hold up to " + camp.cabinProgress.maxNailSupply() + " nails. I'll be selling nails at a price of two gems per nail.</i>\" \n\n");
			camp.cabinProgress.checkMaterials(1);
			menu();
			addButton(0, "Buy 10", carpentryShopBuyNailsAmount, 10);
			addButton(1, "Buy 25", carpentryShopBuyNailsAmount, 25);
			addButton(2, "Buy 50", carpentryShopBuyNailsAmount, 50);
			addButton(3, "Buy 75", carpentryShopBuyNailsAmount, 75);
			addButton(4, "Buy 100", carpentryShopBuyNailsAmount, 100);
			addButton(14, "Back", carpentryShopInside)
		}

		private function carpentryShopBuyNailsAmount(amount:int):void {
			clearOutput();
			nails = amount;
			outputText("You ask him for " + amount + " nails. He replies \"<i>That'll be " + (amount * 2) + " gems, please.</i>\" \n\nDo you buy the nails?");
			doYesNo(carpentryShopBuyNailsYes, carpentryShopBuyNails);
		}

		private function carpentryShopBuyNailsYes():void {
			clearOutput();
			if (player.gems >= (nails * 2)) {
				player.gems -= (nails * 2);
				flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] += nails;
				if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] >= 300) awardAchievement("Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME);
				player.addKeyValue("Carpenter's Toolbox", 1, nails);
				outputText("You hand over " + (nails * 2) + " gems. \"<i>Done,</i>\" he says as he hands over bundle of " + nails +" nails to you.\n\n");
				//If over the limit
				if (player.keyItemv1("Carpenter's Toolbox") > camp.cabinProgress.maxNailSupply()) {
					outputText("Unfortunately, your toolbox can't hold anymore nails. You notify him and he refunds you the gems.\n\n");
					player.gems += ((player.keyItemv1("Carpenter's Toolbox") - camp.cabinProgress.maxNailSupply()) * 2);
					player.addKeyValue("Carpenter's Toolbox", 1, -(player.keyItemv1("Carpenter's Toolbox") - camp.cabinProgress.maxNailSupply()));
				}
				camp.cabinProgress.checkMaterials(1);
			}
			else {
				outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"");
			}
			statScreenRefresh();
			doNext(carpentryShopBuyNails);
		}

		//Buy wood
		public function carpentryShopBuyWood():void {
			clearOutput();
			outputText("You ask him if he has wood for sale. He replies \"<i>Certainly! I've got extra supply of wood. I'll be selling wood at a price of 10 gems per wood plank.</i>\" \n\n");
			camp.cabinProgress.checkMaterials(2);
			menu();
			addButton(0, "Buy 10", carpentryShopBuyWoodAmount, 10);
			addButton(1, "Buy 20", carpentryShopBuyWoodAmount, 20);
			addButton(2, "Buy 30", carpentryShopBuyWoodAmount, 30);
			addButton(3, "Buy 40", carpentryShopBuyWoodAmount, 40);
			addButton(4, "Buy 50", carpentryShopBuyWoodAmount, 50);
			addButton(14, "Back", carpentryShopInside)
		}	

		private function carpentryShopBuyWoodAmount(amount:int):void {
			clearOutput();
			wood = amount;
			outputText("You ask him for " + amount + " wood planks. He replies \"<i>That'll be " + (amount * 10) + " gems, please.</i>\" \n\nDo you buy the wood?");
			doYesNo(carpentryShopBuyWoodYes, carpentryShopBuyWood);
		}

		private function carpentryShopBuyWoodYes():void {
			if (player.gems >= (wood * 10)) {
				player.gems -= (wood * 10);
				flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] += wood;
				if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += wood;
				outputText("You hand over " + (wood * 10) + " gems. \"<i>I'll have the caravan deliver the wood to your camp as soon as you leave my shop,</i>\" he says.\n\n");
				//If over the limit
				if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > camp.cabinProgress.maxWoodSupply()) {
					outputText("Unfortunately, your wood supply seem to be full. You inform him. He refunds you the gems.\n\n");
					player.gems += ((flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - camp.cabinProgress.maxWoodSupply()) * 10);
					flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - camp.cabinProgress.maxWoodSupply());
				}
				camp.cabinProgress.checkMaterials(2);
			}
			else {
				clearOutput();
				outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"");
			}
			statScreenRefresh();
			doNext(carpentryShopBuyWood);
		}

		//Buy Stones
		public function carpentryShopBuyStone():void {
			clearOutput();
			outputText("You ask him if he has stones for sale. He replies \"<i>Certainly! I've got extra supply of stones. I'll be selling stones at a price of 20 gems per stone.</i>\" \n\n");
			camp.cabinProgress.checkMaterials(3);
			menu();
			addButton(0, "Buy 10", carpentryShopBuyStoneAmount, 10);
			addButton(1, "Buy 20", carpentryShopBuyStoneAmount, 20);
			addButton(2, "Buy 30", carpentryShopBuyStoneAmount, 30);
			addButton(3, "Buy 40", carpentryShopBuyStoneAmount, 40);
			addButton(4, "Buy 50", carpentryShopBuyStoneAmount, 50);
			addButton(14, "Back", carpentryShopInside)
		}

		private function carpentryShopBuyStoneAmount(amount:int):void {
			clearOutput();
			stone = amount;
			outputText("You ask him for " + amount + " stones. He replies \"<i>That'll be " + (amount * 20) + " gems, please.</i>\" \n\nDo you buy the stones?");
			doYesNo(carpentryShopBuyStoneYes, carpentryShopBuyStone);
		}

		private function carpentryShopBuyStoneYes():void {
			if (player.gems >= (stone * 20)) {
				player.gems -= (stone * 20);
				flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] += stone;
				if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] >= 100) awardAchievement("Yabba Dabba Doo", kACHIEVEMENTS.GENERAL_YABBA_DABBA_DOO);
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stone;
				outputText("You hand over " + (stone * 20) + " gems. \"<i>I'll have the caravan deliver the stones to your camp as soon as you leave my shop,</i>\" he says.\n\n");
				//If over the limit
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > camp.cabinProgress.maxStoneSupply()) {
					outputText("Unfortunately, your stone seem to be full. You inform him. He refunds you the gems.\n\n");
					player.gems += ((flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] - camp.cabinProgress.maxStoneSupply()) * 20);
					flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] - camp.cabinProgress.maxStoneSupply());
				}
				camp.cabinProgress.checkMaterials(3);
			}
			else {
				outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"");
			}
			statScreenRefresh();
			doNext(carpentryShopBuyStone);
		}

		//Sell Nails
		public function carpentryShopSellNails():void {
			clearOutput();
			outputText("You ask him if he's willing to buy nails from you. He says, \"<i>Certainly! I'll be buying nails at a rate of one gem per nail.</i>\" \n\n");
			camp.cabinProgress.checkMaterials(1);
			menu();
			if (player.keyItemv1("Carpenter's Toolbox") >= 10) addButton(0, "Sell 10", carpentryShopSellNailsAmount, 10);
			if (player.keyItemv1("Carpenter's Toolbox") >= 25) addButton(1, "Sell 25", carpentryShopSellNailsAmount, 25);
			if (player.keyItemv1("Carpenter's Toolbox") >= 50) addButton(2, "Sell 50", carpentryShopSellNailsAmount, 50);
			if (player.keyItemv1("Carpenter's Toolbox") >= 75) addButton(3, "Sell 75", carpentryShopSellNailsAmount, 75);
			if (player.keyItemv1("Carpenter's Toolbox") >= 100) addButton(3, "Sell 100", carpentryShopSellNailsAmount, 100);
			if (player.keyItemv1("Carpenter's Toolbox") > 0) addButton(4, "Sell All", carpentryShopSellNailsAmount, player.keyItemv1("Carpenter's Toolbox"));
			addButton(14, "Back", carpentryShopInside);
		}

		private function carpentryShopSellNailsAmount(amount:int):void {
			clearOutput();
			nails = amount;
			outputText("You're willing to offer " + num2Text(amount) + " " + (player.keyItemv1("Carpenter's Toolbox") == 1 ? "piece" : "pieces") + " of nails. He replies \"<i>I'll buy that for " + amount + " gems.</i>\" \n\nDo you sell the nails?");
			doYesNo(carpentryShopSellNailsYes, carpentryShopSellNails);
		}

		private function carpentryShopSellNailsYes():void {
			clearOutput();
			if (player.keyItemv1("Carpenter's Toolbox") >= nails) {
				player.gems += nails;
				player.addKeyValue("Carpenter's Toolbox", 1, -nails);
				outputText("You take " + num2Text(nails) + " " + (player.keyItemv1("Carpenter's Toolbox") ? "piece" : "pieces") + " of nails out of your toolbox and hand them over to the carpenter. \"<i>Deal. Here are " + nails + " gems,</i>\" he says.\n\n");
				camp.cabinProgress.checkMaterials(1);
			}
			else {
				outputText("\"<i>I'm sorry, my friend. You do not have enough nails.</i>\"");
			}
			statScreenRefresh();
			doNext(carpentryShopSellNails);
		}

		//Sell wood
		public function carpentryShopSellWood():void {
			clearOutput();
			outputText("You ask him if he's willing to buy wood from you. He says, \"<i>Certainly! I'll be buying wood at a rate of five gems per piece.</i>\" \n\n");
			camp.cabinProgress.checkMaterials(2);
			menu();
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 1) addButton(0, "Sell 1", carpentryShopSellWoodAmount, 1);
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 5) addButton(1, "Sell 5", carpentryShopSellWoodAmount, 5);
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 10) addButton(2, "Sell 10", carpentryShopSellWoodAmount, 10);
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 25) addButton(3, "Sell 25", carpentryShopSellWoodAmount, 25);
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 0) addButton(4, "Sell All", carpentryShopSellWoodAmount, flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES]);
			addButton(14, "Back", carpentryShopInside);
		}	

		private function carpentryShopSellWoodAmount(amount:int):void {
			clearOutput();
			wood = amount;
			outputText("You're willing to offer " + num2Text(amount) + " " + (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] == 1 ? "piece" : "pieces") + " of wood. He replies \"<i>I'll buy that for " + (amount * 5) + " gems.</i>\" \n\nDo you sell the wood?");
			doYesNo(carpentryShopSellWoodYes, carpentryShopSellWood);
		}

		private function carpentryShopSellWoodYes():void {
			clearOutput();
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= wood) {
				player.gems += (wood * 5);
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= wood;
				outputText("You sign the permission form for " + num2Text(wood) + " " + (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] == 1 ? "piece" : "pieces") + " of wood to be unloaded from your camp. \"<i>Deal. Here are " + (wood * 5) + " gems,</i>\" he says.\n\n");
				camp.cabinProgress.checkMaterials(2);
			}
			else {
				outputText("\"<i>I'm sorry, my friend. You do not have enough wood.</i>\"");
			}
			statScreenRefresh();
			doNext(carpentryShopSellWood);
		}

		//Sell Stones
		public function carpentryShopSellStone():void {
			clearOutput();
			outputText("You ask him if he's willing to buy stones from you. He says, \"<i>Certainly! I'll be buying stones at a rate of ten gems per piece.</i>\" \n\n");
			camp.cabinProgress.checkMaterials(3);
			menu();
			if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 1) addButton(0, "Sell 1", carpentryShopSellStoneAmount, 1);
			if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 5) addButton(1, "Sell 5", carpentryShopSellStoneAmount, 5);
			if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 10) addButton(2, "Sell 10", carpentryShopSellStoneAmount, 10);
			if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 25) addButton(3, "Sell 25", carpentryShopSellStoneAmount, 25);
			if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 0) addButton(4, "Sell All", carpentryShopSellStoneAmount, flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES]);
			addButton(14, "Back", carpentryShopInside);
		}

		private function carpentryShopSellStoneAmount(amount:int):void {
			clearOutput();
			stone = amount;
			outputText("You're willing to offer " + num2Text(amount) + " " + (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] == 1 ? "piece" : "pieces") + " of stone. He replies \"<i>I'll buy that for " + (amount * 10) + " gems.</i>\" \n\nDo you sell the stones?");
			doYesNo(carpentryShopSellStoneYes, carpentryShopSellStone);
		}

		private function carpentryShopSellStoneYes():void {
			clearOutput();
			if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= stone) {
				player.gems += (stone * 10);
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= stone;
				outputText("You sign the permission form for " + num2Text(stone) + " " + (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] == 1 ? "piece" : "pieces") + " of stones to be unloaded from your camp. \"<i>Deal. Here are " + (stone * 10) + " gems,</i>\" he says.\n\n");
				camp.cabinProgress.checkMaterials(3);
			}
			else {
				outputText("\"<i>I'm sorry, my friend. You do not have enough stones.</i>\"");
			}
			statScreenRefresh();
			doNext(carpentryShopSellStone);
		}

		//Buy toolbox
		public function carpentryShopBuySet():void {
			clearOutput();
			if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
				outputText("<b>You already own a set of carpentry tools!</b>");
				doNext(carpentryShopInside);
				return;
			}
			outputText("You walk around for a while until you see a wooden toolbox. It's filled with assorted tools. One of them is a hammer. Another one is a saw. Even another is an axe. There is a measuring tape. There's even a book with hundreds of pages, all about how to use tools and it even has project instructions! There's also a compartment in the toolbox for nails.");
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 4) outputText(" Just what you need to build your cabin.\n\n");
			else outputText(" Would be handy should you want to build something to make your life more comfortable.\n\n");
			outputText("\"<i>Two hundred gems and it's all yours,</i>\" the shopkeeper says.\n\n");
			if (player.gems >= 200) {
				outputText("Do you buy it?");
				doYesNo(carpentryShopBuySetYes, carpentryShopBuySetNo);
			}
			else {
				outputText("You count out your gems and realize it's beyond your price range.");
				doNext(carpentryShopInside);
			}
		}

		public function carpentryShopBuySetYes():void {
			player.gems -= 200;
			outputText("You hand over two hundred gems to the shopkeeper. ");
			outputText("\"<i>Here you go,</i>\" he says. You feel so proud to have your own tools for building stuff! \n\n");
			outputText("<b>Gained Key Item: Carpenter's Toolbox!</b>")
			player.createKeyItem("Carpenter's Toolbox", 0, 0, 0, 0);
			statScreenRefresh();
			doNext(carpentryShopInside);
		}

		public function carpentryShopBuySetNo():void {
			clearOutput();
			outputText("\"<i>No thanks,</i>\" you tell him. \n\n");
			outputText("\"<i>Suit yourself,</i>\" he says as you put the box of tools back where it was.");
			doNext(carpentryShopInside);
		}

		public function carpentryShopBuyNailbox():void {
			if (player.hasKeyItem("Carpenter's Nail Box") >= 0) {
				outputText("<b>You already own a nail box!</b>");
				doNext(carpentryShopInside);
				return;
			}
			outputText("\n\nYou walk back to where you remember you bought the toolbox. There are nail boxes designed to hold four hundred nails. Certainly, you'll be able to hold more nails and ensure you can keep on building in one trip.");
			outputText("\"<i>Two hundred gems and it's all yours,</i>\" the shopkeeper says.\n\n");
			if (player.gems >= 200) {
				outputText("Do you buy it?");
				doYesNo(carpentryShopBuyNailboxYes, carpentryShopBuyNailboxNo);
			}
			else {
				outputText("You count out your gems and realize it's beyond your price range.");
				doNext(carpentryShopInside);
			}
		}

		public function carpentryShopBuyNailboxYes():void {
			player.gems -= 200;
			outputText("You hand over two hundred gems to the shopkeeper. ");
			outputText("\"<i>Here you go,</i>\" he says. Now you can hold more nails for your projects! \n\n");
			outputText("<b>Gained Key Item: Carpenter's Nail Box!</b>")
			player.createKeyItem("Carpenter's Nail Box", 400, 0, 0, 0);
			statScreenRefresh();
			doNext(carpentryShopInside);
		}

		public function carpentryShopBuyNailboxNo():void {
			clearOutput();
			outputText("\"<i>No thanks,</i>\" you tell him. \n\n");
			outputText("\"<i>Suit yourself,</i>\" he says as you put the nail box back where it was.");
			doNext(carpentryShopInside);
		}

		//StoneBuildingsGuide
		
	}

}