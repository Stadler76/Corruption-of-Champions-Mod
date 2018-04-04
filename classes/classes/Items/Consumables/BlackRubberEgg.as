package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;

	/**
	 * @since March 31, 2018
	 * @author Stadler76
	 */
	public class BlackRubberEgg extends Consumable 
	{
		public static const SMALL:int = 0;
		public static const LARGE:int = 1;

		private var large:Boolean;

		public function BlackRubberEgg(type:int)
		{
			var id:String;
			var shortName:String;
			var longName:String;
			var description:String;
			var value:int;

			large = type === LARGE;

			switch (type) {
				case SMALL:
					id = "BlackEg";
					shortName = "BlackEg";
					longName = "a rubbery black egg";
					description = "This is an oblong egg, not much different from a chicken egg in appearance (save for the color)."
					             +" Something tells you it's more than just food.";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				case LARGE:
					id = "L.BlkEg";
					shortName = "L.BlkEg";
					longName = "a large rubbery black egg";
					description = "This is an oblong egg, not much different from an ostrich egg in appearance (save for the color)."
					             +" Something tells you it's more than just food."
					             +" For all you know, it could turn you into rubber!";
					value = ConsumableLib.DEFAULT_VALUE;
					break;

				default: // Remove this if someone manages to get SonarQQbe to not whine about a missing default ... ~Stadler76
			}

			super(id, shortName, longName, value, description);
		}

		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You devour the egg, momentarily sating your hunger.");
			//Small
			if (!large) {
				//Change skin to normal if not flawless!
				if ((player.skin.adj !== "smooth" && player.skin.adj !== "latex" && player.skin.adj !== "rubber") || player.skin.desc !== "skin") {
					outputText("\n\nYour " + player.skin.desc + " tingles delightfully as it ");
					if (player.hasPlainSkin()) outputText(" loses its blemishes, becoming flawless smooth skin.");
					if (player.hasFur()) outputText(" falls out in clumps, revealing smooth skin underneath.");
					if (player.hasScales()) outputText(" begins dropping to the ground in a pile around you, revealing smooth skin underneath.");
					if (player.hasGooSkin()) outputText(" shifts and changes into flawless smooth skin.");
					player.skin.desc = "skin";
					player.skin.adj = "smooth";
					if (player.skin.tone == "rough gray") player.skin.tone = "gray";
					player.skin.type = Skin.PLAIN;
					player.underBody.restore();
					player.arms.updateClaws(player.arms.claws.type);
				}
				//chance of hair change
				else {
					//If hair isn't rubbery/latex yet
					if (player.hair.color.indexOf("rubbery") == -1 && player.hair.color.indexOf("latex-textured") && player.hair.length !== 0) {
						//if skin is already one...
						if (player.skin.desc == "skin" && player.skin.adj == "rubber") {
							outputText("\n\nYour scalp tingles and your " + player.hairDescript() + " thickens, the strands merging into ");
							outputText(" thick rubbery hair.");
							player.hair.color = "rubbery " + player.hair.color;
							dynStats("cor", 2);
						}
						if (player.skin.desc == "skin" && player.skin.adj == "latex") {
							outputText("\n\nYour scalp tingles and your " + player.hairDescript() + " thickens, the strands merging into ");
							outputText(" shiny latex hair.");
							player.hair.color = "latex-textured " + player.hair.color;
							dynStats("cor", 2);
						}
					}
				}
				player.refillHunger(20);
			}
			//Large
			if (large) {
				//Change skin to latex if smooth.
				if (player.skin.desc == "skin" && player.skin.adj == "smooth") {
					outputText("\n\nYour already flawless smooth skin begins to tingle as it changes again.  It becomes shinier as its texture changes subtly.  You gasp as you touch yourself and realize your skin has become ");
					if (rand(2) === 0) {
						player.skin.desc = "skin";
						player.skin.adj = "latex";
						outputText("a layer of pure latex.  ");
					}
					else {
						player.skin.desc = "skin";
						player.skin.adj = "rubber";
						outputText("a layer of sensitive rubber.  ");
					}
					flags[kFLAGS.PC_KNOWS_ABOUT_BLACK_EGGS] = 1;
					if (player.cor < 66) outputText("You feel like some kind of freak.");
					else outputText("You feel like some kind of sexy " + player.skin.desc + " love-doll.");
					dynStats("spe", -3, "sen", 8, "lus", 10, "cor", 2);
				}
				//Change skin to normal if not flawless!
				if ((player.skin.adj !== "smooth" && player.skin.adj !== "latex" && player.skin.adj !== "rubber") || player.skin.desc !== "skin") {
					outputText("\n\nYour " + player.skin.desc + " tingles delightfully as it ");
					if (player.hasPlainSkin()) outputText(" loses its blemishes, becoming flawless smooth skin.");
					if (player.hasFur()) outputText(" falls out in clumps, revealing smooth skin underneath.");
					if (player.hasScales()) outputText(" begins dropping to the ground in a pile around you, revealing smooth skin underneath.");
					if (player.hasGooSkin()) outputText(" shifts and changes into flawless smooth skin.");
					player.skin.desc = "skin";
					player.skin.adj = "smooth";
					if (player.skin.tone == "rough gray") player.skin.tone = "gray";
					player.skin.type = Skin.PLAIN;
					player.underBody.restore();
					player.arms.updateClaws(player.arms.claws.type);
				}
				//chance of hair change
				else {
					//If hair isn't rubbery/latex yet
					if (player.hair.color.indexOf("rubbery") == -1 && player.hair.color.indexOf("latex-textured") && player.hair.length !== 0) {
						//if skin is already one...
						if (player.skin.adj == "rubber" && player.skin.desc == "skin") {
							outputText("\n\nYour scalp tingles and your " + player.hairDescript() + " thickens, the strands merging into ");
							outputText(" thick rubbery hair.");
							player.hair.color = "rubbery " + player.hair.color;
							dynStats("cor", 2);
						}
						if (player.skin.adj == "latex" && player.skin.desc == "skin") {
							outputText("\n\nYour scalp tingles and your " + player.hairDescript() + " thickens, the strands merging into ");
							outputText(" shiny latex hair.");
							player.hair.color = "latex-textured " + player.hair.color;
							dynStats("cor", 2);
						}
					}
				}
				player.refillHunger(60);
			}

			return false;
		}
	}
}
