package classes.BodyParts 
{
	/**
	 * Container class for the players ears
	 * @since August 08, 2017
	 * @author Stadler76
	 */
	public class Ears
	{
		public static const HUMAN:int      =   0;
		public static const HORSE:int      =   1;
		public static const DOG:int        =   2;
		public static const COW:int        =   3;
		public static const ELFIN:int      =   4;
		public static const CAT:int        =   5;
		public static const LIZARD:int     =   6;
		public static const BUNNY:int      =   7;
		public static const KANGAROO:int   =   8;
		public static const FOX:int        =   9;
		public static const DRAGON:int     =  10;
		public static const RACCOON:int    =  11;
		public static const MOUSE:int      =  12;
		public static const FERRET:int     =  13;
		public static const PIG:int        =  14;
		public static const RHINO:int      =  15;
		public static const ECHIDNA:int    =  16;
		public static const DEER:int       =  17;
		public static const WOLF:int       =  18;
		public static const SHEEP:int      =  19;
		public static const IMP:int        =  20;
		public static const COCKATRICE:int =  21;
		public static const RED_PANDA:int  =  22;

		public var type:Number  = HUMAN;
		public var value:Number = 0;

		public function restore():void
		{
			type  = HUMAN;
			value = 0;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))  type  = p.type;
			if (p.hasOwnProperty('value')) value = p.value;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
