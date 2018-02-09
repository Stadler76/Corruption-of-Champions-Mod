package classes.Scenes.Places.Bazaar {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Creature;
	import classes.Player;
	import classes.Scenes.Inventory;
	import classes.StatusEffects;
	import classes.display.SpriteDb;
	import classes.internals.*;
	
// By Foxwells
// Sun, the Bizarre Bazaar's Weaponsmith/Blacksmith
// A rather bare-bones version of the actual NPC I made, but eh
// Anyways Sun's an unfriendly grump, much against what his name implies
// He's a jaguar-morph. And a big wall of muscle. Also he has a boyfriend
// Shop uses flag "MRAPIER_BOUGHT" so you can't buy multiple Midnight Rapiers
// Said flag carries through ascension. Really, the weapon is too op to allow multiples

	public class ChillySmith extends BazaarAbstractContent {

		public function ChillySmith() { }
		
		public function addShopItem(button:Number, item:ItemType, price:int, shop:int):void {
			outputText("\n" + capitalizeFirstLetter(item.longName) + " - " + price + " gems");
			addButton(button, item.shortName, transactionItemConfirmation, item, price, shop);
		}
		
		public function transactionItemConfirmation(item:ItemType, price:int, shop:int):void {
			clearOutput();
			outputText("Sun looks over as you bring the " + item.longName + " to him. You hold it out to him and ask how much it costs. He takes it out of your hand for a moment, examining it, then grunts, \"<i>" + num2Text(price) + " Gems.</i>\"");
			if (player.gems >= price) {
				outputText("\n\nDo you buy it?");
				menu();
				addButton(0, "Yes", transactionYes, item, price, shop);
				addButton(1, "No", transactionNo, shop);
			}
			else {
				outputText("\n\nYou count out your Gems and realize you can't afford it.");
				menu()
				addButton(0, "Next", transactionNo, shop);
			}
		}
		
		public function transactionYes(item:ItemType, price:int, shop:int):void {
			//Determine sub-shop
			var shopToGo:Function = null
			if (shop == 1) shopToGo = buySomeWeapons;
			else shopToGo = buySomeArmor;
			//Process
			clearOutput();
			if (player.gems >= price) {
				if (flags[kFLAGS.MRAPIER_BOUGHT] == 0 && item == weapons.MRAPIER) flags[kFLAGS.MRAPIER_BOUGHT]++;
				outputText("You fill out a couple papers while Sun takes off a security tag. He then holds out " + item.longName + " to you, saying, \"<i>Here.</i>\"");
				player.gems -= price;
				menu();
				statScreenRefresh();
				inventory.takeItem(item, shopToGo);
			}
			else {
				outputText("You count out your Gems and realize you can't afford it.");
				menu();
				addButton(0, "Next", transactionNo, shop);
			}
		}
		
		public function transactionNo(shop:int):void {
			if (shop == 1) buySomeWeapons();
			else buySomeArmor();
		}
		
		public function smithButton(setButtonOnly:Boolean = false):void { //Shop button/appearance blurb
			if (!setButtonOnly) {
				outputText("\n\nOne large wagon near the back of the bazaar is almost unnoticable despite its size. All it has on it is a sign that reads ");
				if (silly()) outputText("\"<i>Chili's</i>\"");
				else outputText("\"<i>Chilly Smith</i>\"");
				outputText("Its colors are muted and dark compared to the dazzle of everything else, as though it's trying to hide.");
			}
			else addButton(3, "C. Smith", smithShop);
		}
		
		public function smithShop():void { //Entrance, buttons
			spriteSelect(SpriteDb.s_chillySmith);
			clearOutput();
			outputText("You make your way into ");
			if (silly()) outputText("the Chili's");
			else outputText("Chilly Smith");
			outputText(" and glance around, faced with cool-colored walls and a rather calm setting. The jaguar-morph shopowner, Sun, looks over to you and flicks his tail as if that's a proper greeting. The black avian beside him, Harmony, waves and calls out a hello. The two are a rather funny pair, with Sun being a 6'4\" wall of muscle and Harmony slender as can be, barely reaching Sun's shoulder. The shop itself is minimalist and straight-forward. You walk among shelves and glance over the stock.");
			menu();
			addButton(0, "Buy", buySomeShit); // Shop section
			if (!player.hasStatusEffect(StatusEffects.KnowsBlackfire)) addButton(1, "Talk", theFuckIsYouWho); // Left over from original; still need a way for you to learn Blackfire
			addButton(4, "Leave", bazaar.enterTheBazaarAndMenu);
		}
		
		public function buySomeShit():void { //Shop buttons
			clearOutput();
			outputText("You announce you want to buy something, which calls Sun's attention. He turns his head to you, same dead look in his eyes that he usually has, and says, \"<i>All right. Bring whatever up to the front when you pick something.</i>\"");
			menu();
			addButton(0, "Weapons", buySomeWeapons);
			addButton(1, "Armor", buySomeArmor);
			addButton(4, "Back", smithShop);
		}
		
		public function buySomeWeapons():void { //Purchase weapons
			clearOutput();
			outputText("You decide to take a look at the weapons that the shop stocks.\n");
			menu();
			addShopItem(0, weapons.PTCHFRK, 200, 1); //Listen, I just really want this released.
			addShopItem(1, weapons.L_DAGR0, 150, 1);
			addShopItem(2, weapons.RIDING0, 50, 1);
			addShopItem(3, weapons.SUCWHIP, 400, 1);
			
			addShopItem(5, weapons.SCIMTR0, 500, 1);
			addShopItem(6, weapons.SPEAR_0  , 450, 1);
			addShopItem(7, weapons.U_SWORD, 800, 1);
			if (flags[kFLAGS.MRAPIER_BOUGHT] == 0 && !player.hasItem(weapons.MRAPIER, 1) && !inventory.hasItemInStorage(weapons.MRAPIER)) {
				addShopItem(8, weapons.MRAPIER, 25000, 1); //One-buy and one-own only given its power.
			}
			else {
				addButtonDisabled(8, weapons.MRAPIER.shortName, "There's none in stock.", "");
			}
			
			addButton(4, "Back", buySomeShit);
		}
		
		public function buySomeArmor():void { //Purchase armor
			clearOutput();
			outputText("You decide to take a look at the armor that the shop stocks.\n");
			menu();
			addShopItem(0, armors.DSCLARM, 1000, 2);
			addShopItem(1, armors.SSARMOR, 2000, 2);
			addShopItem(2, armors.FULLPLT, 700, 2);
			addShopItem(3, armors.SCALEML, 500, 2);
			
			if (flags[kFLAGS.GOTTEN_INQUISITOR_ARMOR] == 1) { //A way for you to get the other armor, considering you have to give the Corset to Rubi. If these need price raising, let me know :3
				if (flags[kFLAGS.GOTTEN_INQUISITOR_ROBES] == 1 && flags[kFLAGS.GOTTEN_INQUISITOR_CORSET] == 0) {
					addButton(5, armors.I_CORST.shortName, buyInquiCorset);
					outputText("\nAn inquisitor's corset - 20000 Gems");
				} else if (flags[kFLAGS.GOTTEN_INQUISITOR_CORSET] == 1 && flags[kFLAGS.GOTTEN_INQUISITOR_ROBES] == 0) {
					addButton(5, armors.I_ROBES.shortName, buyInquiRobes);
					outputText("\nAn inquisitor's robes - 20000 Gems");
				} else if (flags[kFLAGS.GOTTEN_INQUISITOR_CORSET] == 1 && flags[kFLAGS.GOTTEN_INQUISITOR_ROBES] == 1) {
					addShopItem(5, armors.EBNJACK, 6000, 2);
				}
			} else if (flags[kFLAGS.GOTTEN_INQUISITOR_ARMOR] == 0) {
				addShopItem(5, armors.EBNJACK, 6000, 2);
			}
			addShopItem(6, armors.SS_ROBE, 2500, 2);
			addShopItem(7, armors.BIMBOSK, 250, 2);
			addShopItem(8, armors.INDECST, 1000, 2);
			addButton(4, "Back", buySomeShit);
		}
		
		public function whatTheFuckDude():void { //"No" choice for any special purchases
			clearOutput();
			outputText("You shake your head. That's simply too much for you to pay. You wish him luck in selling it and turn back to the rest of the shop.");
			menu();
			addButton(0, "Next", buySomeShit);
		}
		
		public function buyInquiCorset():void { //Inquisitor's Corset purchase confirmation
			clearOutput();
			outputText("You point to the overly sexual corset and ask what it's about. Sun shrugs in reply.\n\n");
			outputText("\"<i>Found it in some weird place at the Swamp. 20,000 Gems.</i>\"\n\n");
			outputText("Do you buy the Inquisitor's Corset?");
			menu();
			addButton(0, "Yes", timeForSexy);
			addButton(1, "No", whatTheFuckDude);
		}
		
		public function timeForSexy():void {
			clearOutput();
			if (player.gems < 20000) {
				outputText("You'd love to buy the corset, but it's out of your price range right now. You wish Sun good luck in selling it and move on in the shop.");
				menu();
				addButton(0, "Next", buySomeArmor);
			}
			else {
				outputText("You tell Sun that you want to buy it. He nods and has you bring it to the counter, where he removes a security tag, takes your Gems, and hands it over.");
				player.gems -= 20000;
				flags[kFLAGS.GOTTEN_INQUISITOR_CORSET]++;
				statScreenRefresh();
				menu();
				inventory.takeItem(armors.I_CORST, buySomeArmor);
			}
		}
		
		public function buyInquiRobes():void { //Inquisitor's Robes purchase confirmation
			clearOutput();
			outputText("You point to the forboding robes and ask what it's about. Sun shrugs in reply.\n\n");
			outputText("\"<i>Found it in some weird place at the Swamp. 20,000 Gems.</i>\"\n\n");
			outputText("Do you buy the Inquisitor's Robes?");
			menu();
			addButton(0, "Yes", timeForDoubleSexy);
			addButton(1, "No", whatTheFuckDude);
		}
		
		public function timeForDoubleSexy():void {
			clearOutput();
			if (player.gems < 20000) {
				outputText("You'd love to buy the armor, but it's out of your price range right now. You wish Sun good luck in selling it and move on in the shop.");
				menu();
				addButton(0, "Next", buySomeArmor);
			} else {
				outputText("You tell Sun that you want to buy it. He nods and has you bring it to the counter, where he removes a security tag, takes your Gems, and hands it over.");
				player.gems -= 20000;
				flags[kFLAGS.GOTTEN_INQUISITOR_ROBES]++;
				statScreenRefresh();
				menu();
				inventory.takeItem(armors.I_ROBES, buySomeArmor);
			}
		}
		
		public function theFuckIsYouWho():void { //Talk stuff
			clearOutput();
			outputText("You walk up to Sun and give him a merry greeting. He glances you up and down, looking less than pleased.\n\n");
			if (rand(10) == 0) {
				outputText("With a long sigh, he grabs a book from a nearby shelf and shoves it into your arms, saying, \"<i>Here. Take this and leave me to do my damn job. This isn't a fucking playground.</i>\"\n\n");
				outputText("You frown. You'd only wanted to talk. Still, you mumble a thanks and quickly back out of the store. You read the book and blink with new knowledge when you're done-- <b>you have learned the spell Blackfire!</b>");
				player.createStatusEffect(StatusEffects.KnowsBlackfire, 0, 0, 0, 0);
			}
			else {
				if (rand(4) == 0) {
					outputText("Sun reaches into his pocket and and crams a handful of Gems against your chest, saying, \"<i>I'm gonna pay you five ");
					if (silly()) outputText("dollars");
					else outputText("Gems");
					outputText(" to fuck off.</i>\" You give a confused thanks and back away.");
					player.gems += 5;
				}
				else {
					if (rand(2) == 0) outputText("When he says nothing besides giving you a hard glare, you get the point and back away with a murmured apology.");
					else outputText("\"<i>I have a boyfriend.</i>\" He jabs a thumb in Harmony's direction. You glance at Harmony, then blink at Sun a couple times. That wasn't what you really wanted, but okay. You give him a congrats and duck out of the store.");
				}
			}
			menu();
			addButton(0, "Next", camp.returnToCampUseOneHour);
		}
		
	}
}
