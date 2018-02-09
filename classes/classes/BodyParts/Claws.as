package classes.BodyParts 
{
	/**
	 * Container class for the players claws
	 * @since November 08, 2017
	 * @author Stadler76
	 */
	public class Claws
	{
		public static const NORMAL:int     =   0;
		public static const LIZARD:int     =   1;
		public static const DRAGON:int     =   2;
		public static const SALAMANDER:int =   3;
		public static const CAT:int        =   4; // NYI! Placeholder for now!!
		public static const DOG:int        =   5; // NYI! Placeholder for now!!
		public static const RAPTOR:int     =   6; // NYI! Placeholder for now!!
		public static const MANTIS:int     =   7; // NYI! Placeholder for Xianxia mod
		public static const IMP:int        =   8;
		public static const COCKATRICE:int =   9;
		public static const RED_PANDA:int  =  10;
		public static const FERRET:int     =  11;

		public var type:Number = NORMAL;
		public var tone:String = "";

		public function restore():void
		{
			type = NORMAL;
			tone = "";
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type')) type = p.type;
			if (p.hasOwnProperty('tone')) tone = p.tone;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
