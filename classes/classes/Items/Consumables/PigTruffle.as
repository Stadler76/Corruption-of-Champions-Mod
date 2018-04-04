package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.PerkLib;

	public class PigTruffle extends Consumable
	{
		
		public function PigTruffle(boar:Boolean) 
		{
			super(boar ? "BoarTru" : "PigTruf", boar ? "BoarTruffle" : "PigTruffle", boar ? "a boar truffle" : "a pigtail truffle", ConsumableLib.DEFAULT_VALUE, boar ? "It’s clear where this fungus gets its name. A small, curly sprig resembling a pig’s tail can be seen jutting out of it. Now that it’s been enhanced by Lumi, it’s larger and fuzzier than it was before, almost like a peach." : "It’s clear where this fungus gets its name. A small, curly sprig resembling a pig’s tail can be seen jutting out of it.");
		}

		override public function useItem():Boolean
		{
			pigTruffle(this.id == "BoarTru");
			return false;
		}
		
		public function pigTruffle(boar:Boolean):void
		{
			var tfSource:String = "pigTruffle";
			if (boar) tfSource += "-boar";
			var temp:int = 0;
			var x:int = 0;
			mutations.initTransformation([2, 2, 3], boar ? 2 : 1);
			outputText("You take a bite into the pigtail truffle. It oddly tastes like bacon. You eventually finish eating. ");
			player.refillHunger(20);
			//-----------------------
			// SIZE MODIFICATIONS
			//-----------------------
			//Increase thickness
			if (rand(3) === 0 && changes < changeLimit && player.thickness < 75) {
				outputText(player.modThickness(75, 3));
				changes++;
			}
			//Decrease muscle tone
			if (rand(3) === 0 && changes < changeLimit && player.gender >= 2 && player.tone > 20) {
				outputText(player.modTone(20, 4));
				changes++;
			}
			//Increase hip rating
			if (rand(3) === 0 && changes < changeLimit && player.gender >= 2 && player.hips.rating < 15) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening " + player.hipDescript() + ". The change is subtle, but they're definitely broader.");
				player.hips.rating++;
				changes++;
			}
			//Increase ass rating
			if (rand(3) === 0 && changes < changeLimit && player.butt.rating < 12) {
				outputText("\n\nWhen you stand back, up your [ass] jiggles with a good bit of extra weight.");
				player.butt.rating++;
				changes++;
			}
			//Increase ball size if you have balls.
			if (rand(3) === 0 && changes < changeLimit && player.balls > 0 && player.ballSize < 4) {
				if (player.ballSize < 3)
					outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin. You pause to examine the changes and your roving fingers discover your " + (player.balls == 4 ? "quartette" : "duo") + " of [balls] have grown larger than a human’s.");
				else
					outputText("\n\nA sudden onset of heat envelops your groin, focusing on your ballsack. Walking becomes difficult as you discover your " + (player.balls == 4 ? "quartette" : "duo") + " of testicles have enlarged again.");
				player.ballSize++;
				changes++;
			}
			//Neck restore
			if (player.neck.type !== Neck.NORMAL && changes < changeLimit && rand(4) === 0) {
				mutations.restoreNeck(tfSource);
			}
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) === 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) mutations.updateOvipositionPerk(tfSource);
			//-----------------------
			// TRANSFORMATIONS
			//-----------------------
			//Gain pig cock, independent of other pig TFs.
			if (rand(4) === 0 && changes < changeLimit && player.cocks.length > 0 && player.cocks[0].cockType !== CockTypesEnum.PIG) {
				if (player.cocks.length == 1) { //Single cock
					outputText("\n\nYou feel an uncomfortable pinching sensation in your [cock]. " + player.clothedOrNakedLower("You pull open your [armor]", "You look down at your exposed groin") + ", watching as it warps and changes. As the transformation completes, you’re left with a shiny, pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>");
					player.cocks[0].cockType = CockTypesEnum.PIG;
				}
				else { //Multiple cocks
					outputText("\n\nYou feel an uncomfortable pinching sensation in one of your cocks. You pull open your [armor], watching as it warps and changes. As the transformation completes, you’re left with a shiny pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>");
					player.cocks[rand(player.cocks.length+1)].cockType = CockTypesEnum.PIG;
				}
				changes++;
			}
			//Gain pig ears!
			if (rand(boar ? 3 : 4) === 0 && changes < changeLimit && player.ears.type !== Ears.PIG) {
				outputText("\n\nYou feel a pressure on your ears as they begin to reshape. Once the changes finish, you flick them about experimentally, <b>and you’re left with pointed, floppy pig ears.</b>");
				player.ears.type = Ears.PIG;
				changes++;
			}
			//Gain pig tail if you already have pig ears!
			if (rand(boar ? 2 : 3) === 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tail.type !== Tail.PIG) {
				if (player.tail.type > 0) //If you have non-pig tail.
					outputText("\n\nYou feel a pinching sensation in your [tail] as it begins to warp in change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b>");
				else //If you don't have a tail. 
					outputText("\n\nYou feel a tug at the base of your spine as it lengthens ever so slightly. Looking over your shoulder, <b>you find that you have sprouted a small, curly pig tail.</b>");
				player.tail.type = Tail.PIG;
				changes++;
			}
			//Gain pig tail even when centaur, needs pig ears.
			if (rand(boar ? 2 : 3) === 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tail.type !== Tail.PIG && player.isTaur() && (player.lowerBody.type == LowerBody.HOOFED || player.lowerBody.type == LowerBody.PONY)) {
				outputText("\n\nThere is a tingling in your [tail] as it begins to warp and change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b> This new, mismatched tail looks a bit odd on your horse lower body.");
				player.tail.type = Tail.PIG;
				changes++;
			}
			//Turn your lower body into pig legs if you have pig ears and tail.
			if (rand(boar ? 3 : 4) === 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tail.type == Tail.PIG && player.lowerBody.type !== LowerBody.CLOVEN_HOOFED) {
				if (player.isTaur()) //Centaur
					outputText("\n\nYou scream in agony as a horrible pain racks your entire bestial lower half. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the animal's lower body. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have pig legs!</b>");
				else if (player.lowerBody.type == LowerBody.NAGA) //Naga
					outputText("\n\nYou scream in agony as a horrible pain racks the entire length of your snake-like coils. Unable to take it anymore, you pass out. When you wake up, you’re shocked to find that you no longer have the lower body of a snake. Instead, you only have two legs. They are digitigrade and end in cloven hooves. <b>You now have pig legs!</b>");
				else //Bipedal
					outputText("\n\nYou scream in agony as the bones in your legs break and rearrange. Once the pain subsides, you inspect your legs, finding that they are digitigrade and ending in cloven hooves. <b>You now have pig legs!</b>");
				player.lowerBody.type = LowerBody.CLOVEN_HOOFED;
				player.lowerBody.legCount = 2;
				changes++;
			}
			//Gain pig face when you have the first three pig TFs.
			if (rand(boar ? 2 : 3) === 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tail.type == Tail.PIG && player.lowerBody.type == LowerBody.CLOVEN_HOOFED && (player.face.type !== Face.PIG && player.face.type !== Face.BOAR)) {
				outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new pig face!</b>");
				player.face.type = Face.PIG;
				changes++;
			}
			//Gain boar face if you have pig face.
			if (rand(3) === 0 && changes < changeLimit && player.ears.type == Ears.PIG && player.tail.type == Tail.PIG && player.lowerBody.type == LowerBody.CLOVEN_HOOFED && player.face.type == Face.PIG) {
				outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. Your bottom teeth ache as well. What’s happening to you? As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new tusky boar face!</b>");
				player.face.type = Face.BOAR;
				changes++;
			}
			//Change skin colour
			if (rand(boar ? 3 : 4) === 0 && changes < changeLimit) {
				var skinChoose:int = rand(3);
				var skinToBeChosen:String = "pink";
				if (boar) {
					if (skinChoose == 0) skinToBeChosen = "dark brown";
					else skinToBeChosen = "brown";
				}
				else {
					if (skinChoose == 0) skinToBeChosen = "pink";
					else if (skinChoose == 1) skinToBeChosen = "tan";
					else skinToBeChosen = "sable";
				}
				outputText("\n\nYour skin tingles ever so slightly as you skin’s color changes before your eyes. As the tingling diminishes, you find that your skin has turned " + skinToBeChosen + ".");
				player.skin.tone = skinToBeChosen;
				player.arms.updateClaws(player.arms.claws.type);
				getGame().rathazul.addMixologyXP(20);
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nOddly, you do not feel any changes. Perhaps you're lucky? Or not.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
	}

}