package classes
{
	import classes.GlobalFlags.kFLAGS;

	/**
	 * This contains some of the helper methods for the player-object I've written
	 * @author Stadler76
	 */
	public class PlayerHelper extends Character 
	{
		public function hasDragonWings(large:Boolean = false):Boolean
		{
			if (large)
				return wingType == WING_TYPE_DRACONIC_LARGE;
			else
				return [WING_TYPE_DRACONIC_SMALL, WING_TYPE_DRACONIC_LARGE].indexOf(wingType) != -1;
		}

		public function hasBatWings(large:Boolean = false):Boolean
		{
			if (large)
				return wingType == WING_TYPE_BAT_LIKE_LARGE;
			else
				return [WING_TYPE_BAT_LIKE_TINY, WING_TYPE_BAT_LIKE_LARGE].indexOf(wingType) != -1;
		}

		public function hasLeatherWings(large:Boolean = false):Boolean
		{
			return hasDragonWings(large) || hasBatWings(large);
		}

		public function hasScales():Boolean
		{
			return [SKIN_TYPE_SCALES, SKIN_TYPE_DRACONIC].indexOf(skinType) != -1;
		}

		public function hasReptileTail():Boolean
		{
			return [TAIL_TYPE_LIZARD, TAIL_TYPE_DRACONIC, TAIL_TYPE_SALAMANDER].indexOf(tailType) != -1;
		}

		public function hasReptileArms():Boolean
		{
			return [ARM_TYPE_PREDATOR, ARM_TYPE_SALAMANDER].indexOf(armType) != -1;
		}

		// As of now its just an alias for hasReptileArms()
		// Maybe in the future you want to have different predator arms. e. g. ARM_TYPE_FELINE for cats with retractable claws or whatever :)
		public function hasPredatorArms():Boolean
		{
			return [ARM_TYPE_PREDATOR, ARM_TYPE_SALAMANDER].indexOf(armType) != -1;
		}

		public function hasReptileFeet():Boolean
		{
			return [LOWER_BODY_TYPE_LIZARD, LOWER_BODY_TYPE_DRAGON, LOWER_BODY_TYPE_SALAMANDER].indexOf(lowerBody) != -1;
		}

		public function hasDraconicBackSide():Boolean
		{
			return hasDragonWings(true) && hasScales() && hasReptileTail() && hasReptileArms() && hasReptileFeet();
		}

		public function hasDragonNeck():Boolean
		{
			return neckLength >= 30;
		}

		public function hasNormalNeck():Boolean
		{
			return neckLength <= 2;
		}

		public function hasDragonRearBody():Boolean
		{
			return [REAR_BODY_TYPE_DRACONIC_MANE, REAR_BODY_TYPE_DRACONIC_SPIKES].indexOf(rearBodyType) != -1;
		}

		public function fetchEmberRearBodyType():Number
		{
			return flags[kFLAGS.EMBER_HAIR] == 2 ? REAR_BODY_TYPE_DRACONIC_MANE : REAR_BODY_TYPE_DRACONIC_SPIKES;
		}

		public function newLizanSkinTone():String
		{
			if (rand(10) == 0) {
				//rare skinTone
				return rand(2) == 0 ? "purple" : "silver";
			} else {
				//non rare skinTone
				switch (rand(5)) {
					case 0: return "red";
					case 1: return "green";
					case 2: return "white";
					case 3: return "blue";
					case 4: return "black";
				}
			}
			return "invalid"; // Will never happen. Suppresses 'Error: Function does not return a value.'
		}
	}
}
