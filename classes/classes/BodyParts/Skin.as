package classes.BodyParts 
{
	import classes.Appearance;

	/**
	 * Container class for the players skin
	 * @since December 27, 2016
	 * @author Stadler76
	 */
	public class Skin 
	{
		public static const PLAIN:int         =   0;
		public static const FUR:int           =   1;
		public static const LIZARD_SCALES:int =   2;
		public static const GOO:int           =   3;
		public static const UNDEFINED:int     =   4; // DEPRECATED, silently discarded upon loading a saved game
		public static const DRAGON_SCALES:int =   5;
		public static const FISH_SCALES:int   =   6; // NYI, for future use
		public static const WOOL:int          =   7;
		public static const FEATHERED:int     =   8;
		public static const BARK:int          =   9;
		public var type:Number = PLAIN;
		public var tone:String = "albino";
		public var desc:String = "skin";
		public var adj:String = "";
		public var furColor:String = "no";

		public function setType(value:Number):void
		{
			desc = Appearance.DEFAULT_SKIN_DESCS[value];
			type = value;
		}

		public function skinFurScales():String
		{
			var skinzilla:String = "";
			//Adjectives first!
			if (adj !== "")
				skinzilla += adj + ", ";

			//Fur handled a little differently since it uses haircolor
			skinzilla += isFluffy() ? furColor : tone;

			return skinzilla + " " + desc;
		}

		public function description(noAdj:Boolean = false, noTone:Boolean = false):String
		{
			var skinzilla:String = "";

			//Adjectives first!
			if (!noAdj && adj !== "" && !noTone && tone !== "rough gray")
				skinzilla += adj + ", ";
			if (!noTone)
				skinzilla += tone + " ";

			//Fur handled a little differently since it uses haircolor
			skinzilla += isFluffy() ? "skin" : desc;

			return skinzilla;
		}

		public function hasFur():Boolean
		{
			return type === FUR;
		}

		public function hasWool():Boolean
		{
			return type === WOOL;
		}

		public function hasFeathers():Boolean
		{
			return  type === FEATHERED;
		}

		public function isFurry():Boolean
		{
			return [FUR, WOOL].indexOf(type) !== -1;
		}

		public function isFluffy():Boolean
		{
			return [FUR, WOOL, FEATHERED].indexOf(type) !== -1;
		}

		public function restore(keepTone:Boolean = true):void
		{
			type = PLAIN;
			if (!keepTone) tone = "albino";
			desc = "skin";
			adj  = "";
			furColor = "no";
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type')) type = p.type;
			if (p.hasOwnProperty('tone')) tone = p.tone;
			if (p.hasOwnProperty('desc')) desc = p.desc;
			if (p.hasOwnProperty('adj'))  adj  = p.adj;
			if (p.hasOwnProperty('furColor')) furColor = p.furColor;
		}

		public function setAllProps(p:Object, keepTone:Boolean = true):void
		{
			restore(keepTone);
			setProps(p);
		}

		public function toObject():Object
		{
			return {
				type:     type,
				tone:     tone,
				desc:     desc,
				adj:      adj,
				furColor: furColor
			};
		}
	}
}
