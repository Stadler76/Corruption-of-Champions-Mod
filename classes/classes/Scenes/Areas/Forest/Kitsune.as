package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.BodyParts.*;
	import classes.BodyParts.Butt;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;

	public class Kitsune extends BaseKitsune
	{
		public function Kitsune(hairColor:String)
		{
			init(hairColor);
		}
		
		private function init(hairColor:String):void
		{
			if (rand(3) != 2) game.flags[kFLAGS.redheadIsFuta] = 1;
			this.a = "a ";
			this.short = "kitsune";
			this.imageName = "kitsune";
			this.long = "A kitsune stands in front of you, about five and a half feet tall.  She has a head of " + ({
						"blonde": "long flaxen",
						"black": "lustrous, ass-length black",
						"red": "unkempt, shoulder-length reddish"
					}[hairColor]) +
							" hair.  She appears mostly human, except for a pair of large, furry ears poking through her hair and six luxurious silky tails swaying in the air behind her.  Her robes are revealing but comfortable-looking, hugging her voluptuous curves and exposing large swaths of tattooed skin.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely, and each movement brings a pleasant jiggle from her plump backside and large breasts.";
			this.race = "Kitsune";

			if (hairColor=="red" && game.flags[kFLAGS.redheadIsFuta] == 1) {
				this.createCock(rand(13) + 14,1.5 + rand(20)/2,CockTypesEnum.HUMAN);
				this.balls = 2;
				this.ballSize = 2 + rand(13);
				this.cumMultiplier = 1.5;
				this.hoursSinceCum = ballSize * 10;
			}
			this.createVagina(false, Vagina.WETNESS_SLICK, Vagina.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = Ass.LOOSENESS_TIGHT;
			this.ass.analWetness = Ass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = rand(24) + 60;
			this.hips.rating = Hips.RATING_AMPLE;
			this.butt.rating = Butt.RATING_AVERAGE+1;
			this.skin.tone = "pale";
			this.hair.color = hairColor;
			this.hair.length = 13 + rand(20);
			initStrTouSpeInte(35, 45, 90, 95);
			initLibSensCor(60, 65, 45);
			this.weaponName = "claws";
			this.weaponVerb="punch";
			this.armorName = "skin";
			this.bonusHP = 120;
			this.lust = 20;
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 6;
			this.gems = rand(10) + 10;
			this.drop = new WeightedDrop(consumables.FOXJEWL, 1);
			this.tail.type = Tail.FOX;
			checkMonster();
		}

		// Combat Abilities:
		// the kitsune are an almost purely magical mob, relying mainly on tease attacks and spells that raise lust.
		//Entwine:
		private function kitsuneEntwine():void
		{
			outputText("The kitsune closes in on you with a mischievous glint in her eyes.  You raise your guard, keeping your eyes trained on her to ensure that she doesn't try to pull anything.  Suddenly, you feel something coiling around your " + player.leg() + ", and let out a yelp as you are suddenly lifted into the air, entangled in the kitsune's tails!");
			outputText("\n\nYour limbs are bound tightly while coils of delightfully soft fur caress you on all sides.  You can do little besides struggle against your furry bonds as the constant writhing of her tails sends shudders flying up and down your spine.");
			createStatusEffect(StatusEffects.PCTailTangle, 0, 0, 0, 0);
			var lustDmg:int = 10 + player.sens / 8;
			player.takeLustDamage(lustDmg, true);
			combatRoundOver();
		}

		//Struggle - event 5077 in combat.as
		public function kitsuneStruggle():void
		{
			clearOutput();
			//Struggle:
			outputText("You struggle against the kitsune's tails with all your might, desperately trying to free yourself before she has her way with you.");
			//Success
			if (rand(20) + player.str / 20 + statusEffectv1(StatusEffects.PCTailTangle) >= 12) {
				outputText("  Summoning up reserves of strength you didn't know you had, you wrench yourself free of her tails, pushing her away.\n\n");
				removeStatusEffect(StatusEffects.PCTailTangle);
				doAI();
			}
			//Failure - +5-10 LUST
			else {
				outputText("  Despite your valiant efforts, your wriggling only serves to get you deeper entangled in the fluffy tails, eliciting an amused giggle from the kitsune.");
				outputText("\n\nShe licks her lips, running her hands along you wherever she can find exposed flesh.  Her fingertips leave small trails of dazzling blue that make you flush with lust - you must escape her grasp soon or else you will be like putty in her hands!");
				var lustDmg:int = 5 + player.sens / 10;
				player.takeLustDamage(lustDmg, true);
				addStatusValue(StatusEffects.PCTailTangle, 1, 3);
				combatRoundOver();
			}
		}

		public function kitsuneWait():void
		{
			clearOutput();
			outputText("Happily, you slump deeper into the fluffy tails, eliciting an amused giggle from the kitsune.");
			if (game.silly()) outputText("  You're so glad you got to touch fluffy tail.");
			outputText("\n\nShe licks her lips, running her hands along you wherever she can find exposed flesh.  Her fingertips leave small trails of dazzling blue that make you flush with lust - you must escape her grasp soon or else you will be like putty in her hands!");
			var lustDmg:int = 5 + player.sens / 10;
			player.takeLustDamage(lustDmg, true);
			combatRoundOver();
		}

		//Fox Fire: - Low piercing damage, +10-15 LUST
		private function foxFireAttack():void
		{
			outputText("The kitsune makes a small circle in the air with her fingers, conjuring up a pale blue flame into her palm with the sound of flint striking against steel.  Pursing her lips, she blows it toward you with a kiss.");
			outputText("\n\nThe flames burn furiously, but leave you with an incredibly pleasant tingling sensation all over your body.  Your skin flushes with excitement, and you can feel blood rushing to your extremities, making you shudder with pleasure. ");
			var damage:int = 5 + rand(20);
			damage = player.takeDamage(damage, true);
			game.dynStats("lus", 15 + player.sens / 10);
			combatRoundOver();
		}

//Illusion: - Raises enemy evasion, but can be resisted.
//Factors affecting resist: INT (1% per point, max 70%), "Whispered" perk (20% flat bonus), "Religious" background and < 20 corruption (20% bonus at 0, losing 1% per point of corruption.)
//Success:
		private function illusionKitsuneAttack():void
		{
			outputText("You struggle to keep your eyes on the kitsune, ghostly laughter echoing all around you as you turn to and fro, trying to track her movements.  It almost seems like the edges of reality are blurring around her, severely distorting your perceptions and making it hard to follow her.  It's going to be much harder to hit her if she keeps this up!");
			//Resist: - successfully resisting deals small health & lust damage to kitsune
			var resist:int = calculateAttackResist();
			
			if (rand(100) < resist) {
				outputText("\n\nThe kitsune seems to melt away before your eyes for a moment, as though the edges of reality are blurring around her.  You tighten your focus, keeping your eyes trained on her, and she suddenly reels in pain, clutching her forehead as she is thrust back into view.  She lets out a frustrated huff of disappointment, realizing that you have resisted her illusions.");
			}
			else {
				createStatusEffect(StatusEffects.Illusion, 0, 0, 0, 0);
				spe += 20;
			}
			combatRoundOver();
		}

//Tease Texts:
		private function kitSuneTeases():void
		{
			var select:int = rand(3);
			if (hair.color == "red" && rand(2) == 0) select = 3;
			if (select == 0) outputText("You rub your eyes, suddenly seeing triple as you find yourself in the midst of a crowd of kitsune doppelgangers.  They run their hands all over you, teasing and doting on you as their tails caress every inch of your body.  Taken by surprise, you forget to fight back until they have already dispersed, blending back into a single fox-woman.");
			else if (select == 1) outputText("Bending forward, the kitsune runs her hands down over her breasts, jiggling them enticingly and squeezing them together.  Hooking a finger in her robes, she slides it down, tugging them aside until her nipples are just barely covered, and with a teasing smirk, pulls them back up, leaving you wanting.");
			else if (select == 2) outputText("Turning her back to you, the kitsune fans out her tails, peering back as she lifts the hem of her robe to expose her plump hindquarters.  Her tails continually shift and twist, blocking your view, but it only serves to make you want it even <i>more</i>, licking your lips in anticipation.");
			//Redhead only:
			else outputText("The kitsune sways her hips enticingly as she appears in front of you abruptly, rubbing up against your side.  Her teasing caresses make you shiver with arousal, and you can feel something thick and warm pressing against your [hips].  She gives you a wry grin as she breaks away from you, sporting an obvious tent in her robes.  \"<i>Just you wait...</i>\"");
			var lustDmg:int = 5 + player.sens / 7;
			player.takeLustDamage(lustDmg, true);
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			var moves:Array = [foxFireAttack, foxFireAttack, kitSuneTeases, kitSuneTeases];
			if (!player.hasStatusEffect(StatusEffects.Sealed)) moves.push(kitsuneSealAttack);
			if (!player.hasStatusEffect(StatusEffects.Sealed)) moves.push(kitsuneSealAttack);
			if (!hasStatusEffect(StatusEffects.PCTailTangle)) moves.push(kitsuneEntwine);
			if (!hasStatusEffect(StatusEffects.Illusion)) moves.push(illusionKitsuneAttack);
			moves[rand(moves.length)]();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.forest.kitsuneScene.defeatTheKitsunes();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe kitsune recoils before running off, no longer interested in you...");
				game.combat.cleanupAfterCombat();
			} else {
				game.forest.kitsuneScene.loseToKitsunes();
			}
		}
	}
}
