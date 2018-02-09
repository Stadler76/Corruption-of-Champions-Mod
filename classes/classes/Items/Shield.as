/**
 * Created by Kitteh6660 on 01.29.15.
 */
package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;
	import classes.GlobalFlags.kFLAGS
	
public class Shield extends Useable //Equipable
	{
		public static const WEIGHT_LIGHT:String = "Light";
		public static const WEIGHT_MEDIUM:String = "Medium";
		public static const WEIGHT_HEAVY:String = "Heavy";
		
		public static const PERK_ABSORPTION:String = "Absorption";
		
		private var _block:Number;
		private var _perk:String;
		private var _name:String;
		private var _weight:String = WEIGHT_MEDIUM; //Defaults to medium
		private var _tier:int = 0;
		
		public function Shield(id:String, shortName:String, name:String, longName:String, block:Number, value:Number = 0, description:String = null, perk:String = "") {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._block = block;
			this._perk = perk;
		}
		
		public function get block():Number { return _block + (_tier * 2); }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		override public function get description():String {
			var desc:String = _description;
			switch(_tier) {
				case 1:
					desc += " This shield has been upgraded to be of fine quality.";
					break;
				case 2:
					desc += " This shield has been upgraded to be of masterwork quality.";
					break;
				default:
					desc += "";
			}
			//Type
			desc += "\n\nType: Shield";
			//Block Rating
			desc += "\nBlock: " + String(block);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		override public function canUse():Boolean {
			if (game.player.weaponPerk == "Large") {
				outputText("Your current weapon requires two hands. Unequip your current weapon or switch to one-handed before equipping this shield. ");
				return false;
			}
			return true;
		}
		
		public function playerEquip():Shield { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function playerRemove():Shield { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
		
		override public function getMaxStackSize():int {
			return 1;
		}
		
		public function set tier(num:int):void {
			this._tier = num;
		}
		public function get tier():int {
			return this._tier;
		}
		
		public function set weightCategory(newWeight:String):void {
			this._weight = newWeight;
		}
		public function get weightCategory():String {
			return this._weight;
		}
	}
}