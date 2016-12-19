package classes.BodyParts 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Neck 
	{
		include "../../../includes/appearanceDefs.as";

		public var type:Number = NECK_TYPE_NORMAL;
		public var len:Number = 2;
		public function get length():Number { return len; }
		public function set length(value:Number):void { len = value; }
		public var pos:Boolean = false;

		public var nlMax:Array = [];

		public function Neck()
		{
			nlMax[NECK_TYPE_NORMAL]   =  2;
			nlMax[NECK_TYPE_DRACONIC] = 30;
			nlMax[NECK_TYPE_EASTERN]  = 48; // NYI, for later use
			nlMax[NECK_TYPE_HYDRA]    = 72; // NYI, example
		}

		public function restore():Neck
		{
			type = NECK_TYPE_NORMAL;
			len  = 2;
			pos  = false;

			return this;
		}

		public function setProps(p:Object):Neck
		{
			if (p.type   != undefined) type = p.type;
			if (p.len    != undefined) len  = p.len;
			if (p.length != undefined) len  = p.length;
			if (p.pos    != undefined) pos  = p.pos;

			return this;
		}

		public function setAllProps(p:Object):Neck
		{
			restore();
			setProps(p);
			/*type = p.type != undefined ? p.type : NECK_TYPE_NORMAL;
			len  = p.len  != undefined ? p.len  : 2;
			pos  = p.pos  != undefined ? p.pos  : false;*/

			return this;
		}

		public function modify(l:Number, newType:Number = -1):Neck
		{
			if (newType != -1) type = newType;

			len += l;
			if (len < 2)  len = 2;
			if (len > nlMax[type]) len = nlMax[type];

			return this;
		}

		public function isFullyGrown():Boolean
		{
			return len >= nlMax[type];
		}
	}
}
