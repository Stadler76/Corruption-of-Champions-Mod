package classes.BodyParts 
{
	/**
	 * Container class for the players neck
	 * @since December 19, 2016
	 * @author Stadler76
	 */
	public class Neck extends BaseBodyPart
	{
		public static const NORMAL:int     =   0; // normal human neck. neckLen = 2 inches
		public static const DRACONIC:int   =   1; // (western) dragon neck. neckLen = 2-30 inches
		public static const COCKATRICE:int =   2;

		public var type:Number  = NORMAL;
		public var len:Number   = 2;
		public var pos:Boolean  = false;
		public var color:String = "no";

		private var _nlMax:Array = [];

		public function Neck()
		{
			_nlMax[NORMAL]   =  2;
			_nlMax[DRACONIC] = 30;
		}

		public function restore():void
		{
			type  = NORMAL;
			len   = 2;
			pos   = false;
			color = "no";
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))  type  = p.type;
			if (p.hasOwnProperty('len'))   len   = p.len;
			if (p.hasOwnProperty('pos'))   pos   = p.pos;
			if (p.hasOwnProperty('color')) color = p.color;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}

		public function modify(diff:Number, newType:Number = -1):void
		{
			if (newType != -1) type = newType;

			if (_nlMax[type] == undefined) { // Restore length and pos, if the type is not associated with a certain max length
				pos = false;
				len = 2;
				return;
			}

			len += diff;
			if (len < 2)  len = 2;
			if (len > _nlMax[type]) len = _nlMax[type];
		}

		public function isFullyGrown():Boolean
		{
			return len >= _nlMax[type];
		}

		override public function canDye():Boolean
		{
			return type == COCKATRICE;
		}

		override public function hasDyeColor(_color:String):Boolean
		{
			return color == _color;
		}

		override public function applyDye(_color:String):void
		{
			color = _color;
		}

		public function toObject():Object
		{
			return {
				type:  type,
				len:   len,
				pos:   pos,
				color: color
			};
		}
	}
}
