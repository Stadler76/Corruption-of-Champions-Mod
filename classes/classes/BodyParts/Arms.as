package classes.BodyParts 
{
	/**
	 * Container class for the players arms
	 * @since November 07, 2017
	 * @author Stadler76
	 */
	public class Arms
	{
		public static const HUMAN:int      =   0;
		public static const HARPY:int      =   1;
		public static const SPIDER:int     =   2;
		public static const BEE:int        =   3;
		public static const PREDATOR:int   =   4;
		public static const SALAMANDER:int =   5;
		public static const WOLF:int       =   6;
		public static const COCKATRICE:int =   7;

		public var type:Number = HUMAN;

		public function Arms() {}

		public function restore():void
		{
			type = HUMAN;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type')) type = p.type;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
