package classes.BodyParts 
{
	import classes.Creature;
	import classes.GlobalFlags.kGAMECLASS;
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
		public static const RED_PANDA:int  =   8;
		public static const FERRET:int     =   9;

		private var _creature:Creature;
		public var type:Number = HUMAN;
		public var claws:Claws = new Claws();

		public function Arms(i_creature:Creature = null)
		{
			_creature = i_creature;
		}

		public function setType(armType:Number, clawType:Number = Claws.NORMAL):void
		{
			type = armType;

			switch (armType) {
				case PREDATOR:   updateClaws(clawType);         break;
				case SALAMANDER: updateClaws(Claws.SALAMANDER); break;
				case COCKATRICE: updateClaws(Claws.COCKATRICE); break;
				case RED_PANDA:  updateClaws(Claws.RED_PANDA);  break;
				case FERRET:     updateClaws(Claws.FERRET);     break;

				case HUMAN:
				case HARPY:
				case SPIDER:
				case BEE:
				case WOLF:
				default:         updateClaws(clawType);
			}
		}

		public function updateClaws(clawType:int = Claws.NORMAL):String
		{
			var clawTone:String = "";
			var oldClawTone:String = claws.tone;

			switch (clawType) {
				case Claws.DRAGON:     clawTone = "steel-gray"; break;
				case Claws.SALAMANDER: clawTone = "fiery-red";  break;
				case Claws.LIZARD:
					if (_creature === null)
						break;
					// See http://www.bergenbattingcenter.com/lizard-skins-bat-grip/ for all those NYI! lizard skin colors
					// I'm still not that happy with these claw tones. Any suggestion would be nice.
					switch (_creature.skin.tone) {
						case "red":         clawTone = "reddish";     break;
						case "green":       clawTone = "greenish";    break;
						case "white":       clawTone = "light-gray";  break;
						case "blue":        clawTone = "bluish";      break;
						case "black":       clawTone = "dark-gray";   break;
						case "purple":      clawTone = "purplish";    break;
						case "silver":      clawTone = "silvery";     break;
						case "pink":        clawTone = "pink";        break;
						case "orange":      clawTone = "orangey";     break;
						case "yellow":      clawTone = "yellowish";   break;
						case "desert-camo": clawTone = "pale-yellow"; break; // NYI!
						case "gray-camo":   clawTone = "gray";        break; // NYI!
						default:            clawTone = "gray";        break;
					}
					break;
				case Claws.IMP:
					if (_creature !== null)
						clawTone = _creature.skin.tone;
					break;
				default:
					clawTone = "";
			}

			claws.type = clawType;
			claws.tone = clawTone;

			return oldClawTone;
		}

		public function restore():void
		{
			type = HUMAN;
			claws.restore();
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type')) type = p.type;
			if (p.hasOwnProperty('claws')) claws.setProps(p.claws);
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
