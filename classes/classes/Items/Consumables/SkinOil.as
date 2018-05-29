package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.internals.Utils;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	/**
	 * Skin oils, courtesy of Foxxling.
	 * @author Kitteh6660
	 */
	public class SkinOil extends Consumable 
	{
		private var _color:String;
		
		public function SkinOil(id:String, color:String) 
		{
			this._color = color.toLowerCase();
			var shortName:String = color + " Oil";
			var longName:String = "a bottle of " + this._color + " oil"
			var value:int = ConsumableLib.DEFAULT_VALUE;
			var description:String = "A small glass bottle filled with a smooth clear liquid. A label across the front says, \"" + color + " Skin Oil.\""
			super(id, shortName, longName, value, description);
		}
		
		override public function useItem():Boolean {
			if (!game.player.hasUnderBody() && !game.player.wings.canOil()) {
				oilSkin();
				return true;
			}

			clearOutput();
			if (game.player.hasUnderBody()) {
				outputText("The skin on your underbody is different from the rest. ");
			}
			outputText("Where do you want to apply the " + _color + " skin oil?");

			kGAMECLASS.output.menu();
			kGAMECLASS.output.addButton(0, "Body", oilSkin);
			if (game.player.hasUnderBody()) {
				kGAMECLASS.output.addButton(1, "Underbody", oilUnderBodySkin);
			} else {
				kGAMECLASS.output.addButtonDisabled(1, "Underbody", "You have no special underbody!");
			}
			if (game.player.wings.type === Wings.NONE) {
				outputText("\n\nYou have no wings.");
				kGAMECLASS.output.addButtonDisabled(2, "Wings", "You have no wings.");
			} else if (game.player.wings.canOil()) {
				outputText("\n\nYour wings have [wingColor] [wingColorDesc].");
				if (!game.player.wings.hasOilColor(_color))
					kGAMECLASS.output.addButton(2, "Wings", oilWings).hint("Apply oil to your wings' " + game.player.wings.getColorDesc(BaseBodyPart.COLOR_ID_MAIN) + ".");
				else
					kGAMECLASS.output.addButtonDisabled(2, "Wings", "Your wings' " + game.player.wings.getColorDesc(BaseBodyPart.COLOR_ID_MAIN) + " already are " + _color + " colored!");
			} else {
				outputText("\n\nYour wings can't be oiled.");
				kGAMECLASS.output.addButtonDisabled(2, "Wings", "Your wings can't be oiled!");
			}
			if (game.player.wings.type === Wings.NONE) {
				outputText("\n\nYou have no wings.");
				kGAMECLASS.output.addButtonDisabled(3, "Wings 2", "You have no wings.");
			} else if (game.player.wings.canOil2()) {
				outputText("\n\nYour wings have [wingColor2] [wingColor2Desc].");
				if (!game.player.wings.hasOil2Color(_color))
					kGAMECLASS.output.addButton(3, "Wings 2", oil2Wings).hint("Apply oil to your wings' " + game.player.wings.getColorDesc(BaseBodyPart.COLOR_ID_2ND) + ".");
				else
					kGAMECLASS.output.addButtonDisabled(3, "Wings 2", "Your wings' " + game.player.wings.getColorDesc(BaseBodyPart.COLOR_ID_2ND) + " already are " + _color + " colored!");
			} else {
				kGAMECLASS.output.addButtonDisabled(3, "Wings 2", "Your wings have no secondary color to apply skin oil to!");
			}
			kGAMECLASS.output.addButton(4, "Nevermind", oilCancel);
			return true;
		}

		public function oilSkin():void {
			if (game.player.skin.tone == _color) {
				outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Once you’ve finished you feel rejuvenated.");
				game.player.changeFatigue(-10);
			}
			else {
				if (!game.player.hasGooSkin()) {
					game.player.skin.tone = _color;
					game.player.arms.updateClaws(game.player.arms.claws.type);
				}
				switch (game.player.skin.type) {
					case Skin.PLAIN: //Plain
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest] your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
						break;
					case Skin.FUR: //Fur
						outputText("" + game.player.clothedOrNaked("Once you’ve disrobed you take the oil and", "You take the oil and") + " begin massaging it into your skin despite yourself being covered with fur. Once you’ve finished... nothing happens. Then your skin begins to tingle and soon you part your fur to reveal " + _color + " skin.");
						break;
					case Skin.LIZARD_SCALES: //Lizard scales
					case Skin.DRAGON_SCALES: //Dragon scales
					case Skin.FISH_SCALES:   //Fish scales
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest] your scaly skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
						break;
					case Skin.GOO: //Goo
						outputText("You take the oil and pour the contents into your skin. The clear liquid dissolves, leaving your gooey skin unchanged. You do feel a little less thirsty though.");
						game.player.slimeFeed();
						break;
					default:
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest] your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
				}
			}
			game.inventory.itemGoNext();
		}

		public function oilUnderBodySkin():void {
			if (game.player.underBody.skin.tone == _color) {
				outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your underbody. Once you’ve finished you feel rejuvenated.");
				game.player.changeFatigue(-10);
			}
			else {
				if (!game.player.hasGooSkin()) {
					game.player.underBody.skin.tone = _color;
				}
				switch (game.player.underBody.skin.type) {
					case Skin.PLAIN: //Plain
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your underbody. Even before you’ve covered your [chest] your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin on your underbody.");
						break;
					case Skin.FUR: //Fur
						outputText("" + game.player.clothedOrNaked("Once you’ve disrobed you take the oil and", "You take the oil and") + " begin massaging it into the skin on your underbody despite yourself being covered with fur. Once you’ve finished... nothing happens. Then your skin begins to tingle and soon you part your fur on your [chest] to reveal " + _color + " skin.");
						break;
					case Skin.LIZARD_SCALES: //Lizard scales
					case Skin.DRAGON_SCALES: //Dragon scales
					case Skin.FISH_SCALES:   //Fish scales
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your underbody. Even before you’ve covered your [chest] your scaly skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin on your underbody.");
						break;
					case Skin.GOO: //Goo
						outputText("You take the oil and pour the contents into your skin. The clear liquid dissolves, leaving your gooey skin unchanged. You do feel a little less thirsty though.");
						game.player.slimeFeed();
						break;
					default:
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your underbody. Even before you’ve covered your [chest] your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin on your underbody.");
				}
			}
			game.inventory.itemGoNext();
		}

		private function oilWings():void
		{
			clearOutput();
			outputText("You rub the oil into the [wingColorDesc] of your [wings].  ");
			game.player.wings.applyOil(_color);
			outputText("Your wings now have [wingColor] [wingColorDesc].");
			game.inventory.itemGoNext();
		}

		private function oil2Wings():void
		{
			clearOutput();
			outputText("You rub the oil into the [wingColor2Desc] of your [wings].  ");
			game.player.wings.applyOil2(_color);
			outputText("Your wings now have [wingColor2] [wingColor2Desc].");
			game.inventory.itemGoNext();
		}

		private function oilCancel():void {
			clearOutput();
			outputText("You put the skin oil away.\n\n");
			game.inventory.returnItemToInventory(this);
		}
	}
}