package classes.Items.Weapons 
{
	import classes.PerkType;
	/**
	 * ...
	 * @author Stadler76
	 */
	public class WeaponWithPerkBuilder 
	{
		private var _id:String;
		private var _shortName:String;
		private var _name:String;
		private var _longName:String;
		private var _verb:String;
		private var _attack:Number;
		private var _value:Number;
		private var _description:String;
		private var _perk:String;
		private var _playerPerk:PerkType;
		private var _playerPerkV1:Number = 0;
		private var _playerPerkV2:Number = 0;
		private var _playerPerkV3:Number = 0;
		private var _playerPerkV4:Number = 0;

		private var _requirements:Array = ['id', 'shortName', 'name', 'longName', 'verb', 'attack', 'value', 'description', 'perk', 'playerPerk'];
		private var _requirementsMet:Array = [];

		public function id(id:String):WeaponWithPerkBuilder
		{
			_id = id;
			_requirementsMet.push("id");
			return this;
		}

		public function shortName(shortName:String):WeaponWithPerkBuilder
		{
			_shortName = shortName;
			_requirementsMet.push("shortName");
			return this;
		}

		public function name(name:String):WeaponWithPerkBuilder
		{
			_name = name;
			_requirementsMet.push("name");
			return this;
		}

		public function longName(longName:String):WeaponWithPerkBuilder
		{
			_longName = longName;
			_requirementsMet.push("longName");
			return this;
		}

		public function verb(verb:String):WeaponWithPerkBuilder
		{
			_verb = verb;
			_requirementsMet.push("verb");
			return this;
		}

		public function attack(attack:Number):WeaponWithPerkBuilder
		{
			_attack = attack;
			_requirementsMet.push("attack");
			return this;
		}

		public function value(value:Number):WeaponWithPerkBuilder
		{
			_value = value;
			_requirementsMet.push("value");
			return this;
		}

		public function description(description:String):WeaponWithPerkBuilder
		{
			_description = description;
			_requirementsMet.push("description");
			return this;
		}

		public function perk(perk:String):WeaponWithPerkBuilder
		{
			_perk = perk;
			_requirementsMet.push("perk");
			return this;
		}

		public function playerPerk(playerPerk:PerkType, playerPerkV1:Number = NaN, playerPerkV2:Number = NaN, playerPerkV3:Number = NaN, playerPerkV4:Number = NaN):WeaponWithPerkBuilder
		{
			_playerPerk = playerPerk;
			if (!isNaN(playerPerkV1)) _playerPerkV1 = playerPerkV1;
			if (!isNaN(playerPerkV2)) _playerPerkV2 = playerPerkV2;
			if (!isNaN(playerPerkV3)) _playerPerkV3 = playerPerkV3;
			if (!isNaN(playerPerkV4)) _playerPerkV4 = playerPerkV4;
			_requirementsMet.push("playerPerk");
			return this;
		}

		public function playerPerkV1(playerPerkV1:Number):WeaponWithPerkBuilder
		{
			_playerPerkV1 = playerPerkV1;
			return this;
		}

		public function playerPerkV2(playerPerkV2:Number):WeaponWithPerkBuilder
		{
			_playerPerkV2 = playerPerkV2;
			return this;
		}

		public function playerPerkV3(playerPerkV3:Number):WeaponWithPerkBuilder
		{
			_playerPerkV3 = playerPerkV3;
			return this;
		}

		public function playerPerkV4(playerPerkV4:Number):WeaponWithPerkBuilder
		{
			_playerPerkV4 = playerPerkV4;
			return this;
		}

		public function toObject():Object
		{
			var missingRequirements:Array = [];
			for each (var req:String in _requirements) {
				if (_requirementsMet.indexOf(req) === -1) {
					missingRequirements.push(req);
				}
			}
			if (missingRequirements.length > 0) {
				throw new Error("The following required values have not been set: " + missingRequirements.join(", ") + ".");
			}

			return {
				id:                   _id,
				shortName:            _shortName,
				name:                 _name,
				longName:             _longName,
				verb:                 _verb,
				attack:               _attack,
				value:                _value,
				description:          _description,
				perk:                 _perk,
				playerPerk:           _playerPerk,
				playerPerkV1:         _playerPerkV1,
				playerPerkV2:         _playerPerkV2,
				playerPerkV3:         _playerPerkV3,
				playerPerkV4:         _playerPerkV4
			};
		}
	}
}
