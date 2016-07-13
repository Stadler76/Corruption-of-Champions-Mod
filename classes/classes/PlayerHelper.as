package classes
{
	import classes.GlobalFlags.kFLAGS;

	/**
	 * This contains some of the helper methods for the player-object I've written
	 * @since June 29, 2016
	 * @author Stadler
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

		public function hasBatLikeWings(large:Boolean = false):Boolean
		{
			if (large)
				return wingType == WING_TYPE_BAT_LIKE_LARGE;
			else
				return [WING_TYPE_BAT_LIKE_TINY, WING_TYPE_BAT_LIKE_LARGE].indexOf(wingType) != -1;
		}

		public function hasLeatherWings(large:Boolean = false):Boolean
		{
			return hasDragonWings(large) || hasBatLikeWings(large);
		}

		public function hasScales():Boolean
		{
			return [SKIN_TYPE_SCALES, SKIN_TYPE_DRACONIC].indexOf(skinType) != -1;
		}

		// used more than once, so I wrote a helper method for it
		public function hasFurOrScales():Boolean
		{
			return skinType == SKIN_TYPE_FUR || hasScales();
		}

		public function hasReptileTail():Boolean
		{
			return [TAIL_TYPE_LIZARD, TAIL_TYPE_DRACONIC, TAIL_TYPE_SALAMANDER].indexOf(tailType) != -1;
		}

		public function hasDragonHorns():Boolean
		{
			return [HORNS_DRACONIC_X2, HORNS_DRACONIC_X4_12_INCH_LONG].indexOf(hornType) != -1;
		}

		// For reptiles with predator arms I recommend to require hasScales() before doing the armType TF to ARM_TYPE_PREDATOR
		public function hasReptileArms():Boolean
		{
			return armType == ARM_TYPE_SALAMANDER || (armType == ARM_TYPE_PREDATOR && hasScales());
		}

		public function hasPredatorArms():Boolean
		{
			return [ARM_TYPE_PREDATOR, ARM_TYPE_SALAMANDER].indexOf(armType) != -1;
		}

		public function hasReptileFeet():Boolean
		{
			return [LOWER_BODY_TYPE_LIZARD, LOWER_BODY_TYPE_DRAGON, LOWER_BODY_TYPE_SALAMANDER].indexOf(lowerBody) != -1;
		}

		public function hasReptileEyes():Boolean
		{
			return [EYES_LIZARD, EYES_DRAGON, EYES_BASILISK].indexOf(eyeType) != -1;
		}

		public function hasDraconicBackSide():Boolean
		{
			return hasDragonWings(true) && skinType == SKIN_TYPE_DRACONIC && hasReptileTail() && hasReptileArms() && hasReptileFeet();
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
	}
}
