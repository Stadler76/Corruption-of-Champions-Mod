package classes.BodyParts 
{
	/**
	 * Container class for the players tongue
	 * @since August 08, 2017
	 * @author Stadler76
	 */
	public class Tongue
	{
		public static const HUMAN:int    =   0;
		public static const SNAKE:int    =   1;
		public static const DEMONIC:int  =   2;
		public static const DRACONIC:int =   3;
		public static const ECHIDNA:int  =   4;
		public static const LIZARD:int   =   5;
		public static const CAT:int      =   6;

		public var type:Number = HUMAN;

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
