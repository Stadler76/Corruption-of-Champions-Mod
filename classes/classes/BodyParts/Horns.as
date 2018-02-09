package classes.BodyParts 
{
	/**
	 * Container class for the players ears
	 * @since August 08, 2017
	 * @author Stadler76
	 */
	public class Horns
	{
		public static const NONE:int                     =   0;
		public static const DEMON:int                    =   1;
		public static const COW_MINOTAUR:int             =   2;
		public static const DRACONIC_X2:int              =   3;
		public static const DRACONIC_X4_12_INCH_LONG:int =   4;
		public static const ANTLERS:int                  =   5;
		public static const GOAT:int                     =   6;
		public static const UNICORN:int                  =   7;
		public static const RHINO:int                    =   8;
		public static const SHEEP:int                    =   9;
		public static const RAM:int                      =  10;
		public static const IMP:int                      =  11;

		public var type:Number  = NONE;
		/** horns length or number depending on the type */
		public var value:Number = 0;

		public function restore():void
		{
			type  = NONE;
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
