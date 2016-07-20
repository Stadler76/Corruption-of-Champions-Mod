package classes
{
	import classes.GlobalFlags.kFLAGS;

	/**
	 * This contains some of the helper methods for the player-object I've written
	 * @since June 29, 2016
	 * @author Stadler76
	 */
	public class PlayerHelper extends Character 
	{
		public function PlayerHelper() {}
		
		public function hasScales():Boolean
		{
			return [SKIN_TYPE_SCALES, SKIN_TYPE_DRACONIC].indexOf(skinType) != -1;
		}

		public function hasFurOrScales():Boolean
		{
			return skinType == SKIN_TYPE_FUR || hasScales();
		}

		public function hasDragonHorns():Boolean
		{
			return (horns > 0 && hornType == HORNS_DRACONIC_X2) || hornType == HORNS_DRACONIC_X4_12_INCH_LONG;
		}

		public function hasReptileEyes():Boolean
		{
			return [EYES_LIZARD, EYES_DRAGON, EYES_BASILISK].indexOf(eyeType) != -1;
		}

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

		// To be honest: I seriously considered naming it drDragonCox() :D
		public function dragonCocks():int
		{
			return countCocksOfType(CockTypesEnum.DRAGON);
		}

		public function lizardCocks():int
		{
			return countCocksOfType(CockTypesEnum.LIZARD);
		}

		public function hasReptileTail():Boolean
		{
			return [TAIL_TYPE_LIZARD, TAIL_TYPE_DRACONIC, TAIL_TYPE_SALAMANDER].indexOf(tailType) != -1;
		}

		// For reptiles with predator arms I recommend to require hasScales() before doing the armType TF to ARM_TYPE_PREDATOR
		public function hasReptileArms():Boolean
		{
			return armType == ARM_TYPE_SALAMANDER || (armType == ARM_TYPE_PREDATOR && hasScales());
		}

		/*
		public function hasPredatorArms():Boolean
		{
			return [ARM_TYPE_PREDATOR, ARM_TYPE_SALAMANDER].indexOf(armType) != -1;
		}
		*/

		public function hasReptileFeet():Boolean
		{
			return [LOWER_BODY_TYPE_LIZARD, LOWER_BODY_TYPE_DRAGON, LOWER_BODY_TYPE_SALAMANDER].indexOf(lowerBody) != -1;
		}

		public function hasDragonfire():Boolean
		{
			return findPerk(PerkLib.Dragonfire) >= 0;
		}

		public function hasDragonWingsAndFire():Boolean
		{
			return hasDragonWings(true) && hasDragonfire();
		}

		public function isBasilisk():Boolean
		{
			return findPerk(PerkLib.BasiliskWomb) >= 0 /*&& eyeType == EYES_BASILISK*/;
		}

		public function hasDraconicBackSide():Boolean
		{
			return hasDragonWings(true) && skinType == SKIN_TYPE_DRACONIC && hasReptileTail() && hasReptileArms() && hasReptileFeet();
		}

		public function hasDragonNeck():Boolean
		{
			return neckLen >= 30;
		}

		public function hasNormalNeck():Boolean
		{
			return neckLen <= 2;
		}

		public function hasDragonRearBody():Boolean
		{
			return [REAR_BODY_TYPE_DRACONIC_MANE, REAR_BODY_TYPE_DRACONIC_SPIKES].indexOf(rearBody) != -1;
		}

		public function fetchEmberRearBody():Number
		{
			return flags[kFLAGS.EMBER_HAIR] == 2 ? REAR_BODY_TYPE_DRACONIC_MANE : REAR_BODY_TYPE_DRACONIC_SPIKES;
		}
	}
}
