package classes.BodyParts 
{
	/**
	 * Container class for the players eyes
	 * @since August 08, 2017
	 * @author Stadler76
	 */
	public class Eyes
	{
		public static const HUMAN:int                =   0;
		public static const FOUR_SPIDER_EYES:int     =   1; //DEPRECATED, USE Eyes.SPIDER AND EYECOUNT = 4
		public static const BLACK_EYES_SAND_TRAP:int =   2;
		public static const LIZARD:int               =   3;
		public static const DRAGON:int               =   4; // Slightly different description/TF and *maybe* in the future(!) grant different perks/combat abilities
		public static const BASILISK:int             =   5;
		public static const WOLF:int                 =   6;
		public static const SPIDER:int               =   7;
		public static const COCKATRICE:int           =   8;

		public var type:Number  = HUMAN;
		public var count:Number = 2;

		public function restore():void
		{
			type  = HUMAN;
			count = 2;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))  type  = p.type;
			if (p.hasOwnProperty('count')) count = p.count;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
