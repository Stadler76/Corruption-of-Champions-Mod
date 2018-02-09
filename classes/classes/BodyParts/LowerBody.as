package classes.BodyParts 
{
	/**
	 * Container class for the players lowerbody
	 * @since August 08, 2017
	 * @author Stadler76
	 */
	public class LowerBody
	{
		public static const HUMAN:int                 =   0;
		public static const HOOFED:int                =   1;
		public static const DOG:int                   =   2;
		public static const NAGA:int                  =   3;
		//public static const CENTAUR:int             =   4; //DEPRECATED - USE HOOFED + LEGCOUNT 4
		public static const DEMONIC_HIGH_HEELS:int    =   5;
		public static const DEMONIC_CLAWS:int         =   6;
		public static const BEE:int                   =   7;
		public static const GOO:int                   =   8;
		public static const CAT:int                   =   9;
		public static const LIZARD:int                =  10;
		public static const PONY:int                  =  11;
		public static const BUNNY:int                 =  12;
		public static const HARPY:int                 =  13;
		public static const KANGAROO:int              =  14;
		public static const CHITINOUS_SPIDER_LEGS:int =  15;
		public static const DRIDER:int                =  16;
		public static const FOX:int                   =  17;
		public static const DRAGON:int                =  18;
		public static const RACCOON:int               =  19;
		public static const FERRET:int                =  20;
		public static const CLOVEN_HOOFED:int         =  21;
		//public static const RHINO:int               =  22;
		public static const ECHIDNA:int               =  23;
		//public static const DEERTAUR:int            =  24; //DEPRECATED - USE CLOVEN HOOFED + LEGCOUNT 4
		public static const SALAMANDER:int            =  25;
		public static const WOLF:int                  =  26;
		public static const IMP:int                   =  27;
		public static const COCKATRICE:int            =  28;
		public static const RED_PANDA:int             =  29;

		public var type:Number     = HUMAN;
		public var legCount:Number = 2;

		public function restore():void
		{
			type     = HUMAN;
			legCount = 2;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))     type     = p.type;
			if (p.hasOwnProperty('legCount')) legCount = p.legCount;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
