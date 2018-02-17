package classes.BodyParts 
{
	/**
	 * Container class for the players hair
	 * @since August 08, 2017
	 * @author Stadler76
	 */
	public class Hair
	{
		public static const NORMAL:int          =    0;
		public static const FEATHER:int         =    1;
		public static const GHOST:int           =    2;
		public static const GOO:int             =    3;
		public static const ANEMONE:int         =    4;
		public static const QUILL:int           =    5;
		public static const BASILISK_SPINES:int =    6;
		public static const BASILISK_PLUME:int  =    7;
		public static const WOOL:int            =    8;
		public static const LEAF:int            =    9;

		public var type:Number   = NORMAL;
		public var color:String  = "no";
		public var length:Number = 0;

		public function restore():void
		{
			type   = NORMAL;
			color  = "no";
			length = 0;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))   type   = p.type;
			if (p.hasOwnProperty('color'))  color  = p.color;
			if (p.hasOwnProperty('length')) length = p.length;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
