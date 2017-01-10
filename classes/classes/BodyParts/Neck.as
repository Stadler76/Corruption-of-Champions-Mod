package classes.BodyParts 
{
	/**
	 * Container class for the players neck
	 * @since December 19, 2016
	 * @author Stadler76
	 */
	public class Neck 
	{
		include "../../../includes/appearanceDefs.as";

		public var type:Number = NECK_TYPE_NORMAL;
		public var len:Number = 2;
		public var pos:Boolean = false;

		private var _nlMax:Array = [];

		public function Neck()
		{
			_nlMax[NECK_TYPE_NORMAL]   =  2;
			_nlMax[NECK_TYPE_DRACONIC] = 30;
			_nlMax[NECK_TYPE_EASTERN]  = 48; // NYI, for later use
			_nlMax[NECK_TYPE_HYDRA]    = 72; // NYI, example
		}

		public function restore():void
		{
			type = NECK_TYPE_NORMAL;
			len  = 2;
			pos  = false;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type')) type = p.type;
			if (p.hasOwnProperty('len'))  len  = p.len;
			if (p.hasOwnProperty('pos'))  pos  = p.pos;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}

		public function modify(diff:Number, newType:Number = -1):void
		{
			if (newType != -1) type = newType;

			len += diff;
			if (len < 2)  len = 2;
			if (len > _nlMax[type]) len = _nlMax[type];
		}

		public function isFullyGrown():Boolean
		{
			return len >= _nlMax[type];
		}
	}
}
