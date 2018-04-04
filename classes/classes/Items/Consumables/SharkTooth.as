package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.PerkLib;
	
	public class SharkTooth extends Consumable
	{
		
		public function SharkTooth(tiger:Boolean)
		{
			super(tiger ? "TSTooth" : "Shark.T", tiger ? "TSTooth" : "Shark.T", tiger ? "a glowing tiger shark tooth" : "a sharp shark tooth", ConsumableLib.DEFAULT_VALUE, tiger ? "This looks like a normal shark tooth, though with an odd purple glow." : "A glinting white tooth, very sharp and intimidating.");
		}
		
		override public function useItem():Boolean
		{
			sharkTooth(this.id == "TSTooth" ? 1 : 0);
			return false;
		}
		
		public function sharkTooth(type:Number):void
		{
			var tfSource:String = "sharkTooth";
			if (type == 1) tfSource += "-tigershark";
			mutations.initTransformation([2, 2], 2);
			clearOutput();
			if (type == 0) outputText("You have no idea why, but you decide to eat the pointed tooth. To your surprise, it's actually quite brittle, turning into a fishy-tasting dust. You figure it must just be a tablet made to look like a shark's tooth.");
			else if (type == 1) outputText("You have no idea why, but you decide to eat the pointed, glowing tooth. To your surprise, it's actually quite brittle, crumbling into a fishy-tasting dust. Maybe it's just a tablet made to look like a shark's tooth.");
			//STATS
			//Increase strength 1-2 points (Up to 50) (60 for tiger)
			if (((player.str100 < 60 && type == 1) || player.str100 < 50) && rand(3) === 0) {
				dynStats("str", 1 + rand(2));
				outputText("\n\nA painful ripple passes through the muscles of your body.  It takes you a few moments, but you quickly realize you're a little bit stronger now.");
			}
			//Increase Speed 1-3 points (Up to 75) (100 for tigers)
			if (((player.spe100 < 100 && type == 1) || player.spe100 < 75) && rand(3) === 0) {
				dynStats("spe", 1 + rand(3));
				outputText("\n\nShivering without warning, you nearly trip over yourself as you walk.  A few tries later you realize your muscles have become faster.");
			}
			//Reduce sensitivity 1-3 Points (Down to 25 points)
			if (player.sens100 > 25 && rand(1.5) === 0 && changes < changeLimit) {
				dynStats("sen", (-1 - rand(3)));
				outputText("\n\nIt takes a while, but you eventually realize your body has become less sensitive.");
			}
			//Increase Libido 2-4 points (Up to 75 points) (100 for tigers)
			if (((player.lib100 < 100 && type == 1) || player.lib100 < 75) && rand(3) === 0 && changes < changeLimit) {
				dynStats("lib", (1 + rand(3)));
				outputText("\n\nA blush of red works its way across your skin as your sex drive kicks up a notch.");
			}
			//Decrease intellect 1-3 points (Down to 40 points)
			if (player.inte100 > 40 && rand(3) === 0 && changes < changeLimit) {
				dynStats("int", -(1 + rand(3)));
				outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
			}
			//Smexual stuff!
			//-TIGGERSHARK ONLY: Grow a cunt (guaranteed if no gender)
			if (type == 1 && (player.gender == 0 || (!player.hasVagina() && changes < changeLimit && rand(3) === 0))) {
				changes++;
				//(balls)
				if (player.balls > 0) outputText("\n\nAn itch starts behind your " + player.ballsDescriptLight() + ", but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your " + player.sackDescript() + ", and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
				//(dick)
				else if (player.hasCock()) outputText("\n\nAn itch starts on your groin, just below your " + player.multiCockDescriptLight() + ". You pull the manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
				//(neither)
				else outputText("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your " + player.armorName + " to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
				player.createVagina();
				player.setClitLength(.25);
				dynStats("sen", 10);
			}
			//WANG GROWTH - TIGGERSHARK ONLY
			if (type == 1 && (!player.hasCock()) && changes < changeLimit && rand(3) === 0) {
				//Genderless:
				if (!player.hasVagina()) outputText("\n\nYou feel a sudden stabbing pain in your featureless crotch and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of a new human-shaped penis");
				//Female:
				else outputText("\n\nYou feel a sudden stabbing pain just above your " + player.vaginaDescript() + " and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of not only a " + player.vaginaDescript() + ", but a new human-shaped penis");
				if (player.balls == 0) {
					outputText(" and a pair of balls");
					player.balls = 2;
					player.ballSize = 2;
				}
				outputText("!");
				player.createCock(7, 1.4);
				dynStats("lib", 4, "sen", 5, "lus", 20);
				changes++;
			}
			//(Requires the player having two testicles)
			if (type == 1 && (player.balls == 0 || player.balls == 2) && player.hasCock() && changes < changeLimit && rand(3) === 0) {
				if (player.balls == 2) {
					outputText("\n\nYou gasp in shock as a sudden pain racks your abdomen. Within seconds, two more testes drop down into your " + player.sackDescript() + ", your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new quartet of testes.</b>");
					player.balls = 4;
				}
				else if (player.balls == 0) {
					outputText("\n\nYou gasp in shock as a sudden pain racks your abdomen. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new pair of testes.</b>");
					player.balls = 2;
					player.ballSize = 2;
				}
				dynStats("lib", 2, "sen", 3, "lus", 10);
				changes++;
			}
			//-Remove extra breast rows
			if (changes < changeLimit && player.breastRows.length > 1 && rand(3) === 0 && !flags[kFLAGS.HYPER_HAPPY]) {
				mutations.removeExtraBreastRow(tfSource);
			}
			//Neck restore
			if (player.neck.type !== Neck.NORMAL && changes < changeLimit && rand(4) === 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) === 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) mutations.updateOvipositionPerk(tfSource);
			//Transformations:
			//Mouth TF
			if (player.face.type !== Face.SHARK_TEETH && rand(3) === 0 && changes < changeLimit) {
				outputText("\n\n");
				if (player.face.type > Face.HUMAN && player.face.type < Face.SHARK_TEETH) outputText("Your " + player.faceDescript() + " explodes with agony, reshaping into a more human-like visage.  ");
				player.face.type = Face.SHARK_TEETH;
				outputText("You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them!  They even scare you a little.\n(Gain: 'Bite' special attack)");
				changes++;
			}
			//Remove odd eyes
			if (changes < changeLimit && rand(5) === 0 && player.eyes.type !== Eyes.HUMAN) {
				if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) {
					outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
				}
				else {
					outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
					if (player.eyes.type == Eyes.FOUR_SPIDER_EYES || player.eyes.type == Eyes.SPIDER) outputText("  Your arachnid eyes are gone!</b>");
					outputText("  <b>You have normal, humanoid eyes again.</b>");
				}
				player.eyes.type = Eyes.HUMAN;
				player.eyes.count = 2;
				changes++;
			}
			//Tail TF
			if (player.tail.type !== Tail.SHARK && rand(3) === 0 && changes < changeLimit) {
				changes++;
				if (player.tail.type == Tail.NONE) outputText("\n\nJets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your " + player.armorName + " down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.");
				else outputText("\n\nJets of pain shoot down your spine into your tail.  You feel the tail bulging out until it explodes into a large and flexible shark-tail.  You swish it about experimentally, and find it quite easy to control.");
				player.tail.type = Tail.SHARK;
			}
			//Gills TF
			if (player.gills.type !== Gills.FISH && player.tail.type == Tail.SHARK && player.face.type == Face.SHARK_TEETH && changes < changeLimit && rand(3) === 0)
				mutations.updateGills(Gills.FISH);
			//Hair
			if (player.hair.color !== "silver" && rand(4) === 0 && changes < changeLimit) {
				changes++;
				outputText("\n\nYou feel a tingling in your scalp and reach up to your head to investigate. To your surprise, your hair color has changed into a silvery color, just like that of a shark girl!");
				player.hair.color = "silver";
			}
			//Skin
			if (((player.skin.tone !== "rough gray" && player.skin.tone !== "orange and black striped") || !player.hasPlainSkin()) && rand(7) === 0 && changes < changeLimit) {
				outputText("\n\n");
				if (player.isFurryOrScaley()) outputText("Your " + player.skin.desc + " falls out, collecting on the floor and exposing your supple skin underneath.  ");
				else if (player.hasGooSkin()) outputText("Your gooey skin solidifies, thickening up as your body starts to solidify into a more normal form. ");
				else if (type == 0) outputText("Your skin itches and tingles becoming slightly rougher and turning gray.  ");
				if (type == 0) {
					outputText("You abruptly stop moving and gasp sharply as a shudder goes up your entire frame. Your skin begins to shift and morph, growing slightly thicker and changing into a shiny grey color. Your skin now feels oddly rough too, comparable to that of a marine mammal. You smile and run your hands across your new shark skin.");
					player.skin.type = Skin.PLAIN;
					player.skin.desc = "skin";
					player.skin.tone = "rough gray";
					player.underBody.restore();
					player.arms.updateClaws(player.arms.claws.type);
					getGame().rathazul.addMixologyXP(20);
					changes++;
				}
				else {
					outputText("Your skin begins to tingle and itch, before rapidly shifting to a shiny orange color, marked by random black stripes. You take a quick look in a nearby pool of water, to see your skin has morphed in appearance and texture to become more like a tigershark!");
					player.skin.type = Skin.PLAIN;
					player.skin.desc = "skin";
					player.skin.tone = "orange and black striped";
					player.underBody.restore();
					player.arms.updateClaws(player.arms.claws.type);
					kGAMECLASS.rathazul.addMixologyXP(20);
					changes++;
				}
			}
			//FINZ R WINGS
			if ((player.wings.type !== Wings.NONE || player.rearBody.type !== RearBody.SHARK_FIN) && changes < changeLimit && rand(3) === 0) {
				outputText("\n\n");
				if (player.wings.type !== Wings.NONE) outputText("Your wings fold into themselves, merging together with your back.  ");
				outputText("You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your " + player.armorName + " just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your " + player.armorName + " to accommodate your new fin.");
				player.rearBody.type = RearBody.SHARK_FIN;
				player.wings.restore();
				changes++;
			}
			if (changes == 0) {
				outputText("\n\nNothing happened.  Weird.");
			}
			player.refillHunger(5);
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
	}

}