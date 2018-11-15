package classes.Items.Undergarments {
	
	import classes.Items.Undergarment;
	import classes.Items.UndergarmentLib;
	import classes.PerkType;
	import classes.PerkLib;
	import classes.Player;

	//Ebonweave makin me code new shit -w- ~Foxwells
	
	public class UndergarmentWithPerk extends Undergarment {
		private var _type:Number;
		private var _perk:String;
		private var _name:String;
		private var playerPerk:PerkType;
		private var playerPerkV1:Number;
		private var playerPerkV2:Number;
		private var playerPerkV3:Number;
		private var playerPerkV4:Number;
		
		public function UndergarmentWithPerk(id:String, shortName:String, name:String, longName:String, undergarmentType:Number, value:Number, description:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "", perk:String = "") {
			super(id, shortName, name, longName, undergarmentType, value, description, perk);
			this._type = undergarmentType;
			this._name = name;
			this._perk = perk;
			this.playerPerk = playerPerk;
			this.playerPerkV1 = playerPerkV1;
			this.playerPerkV2 = playerPerkV2;
			this.playerPerkV3 = playerPerkV3;
			this.playerPerkV4 = playerPerkV4;
		}
		
		override public function get type():Number { return _type; }
		
		override public function get perk():String { return _perk; }
		
		override public function get name():String { return _name; }
		
		override public function useText():void {
			outputText("You equip " + longName + ". ");
		}
		
		override public function playerEquip():Undergarment { //This item is being equipped by the player. Add any perks, etc.
			while (game.player.findPerk(playerPerk) >= 0) game.player.removePerk(playerPerk);
			game.player.createPerk(playerPerk, playerPerkV1, playerPerkV2, playerPerkV3, playerPerkV4);
			return super.playerEquip();
		}
		
		override public function playerRemove():Undergarment { //This item is being removed by the player. Remove any perks, etc.
			while (game.player.findPerk(playerPerk) >= 0) game.player.removePerk(playerPerk);
			return super.playerRemove();
		}
		
		override public function removeText():void {} //Produces any text seen when removing the undergarment normally
		
		override public function get description():String {
			var desc:String = super.description;
			//Perk
			desc += "\nSpecials: " + playerPerk.name;
			if (playerPerk == PerkLib.WizardsEndurance) desc += " (-" + playerPerkV1 + "% Spell Cost)";
			else if (playerPerk == PerkLib.WellspringOfLust) {
				if (game.player.lust < 50) {
					desc += " (+" + (50 - game.player.lust) + " lust)";
				}
			}
			else if (playerPerkV1 > 0) desc += " (Magnitude: " + playerPerkV1 + ")";
			return desc;
		}
		
		override public function get armorDef():int {
			switch(this.name) {
				case "runed Ebonweave jockstrap":
				case "runed Ebonweave thong":
				case "runed Ebonweave loincloth":
					return 3;
				default:
					return 0;
			}
		}
		
		override public function get sexiness():int {
			switch(this.name) {
				case "runed Ebonweave jockstrap":
				case "runed Ebonweave thong":
				case "runed Ebonweave loincloth":
					return 3;
				default:
					return 0;
			}
		}
		
		override public function canUse():Boolean {
			if (!game.player.armor.supportsUndergarment) {
				outputText("It would be awkward to put on undergarments when you're currently wearing your type of clothing. You should consider switching to different clothes. You put it back into your inventory.");
				return false;
			}
			if (type == UndergarmentLib.TYPE_LOWERWEAR) {
				if (game.player.isBiped() || game.player.isGoo()) {
					return true; //It doesn't matter what leg type you have as long as you're biped.
				}
				else if (game.player.isTaur() || game.player.isDrider()) {
					outputText("Your form makes it impossible to put on any form of lower undergarments. You put it back into your inventory.");
					return false;
				}
				else if (game.player.isNaga()) {
					if (perk != "NagaWearable") {
						outputText("It's impossible to put on this undergarment as it's designed for someone with two legs. You put it back into your inventory.");
						return false;
					}
					else return true;
				}
			}
			return true;
		}
		
	}
}
