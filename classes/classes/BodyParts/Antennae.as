package classes.BodyParts 
{
	/**
	 * Container class for the players antennae
	 * @since November 08, 2017
	 * @author Stadler76
	 */
	public class Antennae
	{
		public static const NONE:int       =   0;
		public static const BEE:int        =   2;
		public static const COCKATRICE:int =   3;

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
