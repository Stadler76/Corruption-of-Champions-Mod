package classes
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.kFLAGS;

	/**
	 * This contains some of the helper methods for the player-object I've written
	 * @since June 29, 2016
	 * @author Stadler76
	 */
	public class PlayerHelper extends Character 
	{
		public function PlayerHelper() {}

		public function hasDifferentUnderBody():Boolean
		{
			if ([UnderBody.NONE, UnderBody.NAGA].indexOf(underBody.type) != -1)
				return false;

			/* // Example for later use
			if ([UNDER_BODY_TYPE_MERMAID, UNDER_BODY_TYPE_WHATEVER].indexOf(underBody.type) != -1)
				return false; // The underBody is (mis)used for secondary skin, not for the underBody itself
			*/

			return underBody.skin.type != skin.type || underBody.skin.tone != skin.tone ||
			       underBody.skin.adj  != skin.adj  || underBody.skin.desc != skin.desc ||
			       (underBody.skin.hasFur() && hasFur() && underBody.skin.furColor != skin.furColor);
		}

		public function hasUnderBody(noSnakes:Boolean = false):Boolean
		{
			var normalUnderBodies:Array = [UnderBody.NONE];

			if (noSnakes) {
				normalUnderBodies.push(UnderBody.NAGA);
			}

			return normalUnderBodies.indexOf(underBody.type) == -1;
		}

		public function hasFurryUnderBody(noSnakes:Boolean = false):Boolean
		{
			return hasUnderBody(noSnakes) && underBody.skin.hasFur();
		}

		public function hasFeatheredUnderBody(noSnakes:Boolean = false):Boolean
		{
			return hasUnderBody(noSnakes) && underBody.skin.hasFeathers();
		}

		public function hasDragonHorns(fourHorns:Boolean = false):Boolean
		{
			return (!fourHorns && horns.value > 0 && horns.type == Horns.DRACONIC_X2) || horns.type == Horns.DRACONIC_X4_12_INCH_LONG;
		}

		public function hasReptileEyes():Boolean
		{
			return [Eyes.LIZARD, Eyes.DRAGON, Eyes.BASILISK].indexOf(eyes.type) != -1;
		}

		public function hasLizardEyes():Boolean
		{
			return [Eyes.LIZARD, Eyes.BASILISK].indexOf(eyes.type) != -1;
		}

		public function hasReptileFace():Boolean
		{
			return [Face.SNAKE_FANGS, Face.LIZARD, Face.DRAGON].indexOf(face.type) != -1;
		}

		public function hasReptileUnderBody(withSnakes:Boolean = false):Boolean
		{
			var underBodies:Array = [
				UnderBody.REPTILE,
			];

			if (withSnakes) {
				underBodies.push(UnderBody.NAGA);
			}

			return underBodies.indexOf(underBody.type) != -1;
		}

		public function hasCockatriceSkin():Boolean
		{
			return skin.type == Skin.LIZARD_SCALES && underBody.type == UnderBody.COCKATRICE;
		}

		public function hasNonCockatriceAntennae():Boolean
		{
			return [Antennae.NONE, Antennae.COCKATRICE].indexOf(antennae.type) === -1;
		}

		public function hasInsectAntennae():Boolean
		{
			return antennae.type === Antennae.BEE;
		}

		public function hasDragonWings(large:Boolean = false):Boolean
		{
			if (large)
				return wings.type == Wings.DRACONIC_LARGE;
			else
				return [Wings.DRACONIC_SMALL, Wings.DRACONIC_LARGE].indexOf(wings.type) != -1;
		}

		public function hasBatLikeWings(large:Boolean = false):Boolean
		{
			if (large)
				return wings.type == Wings.BAT_LIKE_LARGE;
			else
				return [Wings.BAT_LIKE_TINY, Wings.BAT_LIKE_LARGE].indexOf(wings.type) != -1;
		}

		public function hasLeatheryWings(large:Boolean = false):Boolean
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

		public function hasDragonfire():Boolean
		{
			return findPerk(PerkLib.Dragonfire) >= 0;
		}

		public function hasDragonWingsAndFire(largeWings:Boolean = true):Boolean
		{
			return hasDragonWings(largeWings) && hasDragonfire();
		}

		public function isBasilisk():Boolean
		{
			return game.bazaar.benoit.benoitBigFamily() && eyes.type == Eyes.BASILISK;
		}

		public function hasReptileTail():Boolean
		{
			return [Tail.LIZARD, Tail.DRACONIC, Tail.SALAMANDER].indexOf(tail.type) != -1;
		}

		public function hasMultiTails():Boolean
		{
			return (tail.type === Tail.FOX && tail.venom > 1);
		}

		// For reptiles with predator arms I recommend to require hasReptileScales() before doing the armType TF to Arms.PREDATOR
		public function hasReptileArms():Boolean
		{
			return arms.type == Arms.SALAMANDER || (arms.type == Arms.PREDATOR && hasReptileScales());
		}

		public function hasReptileLegs():Boolean
		{
			return [LowerBody.LIZARD, LowerBody.DRAGON, LowerBody.SALAMANDER].indexOf(lowerBody.type) != -1;
		}

		public function hasDraconicBackSide():Boolean
		{
			return hasDragonWings(true) && hasDragonScales() && hasReptileTail() && hasReptileArms() && hasReptileLegs();
		}

		public function hasDragonNeck():Boolean
		{
			return neck.type == Neck.DRACONIC && neck.isFullyGrown();
		}

		public function hasNormalNeck():Boolean
		{
			return neck.len <= 2;
		}

		public function hasDragonRearBody():Boolean
		{
			return [RearBody.DRACONIC_MANE, RearBody.DRACONIC_SPIKES].indexOf(rearBody.type) != -1;
		}

		public function hasNonSharkRearBody():Boolean
		{
			return [RearBody.NONE, RearBody.SHARK_FIN].indexOf(rearBody.type) == -1;
		}

		public function fetchEmberRearBody():Number
		{
			return flags[kFLAGS.EMBER_HAIR] == 2 ? RearBody.DRACONIC_MANE : RearBody.DRACONIC_SPIKES;
		}

		public function featheryHairPinEquipped():Boolean
		{
			return hasKeyItem("Feathery hair-pin") >= 0 && keyItemv1("Feathery hair-pin") == 1;
		}
	}
}
