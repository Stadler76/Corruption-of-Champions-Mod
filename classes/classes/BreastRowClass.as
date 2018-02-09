package classes
{
	import classes.internals.Utils;
	import classes.lists.BreastCup;

	public class BreastRowClass
	{
		public var breasts:Number = 2;
		public var nipplesPerBreast:Number = 1;
		public var breastRating:Number = BreastCup.FLAT;
		public var lactationMultiplier:Number = 0;
		//Fullness used for lactation....if 75 or greater warning bells start going off!
		//If it reaches 100 it reduces lactation multiplier.
		public var milkFullness:Number = 0;
		public var fullness:Number = 0;
		public var fuckable:Boolean = false;
		public var nippleCocks:Boolean = false;

		public function validate():String
		{
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "BreastRowClass.validate", [
					"breasts", "nipplesPerBreast", "breastRating", "lactationMultiplier",
					"milkFullness", "fullness"
			]);
			return error;
		}

		public function restore():void
		{
			breasts = 2;
			nipplesPerBreast = 1;
			breastRating = BreastCup.FLAT;
			lactationMultiplier = 0;
			milkFullness = 0;
			fullness = 0;
			fuckable = false;
			nippleCocks = false;
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('breasts'))             breasts             = p.breasts;
			if (p.hasOwnProperty('nipplesPerBreast'))    nipplesPerBreast    = p.nipplesPerBreast;
			if (p.hasOwnProperty('breastRating'))        breastRating        = p.breastRating;
			if (p.hasOwnProperty('lactationMultiplier')) lactationMultiplier = p.lactationMultiplier;
			if (p.hasOwnProperty('milkFullness'))        milkFullness        = p.milkFullness;
			if (p.hasOwnProperty('fullness'))            fullness            = p.fullness;
			if (p.hasOwnProperty('fuckable'))            fuckable            = p.fuckable;
			if (p.hasOwnProperty('nippleCocks'))         nippleCocks         = p.nippleCocks;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}
	}
}
