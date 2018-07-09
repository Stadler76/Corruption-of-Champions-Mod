package classes.Items.Armors 
{
	import classes.PerkType;
	/**
	 * ...
	 * @author Stadler76
	 */
	public class ArmorWithPerkBuilder 
	{
		private var _id:String;
		private var _shortName:String;
		private var _name:String;
		private var _longName:String;
		private var _def:Number;
		private var _value:Number;
		private var _description:String;
		private var _perk:String;
		private var _playerPerk:PerkType;
		private var _playerPerkV1:Number = 0;
		private var _playerPerkV2:Number = 0;
		private var _playerPerkV3:Number = 0;
		private var _playerPerkV4:Number = 0;
		private var _playerPerk2:PerkType = null;
		private var _playerPerk2V1:Number = 0;
		private var _playerPerk2V2:Number = 0;
		private var _playerPerk2V3:Number = 0;
		private var _playerPerk2V4:Number = 0;
		private var _supportsBulge:Boolean = false;
		private var _supportsUndergarment:Boolean = true;

		private var _requirements:Array = ['id', 'shortName', 'name', 'longName', 'def', 'value', 'description', 'perk', 'playerPerk'];
		private var _requirementsMet:Array = [];

		public function id(id:String):ArmorWithPerkBuilder
		{
			_id = id;
			_requirementsMet.push("id");
			return this;
		}

		public function shortName(shortName:String):ArmorWithPerkBuilder
		{
			_shortName = shortName;
			_requirementsMet.push("shortName");
			return this;
		}

		public function name(name:String):ArmorWithPerkBuilder
		{
			_name = name;
			_requirementsMet.push("name");
			return this;
		}

		public function longName(longName:String):ArmorWithPerkBuilder
		{
			_longName = longName;
			_requirementsMet.push("longName");
			return this;
		}

		public function def(def:Number):ArmorWithPerkBuilder
		{
			_def = def;
			_requirementsMet.push("def");
			return this;
		}

		public function value(value:Number):ArmorWithPerkBuilder
		{
			_value = value;
			_requirementsMet.push("value");
			return this;
		}

		public function description(description:String):ArmorWithPerkBuilder
		{
			_description = description;
			_requirementsMet.push("description");
			return this;
		}

		public function perk(perk:String):ArmorWithPerkBuilder
		{
			_perk = perk;
			_requirementsMet.push("perk");
			return this;
		}

		public function playerPerk(playerPerk:PerkType, playerPerkV1:Number = NaN, playerPerkV2:Number = NaN, playerPerkV3:Number = NaN, playerPerkV4:Number = NaN):ArmorWithPerkBuilder
		{
			_playerPerk = playerPerk;
			if (!isNaN(playerPerkV1)) _playerPerkV1 = playerPerkV1;
			if (!isNaN(playerPerkV2)) _playerPerkV2 = playerPerkV2;
			if (!isNaN(playerPerkV3)) _playerPerkV3 = playerPerkV3;
			if (!isNaN(playerPerkV4)) _playerPerkV4 = playerPerkV4;
			_requirementsMet.push("playerPerk");
			return this;
		}

		public function playerPerkV1(playerPerkV1:Number):ArmorWithPerkBuilder
		{
			_playerPerkV1 = playerPerkV1;
			return this;
		}

		public function playerPerkV2(playerPerkV2:Number):ArmorWithPerkBuilder
		{
			_playerPerkV2 = playerPerkV2;
			return this;
		}

		public function playerPerkV3(playerPerkV3:Number):ArmorWithPerkBuilder
		{
			_playerPerkV3 = playerPerkV3;
			return this;
		}

		public function playerPerkV4(playerPerkV4:Number):ArmorWithPerkBuilder
		{
			_playerPerkV4 = playerPerkV4;
			return this;
		}

		public function playerPerk2(playerPerk2:PerkType, playerPerk2V1:Number = NaN, playerPerk2V2:Number = NaN, playerPerk2V3:Number = NaN, playerPerk2V4:Number = NaN):ArmorWithPerkBuilder
		{
			_playerPerk2 = playerPerk2;
			if (!isNaN(playerPerk2V1)) _playerPerk2V1 = playerPerk2V1;
			if (!isNaN(playerPerk2V2)) _playerPerk2V2 = playerPerk2V2;
			if (!isNaN(playerPerk2V3)) _playerPerk2V3 = playerPerk2V3;
			if (!isNaN(playerPerk2V4)) _playerPerk2V4 = playerPerk2V4;
			return this;
		}

		public function playerPerk2V1(playerPerk2V1:Number):ArmorWithPerkBuilder
		{
			_playerPerk2V1 = playerPerk2V1;
			return this;
		}

		public function playerPerk2V2(playerPerk2V2:Number):ArmorWithPerkBuilder
		{
			_playerPerk2V2 = playerPerk2V2;
			return this;
		}

		public function playerPerk2V3(playerPerk2V3:Number):ArmorWithPerkBuilder
		{
			_playerPerk2V3 = playerPerk2V3;
			return this;
		}

		public function playerPerk2V4(playerPerk2V4:Number):ArmorWithPerkBuilder
		{
			_playerPerk2V4 = playerPerk2V4;
			return this;
		}

		public function supportsBulge(supportsBulge:Boolean):ArmorWithPerkBuilder
		{
			_supportsBulge = supportsBulge;
			return this;
		}

		public function supportsUndergarment(supportsUndergarment:Boolean):ArmorWithPerkBuilder
		{
			_supportsUndergarment = supportsUndergarment;
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
				def:                  _def,
				value:                _value,
				description:          _description,
				perk:                 _perk,
				playerPerk:           _playerPerk,
				playerPerkV1:         _playerPerkV1,
				playerPerkV2:         _playerPerkV2,
				playerPerkV3:         _playerPerkV3,
				playerPerkV4:         _playerPerkV4,
				playerPerk2:          _playerPerk2,
				playerPerk2V1:        _playerPerk2V1,
				playerPerk2V2:        _playerPerk2V2,
				playerPerk2V3:        _playerPerk2V3,
				playerPerk2V4:        _playerPerk2V4,
				supportsBulge:        _supportsBulge,
				supportsUndergarment: _supportsUndergarment
			};
		}
	}
}
