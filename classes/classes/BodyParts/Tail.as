package classes.BodyParts 
{
	/**
	 * Container class for the players tail
	 * @since November 05, 2017
	 * @author Stadler76
	 */
	public class Tail
	{
		public static const NONE:int           =   0;
		public static const HORSE:int          =   1;
		public static const DOG:int            =   2;
		public static const DEMONIC:int        =   3;
		public static const COW:int            =   4;
		public static const SPIDER_ABDOMEN:int =   5;
		public static const BEE_ABDOMEN:int    =   6;
		public static const SHARK:int          =   7;
		public static const CAT:int            =   8;
		public static const LIZARD:int         =   9;
		public static const RABBIT:int         =  10;
		public static const HARPY:int          =  11;
		public static const KANGAROO:int       =  12;
		public static const FOX:int            =  13;
		public static const DRACONIC:int       =  14;
		public static const RACCOON:int        =  15;
		public static const MOUSE:int          =  16;
		public static const FERRET:int         =  17;
		public static const BEHEMOTH:int       =  18;
		public static const PIG:int            =  19;
		public static const SCORPION:int       =  20;
		public static const GOAT:int           =  21;
		public static const RHINO:int          =  22;
		public static const ECHIDNA:int        =  23;
		public static const DEER:int           =  24;
		public static const SALAMANDER:int     =  25;
		public static const WOLF:int           =  26;
		public static const SHEEP:int          =  27;
		public static const IMP:int            =  28;
		public static const COCKATRICE:int     =  29;
		public static const RED_PANDA:int      =  30;

		public var type:Number     = NONE;
		/** Tail venom is a 0-100 slider used for tail attacks. Recharges per hour. */
		public var venom:Number    = 0;
		/** Tail recharge determines how fast venom/webs comes back per hour. */
		public var recharge:Number = 5;

		public function restore():void
		{
			type     = NONE;
			venom    = 0;
			recharge = 5;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))     type     = p.type;
			if (p.hasOwnProperty('venom'))    venom    = p.venom;
			if (p.hasOwnProperty('recharge')) recharge = p.recharge;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
