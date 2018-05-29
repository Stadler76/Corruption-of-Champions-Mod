package classes.BodyParts 
{
	/**
	 * Container class for the players wings
	 * @since May 01, 2017
	 * @author Stadler76
	 */
	public class Wings extends BaseBodyPart
	{
		public static const NONE:int            =   0;
		public static const BEE_LIKE_SMALL:int  =   1;
		public static const BEE_LIKE_LARGE:int  =   2;
		public static const HARPY:int           =   4;
		public static const IMP:int             =   5;
		public static const BAT_LIKE_TINY:int   =   6;
		public static const BAT_LIKE_LARGE:int  =   7;
		public static const SHARK_FIN:int       =   8; // Deprecated, moved to the rearBody slot.
		public static const FEATHERED_LARGE:int =   9;
		public static const DRACONIC_SMALL:int  =  10;
		public static const DRACONIC_LARGE:int  =  11;
		public static const GIANT_DRAGONFLY:int =  12;
		public static const IMP_LARGE:int       =  13;
		public static const FAERIE_SMALL:int    =  14; // currently for monsters only
		public static const FAERIE_LARGE:int    =  15; // currently for monsters only

		public var type:Number  = NONE;
		public var color:String = "no";
		public var color2:String = "no";

		/**
		 * Returns a string that describes, what the actual color number (=id) is for.
		 * e. g.: Dragon Wings main color => "membranes" and secondary color => "bones"
		 * @param   id  The 'number' of the chosen color (main = color, secondary = color2)
		 * @return  The resulting description string
		 */
		override public function getColorDesc(id:int):String
		{
			switch (type) {
				case DRACONIC_SMALL:
				case DRACONIC_LARGE:
					switch (id) {
						case COLOR_ID_MAIN:
							return "membranes";

						case COLOR_ID_2ND:
							return "bones";

						default: 
							return "";
					}

				default:
					return "";
			}
		}

		public function restore():void
		{
			type  = NONE;
			color = "no";
			color2 = "no";
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))  type  = p.type;
			if (p.hasOwnProperty('color')) color = p.color;
			if (p.hasOwnProperty('color2')) color2 = p.color2;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}

		override public function canDye():Boolean
		{
			return [HARPY, FEATHERED_LARGE].indexOf(type) !== -1;
		}

		override public function hasDyeColor(_color:String):Boolean
		{
			return color === _color;
		}

		override public function applyDye(_color:String):void
		{
			color = _color;
		}

		override public function canOil():Boolean
		{
			return [DRACONIC_SMALL, DRACONIC_LARGE].indexOf(type) !== -1;
		}

		override public function hasOilColor(_color:String):Boolean
		{
			return color === _color;
		}

		override public function applyOil(_color:String):void
		{
			color = _color;
		}

		override public function canOil2():Boolean
		{
			return [DRACONIC_SMALL, DRACONIC_LARGE].indexOf(type) !== -1;
		}

		override public function hasOil2Color(_color2:String):Boolean
		{
			return color2 === _color2;
		}

		override public function applyOil2(_color2:String):void
		{
			color2 = _color2;
		}
	}
}
