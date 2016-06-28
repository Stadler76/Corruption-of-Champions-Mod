package classes 
{
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
				return [ARM_TYPE_DRACONIC, ARM_TYPE_SALAMANDER].indexOf(armType) != -1;
		}

		public function hasReptileFeet():Boolean
		{
				return [LOWER_BODY_TYPE_LIZARD, LOWER_BODY_TYPE_DRAGON, LOWER_BODY_TYPE_SALAMANDER].indexOf(lowerBody) != -1;
		}

		public function hasDraconicBackSide():Boolean
		{
			return hasDragonWings(true) && hasScales() && hasReptileTail() && hasReptileArms() && hasReptileFeet();
		}
	}
}
