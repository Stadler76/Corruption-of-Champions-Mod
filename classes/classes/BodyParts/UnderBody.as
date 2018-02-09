package classes.BodyParts 
{
	/**
	 * Container class for the players underbody
	 * @since December 31, 2016
	 * @author Stadler76
	 */
	public class UnderBody 
	{
		public static const NONE:int       =   0;
		public static const REPTILE:int    =   1;
		public static const DRAGON:int     =   2; // Deprecated. Changed to 1 (UnderBody.REPTILE) upon loading a savegame
		public static const FURRY:int      =   3;
		public static const NAGA:int       =   4;
		public static const WOOL:int       =   5; // Deprecated. Changed to 3 (UnderBody.FURRY) upon loading a savegame
		public static const COCKATRICE:int =   6;

		public var type:Number = NONE;
		public var skin:Skin = new Skin();

		public function skinDescription(...args):String { return skin.description.apply(null, args); }
		public function skinFurScales(...args):String { return skin.skinFurScales.apply(null, args); }

		public function restore(keepTone:Boolean = true):void
		{
			type  = NONE;
			skin.restore(keepTone);
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type')) type = p.type;
			if (p.hasOwnProperty('skin')) skin.setProps(p.skin);
		}

		public function setAllProps(p:Object, keepTone:Boolean = true):void
		{
			restore(keepTone);
			setProps(p);
		}

		public function toObject():Object
		{
			return {
				type: type,
				skin: skin.toObject()
			};
		}
	}
}
