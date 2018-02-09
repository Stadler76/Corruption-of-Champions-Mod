package classes.Scenes 
{
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.BaseContent;
	import classes.ItemType;
	import classes.Items.*;
	import classes.TimeAwareInterface;

	public class ItemUpgrade extends BaseContent implements TimeAwareInterface
	{
		private var shopkeeper:String = "";
		private var returnFunc:Function;
		
		public static const TELADRE_WEAPON_SHOP:String = "TelAdreWeaponShop";
		public static const TELADRE_ARMOUR_SHOP:String = "TelAdreArmourShop";
		public static const BAZAAR_SMITH_SHOP:String = "BazaarChillSmith";
		public static const ARIAN_ENHANCEMENTS:String = "ArianEnhancements";
		
		public function ItemUpgrade() {
			CoC.timeAwareClassAdd(this);
		}
		
		public function timeChange():Boolean {
			if (flags[kFLAGS.WEAPON_SHOP_UPGRADE_TIME] > 0) {
				flags[kFLAGS.WEAPON_SHOP_UPGRADE_TIME]--;
			}
			if (flags[kFLAGS.ARMOUR_SHOP_UPGRADE_TIME] > 0) {
				flags[kFLAGS.ARMOUR_SHOP_UPGRADE_TIME]--;
			}
			if (flags[kFLAGS.CHILL_SMITH_UPGRADE_TIME] > 0) {
				flags[kFLAGS.CHILL_SMITH_UPGRADE_TIME]--;
			}
			return false;
		}
		
		public function timeChangeLarge():Boolean {
			return false;
		}
		
		private function isAValidItem(item:ItemType):Boolean {
			var valid:Boolean = false;
			if (item is Weapon) {
				if (shopkeeper == TELADRE_WEAPON_SHOP || shopkeeper == BAZAAR_SMITH_SHOP) valid = true;
			}
			if (item is Armor || item is Shield) {
				if (shopkeeper == TELADRE_ARMOUR_SHOP) valid = true;
			}
			if (item is Jewelry) {
				if (shopkeeper == ARIAN_ENHANCEMENTS) valid = true;
			}
			return valid;
		}
		
		public function equipmentUpgradeMenu(chosenShop:String = "", exitFunc:Function = null):void {
			clearOutput();
			menu();
			//Set variables
			if (chosenShop != "") shopkeeper = chosenShop;
			if (exitFunc != null) returnFunc = exitFunc;
			switch(chosenShop) {
				case TELADRE_WEAPON_SHOP:
					if (flags[kFLAGS.WEAPON_SHOP_UPGRADE_TIME] > 0) {
						outputText("The weaponsmith is currently busy upgrading your weapon. Come back later.");
						doNext(returnFunc);
						return;
					}
					else if (flags[kFLAGS.WEAPON_SHOP_UPGRADE_ITEM] != 0) {
						claimWeapon();
						return;
					}
					break;
				case TELADRE_ARMOUR_SHOP:
					if (flags[kFLAGS.ARMOUR_SHOP_UPGRADE_TIME] > 0) {
						outputText("The armoursmith is currently busy upgrading your armour. Come back later.");
						doNext(returnFunc);
						return;
					}
					else if (flags[kFLAGS.ARMOUR_SHOP_UPGRADE_ITEM] != 0) {
						claimWeapon();
						return;
					}
					break;
				case BAZAAR_SMITH_SHOP:
					if (flags[kFLAGS.CHILL_SMITH_UPGRADE_TIME] > 0) {
						outputText("The grouchy weaponsmith is currently busy upgrading your weapon. Come back later.");
						doNext(returnFunc);
						return;
					}
					else if (flags[kFLAGS.CHILL_SMITH_UPGRADE_ITEM] != 0) {
						claimWeapon();
						return;
					}
					break;
				default:
					//Nothing here, move on.
			}
			//The main meat of this function
			outputText("(Placeholder) What equipment would you like to reinforce?");
			for (var i:int = 0; i < inventory.getMaxSlots(); i++) {
				if (player.itemSlot(i).itype == ItemType.NOTHING) {
					addButtonDisabled(i, "", "");
				}
				else if (player.itemSlot(i).itype is Weapon && (player.itemSlot(i).itype as Weapon).tier >= 2) {
					addButtonDisabled(i, player.itemSlot(i).itype.shortName, "This equipment is already at its maximum tier.");
				}
				else if (isAValidItem(player.itemSlot(i).itype)) {
					addButton(i, player.itemSlot(i).itype.shortName, equipmentUpgradePrompt, player.itemSlot(i).itype).hint(player.itemSlot(i).itype.description, capitalizeFirstLetter(player.itemSlot(i).itype.longName));
				}
				else {
					addButtonDisabled(i, player.itemSlot(i).itype.shortName, "This is not a valid type of equipment to upgrade.");
				}
			}
			addButton(14, "Back", returnFunc);
		}
		private function equipmentUpgradePrompt(item:ItemType):void {
			clearOutput();
			var isSpecial:Boolean = false;
			//Special upgrades that will require certain items.
			switch(item) {
				case weapons.B_SWORD:
				case weapons.U_SWORD:
				case weapons.S_BLADE:
				case weapons.JRAPIER:
				case weapons.W_STAFF:
					isSpecial = true;
					break;
				default:
			}
			if (isSpecial) {
				specialUpgradePrompt(item);
				return;
			}
			outputText("(Placeholder) This will cost you " + item.value + " gems to upgrade. Proceed?");
			if (player.gems >= item.value) {
				doYesNo(createCallBackFunction(equipmentUpgradeConfirm, item), equipmentUpgradeMenu);
			}
			else {
				outputText("\n\nUnfortunately, you don't have the required gems.");
				doNext(equipmentUpgradeMenu);
			}
			
		}
		private function specialUpgradePrompt(item:ItemType):void {
			//Beautiful Sword -> Divine Pearl Sword
			if (item == weapons.B_SWORD) {
				outputText("(Placeholder) You'll need 1x pure pearl and 2000 gems for the upgrade.");
				if (player.hasItem(consumables.P_PEARL) && player.gems >= 2000) {
					doYesNo(createCallBackFunction(equipmentUpgradeConfirm, item), equipmentUpgradeMenu);
				}
				else {
					outputText("\n\nUnfortunately, you don't have the required materials and gems.");
					doNext(equipmentUpgradeMenu);
				}
			}
			//Ugly Sword -> Scarred Blade
			if (item == weapons.U_SWORD) {
				outputText("(Placeholder) You'll need 4x regular lethicite or 1x large lethicite of any kind and 2000 gems for the upgrade.");
				if ((player.hasKeyItem("Marae's Lethicite") >= 0 || player.hasKeyItem("Stone Statue Lethicite") >= 0 || player.hasKeyItem("Sheila's Lethicite") || player.hasItem(useables.LETHITE, 4)) && player.gems >= 2000) {
					doYesNo(createCallBackFunction(equipmentUpgradeConfirm, item), equipmentUpgradeMenu);
				}
				else {
					outputText("\n\nUnfortunately, you don't have the required materials and gems.");
					doNext(equipmentUpgradeMenu);
				}
			}
			//Jeweled Rapier -> Midnight Rapier
			if (item == weapons.JRAPIER) {
				outputText("(Placeholder) You'll need 5x regular lethicite and 2000 gems for the upgrade.");
				if (player.hasItem(useables.LETHITE, 5) && player.gems >= 2000) {
					doYesNo(createCallBackFunction(equipmentUpgradeConfirm, item), equipmentUpgradeMenu);
				}
				else {
					outputText("\n\nUnfortunately, you don't have the required materials and gems.");
					doNext(equipmentUpgradeMenu);
				}
			}
			//Eggshell Shield -> Runed Eggshell Shield
			if (item == shields.DRGNSHL) {
				outputText("(Placeholder) You'll need 5x dragon eggs, 2x lethicite and 1250 gems for the upgrade.");
				if (player.hasItem(useables.LETHITE, 2) && player.hasItem(consumables.DRGNEGG, 2) && player.gems >= 1250) {
					doYesNo(createCallBackFunction(equipmentUpgradeConfirm, item), equipmentUpgradeMenu);
				}
				else {
					outputText("\n\nUnfortunately, you don't have the required materials and gems.");
					doNext(equipmentUpgradeMenu);
				}
			}
		}
		private function equipmentUpgradeConfirm(item:ItemType):void {
			clearOutput();
			//Determine which flag to set.
			var flagID:int = 0;
			switch(shopkeeper) {
				case TELADRE_WEAPON_SHOP:
					flagID = kFLAGS.WEAPON_SHOP_UPGRADE_ITEM;
					break;
				case TELADRE_ARMOUR_SHOP:
					flagID = kFLAGS.ARMOUR_SHOP_UPGRADE_ITEM;
					break;
				case BAZAAR_SMITH_SHOP:
					flagID = kFLAGS.CHILL_SMITH_UPGRADE_ITEM;
					break;
				default:
					flagID = 0;
			}
			//Sort through item upgrade process
			var itemToGet:ItemType = null;
			var gemCost:int = item.value;
			switch(item) {
				//Weapons
				case weapons.BLUNDR0:
					itemToGet = weapons.BLUNDR1;
					break;
				case weapons.BLUNDR1:
					itemToGet = weapons.BLUNDR2;
					break;
				case weapons.CLAYMR0:
					itemToGet = weapons.CLAYMR1;
					break;
				case weapons.CLAYMR1:
					itemToGet = weapons.CLAYMR2;
					break;
				case weapons.CRSBOW0:
					itemToGet = weapons.CRSBOW1;
					break;
				case weapons.CRSBOW1:
					itemToGet = weapons.CRSBOW2;
					break;
				case weapons.DAGGER0:
					itemToGet = weapons.DAGGER1;
					break;
				case weapons.DAGGER1:
					itemToGet = weapons.DAGGER2;
					break;
				case weapons.FLAIL_0:
					itemToGet = weapons.FLAIL_1;
					break;
				case weapons.FLAIL_1:
					itemToGet = weapons.FLAIL_2;
					break;
				case weapons.FLNTLK0:
					itemToGet = weapons.FLNTLK1;
					break;
				case weapons.FLNTLK1:
					itemToGet = weapons.FLNTLK2;
					break;
				case weapons.S_GAUNT:
					itemToGet = weapons.H_GAUNT;
					break;
				case weapons.RRAPIER:
					itemToGet = weapons.JRAPIER;
					break;
				case weapons.KATANA0:
					itemToGet = weapons.KATANA1;
					break;
				case weapons.KATANA1:
					itemToGet = weapons.KATANA2;
					break;
				case weapons.L__AXE0:
					itemToGet = weapons.L__AXE1;
					break;
				case weapons.L__AXE1:
					itemToGet = weapons.L__AXE2;
					break;
				case weapons.L_HAMR0:
					itemToGet = weapons.L_HAMR1;
					break;
				case weapons.L_HAMR1:
					itemToGet = weapons.L_HAMR2;
					break;
				case weapons.MACE__0:
					itemToGet = weapons.MACE__1;
					break;
				case weapons.MACE__1:
					itemToGet = weapons.MACE__2;
					break;
				case weapons.RIDING0:
					itemToGet = weapons.RIDING1;
					break;
				case weapons.RIDING1:
					itemToGet = weapons.RIDING2;
					break;
				case weapons.SCIMTR0:
					itemToGet = weapons.SCIMTR1;
					break;
				case weapons.SCIMTR1:
					itemToGet = weapons.SCIMTR2;
					break;
				case weapons.SPEAR_0:
					itemToGet = weapons.SPEAR_1;
					break;
				case weapons.SPEAR_1:
					itemToGet = weapons.SPEAR_2;
					break;
				case weapons.WARHAM0:
					itemToGet = weapons.WARHAM1;
					break;
				case weapons.WARHAM1:
					itemToGet = weapons.WARHAM2;
					break;
				case weapons.WHIP__0:
					itemToGet = weapons.WHIP__1;
					break;
				case weapons.WHIP__1:
					itemToGet = weapons.WHIP__2;
					break;
				//Unique Weapons
				case weapons.B_SWORD:
					gemCost = 2000;
					itemToGet = weapons.DPSWORD;
					break;
				case weapons.U_SWORD:
					gemCost = 2000;
					itemToGet = weapons.SCARBLD;
					break;
				case weapons.JRAPIER:
					gemCost = 2000;
					itemToGet = weapons.MRAPIER;
					break;
				case weapons.S_BLADE:
					gemCost = 2000;
					itemToGet = weapons.RSBLADE;
					break;
				//Armours
				// < NOT YET IMPLEMENTED >
				//Shields
				case shields.BUCKLR0:
					itemToGet = shields.BUCKLR1;
					break;
				case shields.BUCKLR1:
					itemToGet = shields.BUCKLR2;
					break;
				case shields.KITESH0:
					itemToGet = shields.KITESH1;
					break;
				case shields.KITESH1:
					itemToGet = shields.KITESH2;
					break;
				case shields.GRTSHL0:
					itemToGet = shields.GRTSHL1;
					break;
				case shields.GRTSHL1:
					itemToGet = shields.GRTSHL2;
					break;
				case shields.TOWRSH0:
					itemToGet = shields.TOWRSH1;
					break;
				case shields.TOWRSH1:
					itemToGet = shields.TOWRSH2;
					break;
				case shields.DRGNSHL:
					itemToGet = shields.RUNESHL;
					break;
			}
			//Check to make sure item is valid.
			if (itemToGet == null) {
				outputText("(Placeholder) Sorry, it doesn't look like this one can be upgraded.");
				doNext(returnFunc);
				return;
			}
			//Set flags
			outputText("(Placeholder) Your weapon upgrade has been commissioned. Come back later to pick it up");
			flags[flagID] = itemToGet.id;
			flags[flagID+1] = 24;
			player.gems -= gemCost;
			player.destroyItems(item, 1);
			doNext(returnFunc);
		}
		private function claimWeapon():void {
			//Determine which flag to set.
			var flagID:int = 0;
			switch(shopkeeper) {
				case TELADRE_WEAPON_SHOP:
					flagID = kFLAGS.WEAPON_SHOP_UPGRADE_ITEM;
					break;
				case TELADRE_ARMOUR_SHOP:
					flagID = kFLAGS.ARMOUR_SHOP_UPGRADE_ITEM;
					break;
				case BAZAAR_SMITH_SHOP:
					flagID = kFLAGS.CHILL_SMITH_UPGRADE_ITEM;
					break;
				default:
					flagID = 0;
			}
			inventory.takeItem(ItemType.lookupItem(flags[flagID]), equipmentUpgradeMenu);
			flags[flagID] = 0; //Clear the flag
		}
		
	}

}