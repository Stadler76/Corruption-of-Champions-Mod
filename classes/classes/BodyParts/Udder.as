package classes.BodyParts 
{
	/**
	 * Container class for the players udder
	 * @since January 19, 2018
	 * @author NoahTheGoodra
	 */
    public class Udder
	{
		/** Udder hasUdder a bool value that says if the player has an undder */
		public var hasUdder:Boolean = false;
		/** Udder fullness is a 0-100 slider used for how full the udder is. Recharges per hour. */
		public var fullness:Number = 0;
		/** Udder refill determines how fast milk comes back per hour. */
		public var refill:Number = 5;


		public function restore():void
		{
			hasUdder = false;
			fullness = 0;
			refill = 5;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('hasUdder')) hasUdder = p.hasUdder;
			if (p.hasOwnProperty('fullness')) fullness = p.fullness;
			if (p.hasOwnProperty('refill'))   refill   = p.refill;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}

		public function toObject():Object
		{
			return {
				hasUdder: hasUdder,
				fullness: fullness,
				refill:   refill
			};
		}
	}
}
