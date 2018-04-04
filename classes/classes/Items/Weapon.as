/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;

	public class Weapon extends Useable //Equipable
	{
		public static const WEIGHT_LIGHT:String = "Light";
		public static const WEIGHT_MEDIUM:String = "Medium";
		public static const WEIGHT_HEAVY:String = "Heavy";
		
		public static const PERK_LARGE:String = "Large";
		public static const PERK_RANGED:String = "Ranged";
		public static const PERK_APHRODISIAC:String = "Aphrodisiac Weapon";
		
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;
		private var _weight:String = WEIGHT_MEDIUM; //Defaults to medium
		private var _tier:int = 0; //Defaults to 0.
		
		public function Weapon(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "") {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack + (_tier * 2); }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		override public function get value():Number {
			return this._value * (1 + (_tier / 2));
		}
		
		override public function get shortName():String {
			var sn:String = this._shortName;
			if (_tier > 0 && !isObsidian()) sn += "+" + _tier;
			if (isObsidian()) sn = "Ob." + sn; //For obsidian weapons, unless specified.
			return sn;
		}
		
		override public function get description():String {
			var desc:String = _description;
			switch(_tier) {
				case 1:
					desc += " This weapon has been upgraded to be of fine quality.";
					break;
				case 2:
					desc += " This weapon has been upgraded to be of masterwork quality.";
					break;
				case 3:
					if (_degradable) desc += "This weapon has been enhanced with reinforced obsidian " + (isSharp() ? "lining its blade that could deliver sharper blows" : "spikes carefully attached to deliver more painful attacks") + ".";
					else desc += " This weapon has been upgraded to be of epic quality and takes on a more fearsome look.";
					break;
				default:
					desc += "";
			}
			//Type
			desc += "\n\nType: " + _weight + " Weapon ";
			if (perk == "Large") desc += "(Large)";
			else if (name.indexOf("staff") >= 0) desc += "(Staff)";
			else if (verb.indexOf("whip") >= 0) desc += "(Whip)";
			else if (verb.indexOf("punch") >= 0) desc += "(Gauntlet)";
			else if (verb == "shot") desc += "(Ranged)";
			else if (verb == "slash" || verb == "keen cut") desc += "(Sword)";
			else if (verb == "stab") desc += "(Dagger)";
			else if (verb == "smash") desc += "(Blunt)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
			if (perk == "Large" && game.player.shield != ShieldLib.NOTHING && !(game.player.hasPerk(PerkLib.TitanGrip) && game.player.str >= 90)) {
				outputText("Because the weapon requires the use of two hands, you have unequipped your shield. ");
			}
		}
		
		override public function canUse():Boolean {
			return true;
		}
		
		public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			if (perk == "Large" && game.player.shield != ShieldLib.NOTHING && !(game.player.hasPerk(PerkLib.TitanGrip) && game.player.str >= 90)) {
				game.inventory.unequipShield();
			}
			return this;
		}
		
		public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
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
		
		//For possible condition checking
		public function isObsidian():Boolean {
			return this.longName.toLowerCase().indexOf("obsidian") >= 0;
		}
		public function isSharp():Boolean {
			return (verb == "slash" || verb == "keen cut" || verb == "stab");
		}
		
		//For obsidian and breakable weapons.
		public function setDegradation(durability:int, weaponToDegradeInto:ItemType):Weapon {
			this._degradable = true;
			this._durability = durability;
			this._breaksInto = weaponToDegradeInto;
			return this;
		}
		
	}
}
