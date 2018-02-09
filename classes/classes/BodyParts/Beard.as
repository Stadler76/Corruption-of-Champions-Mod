package classes.BodyParts 
{
	/**
	 * Container class for the players beard
	 * @since August 08, 2017
	 * @author Stadler76
	 */
	public class Beard
	{
		public static const NORMAL:int      =    0;
		public static const GOATEE:int      =    1;
		public static const CLEANCUT:int    =    2;
		public static const MOUNTAINMAN:int =    3;

		public var style:Number  = NORMAL;
		public var length:Number = 0;

		public function restore():void
		{
			style  = NORMAL;
			length = 0;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('style'))  style  = p.style;
			if (p.hasOwnProperty('length')) length = p.length;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
