package classes.Items.Armors 
{
	import classes.PerkType;
	/**
	 * ...
	 * @author Stadler76
	 */
	public class ArmorWithPerkParamBuilder 
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
		private var _playerPerkV1:Number;
		private var _playerPerkV2:Number;
		private var _playerPerkV3:Number;
		private var _playerPerkV4:Number;
		private var _playerPerkDesc:String = "";
		private var _playerPerk2:PerkType = null;
		private var _playerPerk2V1:Number = 0;
		private var _playerPerk2V2:Number = 0;
		private var _playerPerk2V3:Number = 0;
		private var _playerPerk2V4:Number = 0;
		private var _playerPerk2Desc:String = "";
		private var _supportsBulge:Boolean = false;
		private var _supportsUndergarment:Boolean = true;

		public function id(id:String):ArmorWithPerkParamBuilder
		{
			_id = id;
			return this;
		}

		public function shortName(shortName:String):ArmorWithPerkParamBuilder
		{
			_shortName = shortName;
			return this;
		}

		public function name(name:String):ArmorWithPerkParamBuilder
		{
			_name = name;
			return this;
		}

		public function longName(longName:String):ArmorWithPerkParamBuilder
		{
			_longName = longName;
			return this;
		}

		public function def(def:Number):ArmorWithPerkParamBuilder
		{
			_def = def;
			return this;
		}

		public function value(value:Number):ArmorWithPerkParamBuilder
		{
			_value = value;
			return this;
		}

		public function description(description:String):ArmorWithPerkParamBuilder
		{
			_description = description;
			return this;
		}

		public function perk(perk:String):ArmorWithPerkParamBuilder
		{
			_perk = perk;
			return this;
		}

		public function playerPerk(playerPerk:PerkType, playerPerkV1:Number = NaN, playerPerkV2:Number = NaN, playerPerkV3:Number = NaN, playerPerkV4:Number = NaN, playerPerkDesc:String = null):ArmorWithPerkParamBuilder
		{
			_playerPerk = playerPerk;
			if (!isNaN(playerPerkV1)) _playerPerkV1 = playerPerkV1;
			if (!isNaN(playerPerkV2)) _playerPerkV2 = playerPerkV2;
			if (!isNaN(playerPerkV3)) _playerPerkV3 = playerPerkV3;
			if (!isNaN(playerPerkV4)) _playerPerkV4 = playerPerkV4;
			if (playerPerkDesc !== null) _playerPerkDesc = playerPerkDesc;
			return this;
		}

		public function playerPerkV1(playerPerkV1:Number):ArmorWithPerkParamBuilder
		{
			_playerPerkV1 = playerPerkV1;
			return this;
		}

		public function playerPerkV2(playerPerkV2:Number):ArmorWithPerkParamBuilder
		{
			_playerPerkV2 = playerPerkV2;
			return this;
		}

		public function playerPerkV3(playerPerkV3:Number):ArmorWithPerkParamBuilder
		{
			_playerPerkV3 = playerPerkV3;
			return this;
		}

		public function playerPerkV4(playerPerkV4:Number):ArmorWithPerkParamBuilder
		{
			_playerPerkV4 = playerPerkV4;
			return this;
		}

		public function playerPerkDesc(playerPerkDesc:String):ArmorWithPerkParamBuilder
		{
			_playerPerkDesc = playerPerkDesc;
			return this;
		}

		public function playerPerk2(playerPerk2:PerkType, playerPerk2V1:Number = NaN, playerPerk2V2:Number = NaN, playerPerk2V3:Number = NaN, playerPerk2V4:Number = NaN, playerPerk2Desc:String = null):ArmorWithPerkParamBuilder
		{
			_playerPerk2 = playerPerk2;
			if (!isNaN(playerPerk2V1)) _playerPerk2V1 = playerPerk2V1;
			if (!isNaN(playerPerk2V2)) _playerPerk2V2 = playerPerk2V2;
			if (!isNaN(playerPerk2V3)) _playerPerk2V3 = playerPerk2V3;
			if (!isNaN(playerPerk2V4)) _playerPerk2V4 = playerPerk2V4;
			if (playerPerk2Desc !== null) _playerPerk2Desc = playerPerk2Desc;
			return this;
		}

		public function playerPerk2V1(playerPerk2V1:Number):ArmorWithPerkParamBuilder
		{
			_playerPerk2V1 = playerPerk2V1;
			return this;
		}

		public function playerPerk2V2(playerPerk2V2:Number):ArmorWithPerkParamBuilder
		{
			_playerPerk2V2 = playerPerk2V2;
			return this;
		}

		public function playerPerk2V3(playerPerk2V3:Number):ArmorWithPerkParamBuilder
		{
			_playerPerk2V3 = playerPerk2V3;
			return this;
		}

		public function playerPerk2V4(playerPerk2V4:Number):ArmorWithPerkParamBuilder
		{
			_playerPerk2V4 = playerPerk2V4;
			return this;
		}

		public function playerPerk2Desc(playerPerk2Desc:String):ArmorWithPerkParamBuilder
		{
			_playerPerk2Desc = playerPerk2Desc;
			return this;
		}

		public function supportsBulge(supportsBulge:Boolean):ArmorWithPerkParamBuilder
		{
			_supportsBulge = supportsBulge;
			return this;
		}

		public function supportsUndergarment(supportsUndergarment:Boolean):ArmorWithPerkParamBuilder
		{
			_supportsUndergarment = supportsUndergarment;
			return this;
		}

		public function toObject():Object
		{
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
				playerPerkDesc:       _playerPerkDesc,
				playerPerk2:          _playerPerk2,
				playerPerk2V1:        _playerPerk2V1,
				playerPerk2V2:        _playerPerk2V2,
				playerPerk2V3:        _playerPerk2V3,
				playerPerk2V4:        _playerPerk2V4,
				playerPerk2Desc:      _playerPerk2Desc,
				supportsBulge:        _supportsBulge,
				supportsUndergarment: _supportsUndergarment
			};
		}

		public function toArray():Array
		{
			return [
				_id,
				_shortName,
				_name,
				_longName,
				_def,
				_value,
				_description,
				_perk,
				_playerPerk,
				_playerPerkV1,
				_playerPerkV2,
				_playerPerkV3,
				_playerPerkV4,
				_playerPerkDesc,
				_playerPerk2,
				_playerPerk2V1,
				_playerPerk2V2,
				_playerPerk2V3,
				_playerPerk2V4,
				_playerPerk2Desc,
				_supportsBulge,
				_supportsUndergarment,
			];
		}
	}
}
