package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.Items.Undergarments.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class UndergarmentLib 
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const TYPE_UPPERWEAR:int = 0;
		public static const TYPE_LOWERWEAR:int = 1;
		public static const TYPE_FULLWEAR:int  = 2;
		
		//public static const COMFORTABLE_UNDERCLOTHES:Undergarment = new ComfortableUnderclothes();
		public static const NOTHING:Undergarment = new Nothing();
		
		//Upper
		public const C_BRA  :Undergarment = new Undergarment("C. Bra ", "C. Bra", "comfortable bra", "a pair of comfortable bra", TYPE_UPPERWEAR, DEFAULT_VALUE, "A generic pair of bra.");
		public const DS_BRA :Undergarment = new Undergarment("DS. Bra", "D.Scale Bra", "dragonscale bra", "a pair of dragonscale bra", TYPE_UPPERWEAR, 360, "This bra appears to be made of dragon scale. It's held together with leather straps for flexibility. Great for those on the primal side!");
		public const LTX_BRA:Undergarment = new Undergarment("Ltx.Bra", "Latex Bra", "latex bra", "a pair of latex bra", TYPE_UPPERWEAR, 250, "This bra is black and shiny, obviously made of latex. It's designed to fit snugly against your breasts.");
		public const SS_BRA :Undergarment = new Undergarment("SS. Bra", "S.Silk Bra", "spider-silk bra", "a pair of spider-silk bra", TYPE_UPPERWEAR, 1000, "This bra looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk.");
		public const EBNVEST:Undergarment = new Undergarment("EW Vest", "EW Vest", "Ebonweave vest", "an Ebonweave vest", TYPE_UPPERWEAR, 900, "This vest is made of ebonweave, created using refined Ebonbloom petals. Elastic, form-fitting, and somewhat transparent, this comfortable vest will display your curves, masculine or feminine.");
		public const EBNCRST:Undergarment = new Undergarment("EW Crst", "EW Corset", "Ebonweave corset", "an Ebonweave corset", TYPE_UPPERWEAR, 900, "This corset is made of ebonweave, created using refined Ebonbloom petals. The ebonweave is elastic, making the corset surprisingly comfortable to wear, while displaying your bust down to the most subtle curves.");
		
		//Lower
		public const C_LOIN :Undergarment = new Undergarment("C. Loin", "C. Loin", "comfortable loincloth", "a pair of comfortable loincloth", TYPE_LOWERWEAR, DEFAULT_VALUE, "A generic pair of loincloth.", "NagaWearable");
		public const C_PANTY:Undergarment = new Undergarment("C.Panty", "C.Panties", "comfortable panties", "a pair of comfortable panties", TYPE_LOWERWEAR, DEFAULT_VALUE, "A generic pair of panties.");
		public const DS_LOIN:Undergarment = new Undergarment("DS.Loin", "D.Scale Loin", "dragonscale loincloth", "a dragonscale loincloth", TYPE_LOWERWEAR, 360, "This loincloth appears to be made of dragonscale and held together with a leather strap that goes around your waist. Great for those on the wild side!", "NagaWearable");
		public const DSTHONG:Undergarment = new Undergarment("DSPanty", "D.Scale Thong", "dragonscale thong", "a pair of dragonscale thong", TYPE_LOWERWEAR, 360, "This thong appears to be made of dragonscale and held together with a leather strap that goes around your waist. Great for those on the wild side!");
		public const FUNDOSH:Undergarment = new Undergarment("Fundosh", "Fundoshi", "fundoshi", "a fundoshi", TYPE_LOWERWEAR, 20, "This Japanese-styled undergarment resembles a cross between a thong and a loincloth.");
		public const FURLOIN:Undergarment = new Undergarment("FurLoin", "FurLoin", "fur loincloth", "a front and back set of loincloths", TYPE_LOWERWEAR, DEFAULT_VALUE, "A pair of loincloths to cover your crotch and butt.  Typically worn by people named 'Conan'. ", "NagaWearable");
		public const GARTERS:Undergarment = new Undergarment("Garters", "Garters", "stockings and garters", "a pair of stockings and garters", TYPE_LOWERWEAR, DEFAULT_VALUE, "These pairs of stockings, garters and lingerie are perfect for seducing your partner!");
		public const LTXSHRT:Undergarment = new Undergarment("LtxShrt", "LatexShorts", "latex shorts", "a pair of latex shorts", TYPE_LOWERWEAR, 300, "These shorts are black and shiny, obviously made of latex. It's designed to fit snugly against your form.");
		public const LTXTHNG:Undergarment = new Undergarment("LtxThng", "LatexThong", "latex thong", "a pair of latex thong", TYPE_LOWERWEAR, 300, "This thong is black and shiny, obviously made of latex. It's designed to fit snugly against your form.");
		public const SS_LOIN:Undergarment = new Undergarment("SS.Loin", "S.Silk Loin", "spider-silk loincloth", "a spider-silk loincloth", TYPE_LOWERWEAR, 1000, "This loincloth looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk.", "NagaWearable");
		public const SSPANTY:Undergarment = new Undergarment("SSPanty", "S.Silk Panty", "spider-silk panties", "a pair of spider-silk panties", TYPE_LOWERWEAR, 1000, "These panties look incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk.");
		public const EBNJOCK:Undergarment = new Undergarment("EWStrap", "Ebon Jock", "Ebonweave jockstrap", "an Ebonweave jockstrap", TYPE_LOWERWEAR, 900, "This jock is ebonweave, made of refined Ebonbloom petals. It’s comfortable and elastic, providing support while containing assets of any size.");
		public const EBNTHNG:Undergarment = new Undergarment("EWThong", "Ebon Thong", "Ebonweave thong", "an Ebonweave thong", TYPE_LOWERWEAR, 900, "This thong is made of ebonweave, designed to fit snugly around your form. Thanks to alchemic treatments, it’s elastic enough to hold assets of any size.");
		public const EBNCLTH:Undergarment = new Undergarment("EWCloth", "Ebon Loin", "Ebonweave loincloth", "an Ebonweave loincloth", TYPE_LOWERWEAR, 900, "This loincloth is made of ebonweave, designed to fit snugly around your form. Thanks to alchemic treatments, it’s elastic enough to hold assets of any size.", "NagaWearable");
		public const EBNRJCK:Undergarment = new UndergarmentWithPerk("RnStrap", "Rune Jock", "runed Ebonweave jockstrap", "a runed Ebonweave jockstrap", TYPE_LOWERWEAR, 1200, "This jock is ebonweave, made of refined Ebonbloom petals. Adorning the pouch is a rune of lust, glowing with dark magic.",
				PerkLib.WellspringOfLust,0,0,0,0,"At the beginning of combat, lust raises to black magic threshold if lust is below black magic threshold.");
		public const EBNRTNG:Undergarment = new UndergarmentWithPerk("RnThong", "Rune Thong", "runed Ebonweave thong", "a runed Ebonweave thong", TYPE_LOWERWEAR, 1200, "This thong is made of ebonweave, designed to fit snugly around your form. Adorning the front is a rune of lust, glowing with dark magic.",
				PerkLib.WellspringOfLust,0,0,0,0,"At the beginning of combat, lust raises to black magic threshold if lust is below black magic threshold.");
		public const EBNRLNC:Undergarment = new UndergarmentWithPerk("RnCloth", "Rune Loin", "runed Ebonweave loincloth", "a runed Ebonweave loincloth", TYPE_LOWERWEAR, 1200, "This loincloth is made of ebonweave, designed to fit snugly around your form. Adorning the front is a rune of lust, glowing with dark magic.",
				PerkLib.WellspringOfLust,0,0,0,0,"At the beginning of combat, lust raises to black magic threshold if lust is below black magic threshold.","NagaWearable");
		
		public function UndergarmentLib() 
		{
		}
		
	}

}
