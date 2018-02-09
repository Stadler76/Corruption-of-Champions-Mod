package classes.BodyParts 
{
	import classes.Creature;

	/**
	 * Container class for the players rear body
	 * @since December 20, 2016
	 * @author Stadler76
	 */
	public class RearBody extends BaseBodyPart
	{
		public static const NONE:int            =   0;
		public static const DRACONIC_MANE:int   =   1;
		public static const DRACONIC_SPIKES:int =   2;
		public static const SHARK_FIN:int       =   3;

		public var type:Number  = NONE;
		public var color:String = "no";

		public function restore():void
		{
			type  = NONE;
			color = "no";
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))  type  = p.type;
			if (p.hasOwnProperty('color')) color = p.color;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}

		override public function canDye():Boolean
		{
			return type === DRACONIC_MANE;
		}

		override public function hasDyeColor(_color:String):Boolean
		{
			return color === _color;
		}

		override public function applyDye(_color:String):void
		{
			color = _color;
		}

		public function toObject():Object
		{
			return {
				type:  type,
				color: color
			};
		}
	}
}
