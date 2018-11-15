package classes.Scenes.Areas.Mountain {
	import classes.*;
	import classes.BodyParts.*;
	import classes.internals.*;
	/* @author Fake-Name */
	public class Minotaur extends Monster {
		public var hasAxe:Boolean;

		override public function defeated(hpVictory:Boolean):void {
			clearOutput();
			if (hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				outputText("You defeat a minotaur!  ");
				game.desert.antsScene.phyllaBeatAMino();
			}
			else game.mountain.minotaurScene.minoVictoryRapeChoices();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
			if (hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				game.desert.antsScene.phyllaPCLostToMino();
			}
			else if (pcCameWorms) {
				outputText("\n\nThe minotaur picks you up and forcibly tosses you from his cave, grunting in displeasure.");
				game.combat.cleanupAfterCombat();
			}
			else game.mountain.minotaurScene.getRapedByMinotaur();
		}

		override public function get long():String {
			return "An angry-looking minotaur looms over you.  Covered in shaggy " + hair.color + " fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature. "+
					(ballSize > 4?("  Barely visible below the tattered shreds of loincloth are " + Appearance.ballsDescription(true, true, this) + ", swollen with the minotaur's long pent-up need."):"") +
					(hasAxe?"<b>This minotaur seems to have found a deadly looking axe somewhere!</b>":"");
		}

		public function Minotaur(axe:Boolean=false) {
			hasAxe = axe || rand(3)==0; //most times they dont have an axe
			this.skin.furColor = randomChoice("black","brown");
			//trace("Minotaur Constructor!");
			this.a = "the ";
			this.short = "minotaur";
			this.imageName = hasAxe?"minoaxe":"minotaur";
			this.long = "";
			this.race = "Minotaur";
			//this.plural = false;
			this.createCock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = Ass.LOOSENESS_STRETCHED;
			this.ass.analWetness = Ass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = rand(37) + 84;
			this.hips.rating = Hips.RATING_AVERAGE;
			this.butt.rating = Butt.RATING_AVERAGE;
			this.lowerBody.type = LowerBody.HOOFED;
			this.skin.tone = skin.furColor;
			this.skin.type = Skin.FUR;
			this.skin.desc = "shaggy fur";
			this.hair.color = skin.furColor;
			this.hair.length = 3;
			initStrTouSpeInte(hasAxe ? 75 : 50, 60, 30, 20);
			initLibSensCor(40 + this.ballSize * 2, 15 + this.ballSize * 2, 35);
			this.face.type = Face.COW_MINOTAUR;
			this.weaponName = hasAxe?"axe":"fist";
			this.weaponVerb = hasAxe?"cleave":"punch";
			this.armorName = "thick fur";
			this.bonusHP = 20 + rand(this.ballSize*2);
			this.lust = this.ballSize * 3;
			this.lustVuln = hasAxe?0.84:0.87;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = hasAxe?6:5;
			this.gems = rand(5) + 5;
			if (hasAxe) {
				this.imageName = "minoaxe";
				this.drop = new WeightedDrop(consumables.MINOBLO, 1);
			}
			else {
				this.imageName = "minotaur";
				this.drop = new ChainedDrop().add(consumables.MINOCUM, 1 / 5)
						.add(consumables.MINOBLO, 1 / 2)
						.elseDrop(null);
			}
			this.special1 = game.mountain.minotaurScene.minoPheromones;
			this.tail.type = Tail.COW;
			checkMonster();
		}
	}
}
