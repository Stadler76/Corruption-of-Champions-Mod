package classes.Scenes.Dungeons.Factory
{
	import classes.*;
	import classes.BodyParts.*;
	import classes.Scenes.Dungeons.Factory;
	import classes.internals.*;

	public class OmnibusOverseer extends Monster
	{
		public var factory:Factory = new Factory()
		private var temp:Number = 0;
		
		override public function defeated(hpVictory:Boolean):void
		{
			factory.omnibusOverseer.winAgainstOmnibus();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(game.combat.endLustLoss);
			} else {
				factory.omnibusOverseer.doLossOmnibus();
			}
		}
		
		private function lustAura():void {
			outputText("The demoness blinks her eyes closed and knits her eyebrows in concentration.  The red orbs open wide and she smiles, licking her lips.   The air around her grows warmer, and muskier, as if her presence has saturated it with lust.");
			if (hasStatusEffect(StatusEffects.LustAura)) {
				outputText("  Your eyes cross with unexpected feelings as the taste of desire in the air worms its way into you.  The intense aura quickly subsides, but it's already done its job.");
				game.dynStats("lus", (8 + int(player.lib / 20 + player.cor / 25)));
			}
			else {
				createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
			}
			game.combat.combatRoundOver();
		}
		
		private function milkAttack():void {
			if (rand(2) == 0)
				outputText("The demoness grips her sizable breasts and squeezes, spraying milk at you.\n");
			else outputText("Your foe curls up to pinch her nipples, tugging hard and squirting milk towards you.\n");
			if ((player.spe > 50 && rand(4) == 0) || (player.findPerk(PerkLib.Evade) >= 0 && rand(3) == 0) || (player.findPerk(PerkLib.Misdirection) >= 0 && rand(4) == 0 && player.armorName == "red, high-society bodysuit")) {
				outputText("You sidestep the gushing fluids.");
			}
			//You didn't dodge
			else {
				if (rand(2) == 0) {
					outputText("The milk splatters across your face and chest, soaking you with demonic cream.  Some managed to get into your mouth, and you swallow without thinking.  It makes you tingle with warmth.  ");
				}
				else {
					outputText("The milk splashes into your " + player.armorName + ", soaking you effectively.  ");
					if (player.cocks.length > 0) {
						outputText("Your " + player.cockDescript(0) + " gets hard as the milk lubricates and stimulates it.  ");
						game.dynStats("lus", 5);
					}
					if (player.vaginas.length > 0) {
						outputText("You rub your thighs together as the milk slides between your pussy lips, stimulating you far more than it should.  ");
						game.dynStats("lus", 5);
					}
				}
				player.takeLustDamage(7 + player.sens / 20, true);
				if (player.biggestLactation() > 1) outputText("Milk dribbles from your " + player.allBreastsDescript() + " in sympathy.");
			}
			game.combat.combatRoundOver();
		}
		
		public function OmnibusOverseer()
		{
			this.a = "the ";
			this.short = "Omnibus Overseer";
			this.imageName = "omnibusoverseer";
			this.long = "The 'woman' before you is clothed only in a single strip of fabric that wraps around her bountiful chest.  She has striking red eyes that contrast visibly with her blue skin and dark make-up.  Shiny black gloss encapsulates her kissable bubbly black lips.  Her most striking feature is her crotch, which appears neither male nor female.  She has a puffy wet vulva, but a cock-shaped protrusion sprouts from where a clit should be.";
			this.race = "Demon";
			// this.plural = false;
			this.createCock(10,1.5);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hips.rating = Hips.RATING_AMPLE+2;
			this.butt.rating = Butt.RATING_TIGHT;
			this.lowerBody.type = LowerBody.DEMONIC_HIGH_HEELS;
			this.skin.tone = "light purple";
			this.hair.color = "purple";
			this.hair.length = 42;
			initStrTouSpeInte(65, 45, 45, 85);
			initLibSensCor(80, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 15;
			this.bonusHP = 200;
			this.lust = 20;
			this.lustVuln = 0.75;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 8;
			this.gems = rand(25) + 10;
			this.additionalXP = 75;
			this.drop = new WeightedDrop(null, 1);
			this.special1 = lustAura;
			this.special2 = milkAttack;
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.tail.type = Tail.DEMONIC;
			this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
