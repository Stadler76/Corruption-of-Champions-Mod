package classes.BodyParts 
{
	/**
	 * Container class for the players gills
	 * @since November 07, 2017
	 * @author Stadler76
	 */
	public class Gills
	{
		public static const NONE:int    =   0;
		public static const ANEMONE:int =   1;
		public static const FISH:int    =   2;

		public var type:Number = NONE;

		public function restore():void
		{
			type = NONE;
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
