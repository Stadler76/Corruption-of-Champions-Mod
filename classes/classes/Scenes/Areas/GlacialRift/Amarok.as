//By Foxwells
//Amarok, a big ass wolf from Inuit mythology. Idek. Glacial Rift is depressingly empty
//Since it's a big ass god wolf, it's pretty hard to beat
//Herm, since there's no set gender for it in its mythology
//Comes with an unique bad end if you lose to it too many times, kinda like the Phoenix
package classes.Scenes.Areas.GlacialRift {
	import classes.*;
	import classes.BodyParts.*;
	import classes.BodyParts.Hips;
	import classes.internals.WeightedDrop;

	public class Amarok extends Monster {

		protected function amarokClaw():void {
			//Blind
			if(hasStatusEffect(StatusEffects.Blind)) {
				outputText("The Amarok lunges for you, attempting to slash you with one of its paws, but misses completely due to its blindness.");
				combatRoundOver();
			}
			//Dodge that shit yo
			if (player.getEvasionRoll()) {
				outputText("The Amarok throws itself at you, attempting to slash you with its claws. Luckily, you manage to move out of the way.");
				combatRoundOver();
			}
			else {
				//Damage roll
				outputText("The Amarok throws itself at you and rakes one of its hefty paws across you. Its claws slice you open and draw blood.");
				var damage:int = ((str + 50) + rand(100));
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		//AMAROK used TAIL SLAP!
		protected function amarokTail():void {
			outputText("The Amarok rushes up to you and immediately turns heel, attempting to crash its tail into you. ");
			//Blind check...
			if (hasStatusEffect(StatusEffects.Blind)) {
				outputText("Luckily, though, its blindness causes it to misjudge your location and it misses entirely.");
				combatRoundOver();
			}
			//Evasioning
			if (player.getEvasionRoll()) {
				outputText("You move out of the way before it can hit.");
				combatRoundOver();
			}
			//Damageeee + stun! Reference to the legend of it slapping a kid with its tail, except minus the bone breaking
			else {
				outputText("The hit sends you stumbling back");
				if (player.findPerk(PerkLib.Resolute) <= 0 && rand(2) == 0) {
					outputText(", stunning you");
					player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
				}
				outputText(".");
				var damage:int = ((str + 100) + rand(75));
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}

		override protected function performCombatAction():void {
			var chooser:Number = rand(10);
			if (chooser < 6) amarokClaw(); //60% chance
			else if (chooser >= 6 && chooser < 9) amarokTail(); //40% chance
			else eAttack(); //when the hell was this removed?? Game just broke cuz it was .-.;;
		}

		override public function defeated(hpVictory:Boolean):void { game.glacialRift.amarokScene.winAgainstAmarok(); }
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
			if (pcCameWorms) {
				outputText("\n\nThe Amarok looks down at the worms you came, sniffs them, then snarls and walks away. It must consider you to be tainted meat.");
				doNext(game.combat.endLustLoss);
			}
			else game.glacialRift.amarokScene.amarokChowTime();
		}

		public function Amarok() {
			this.a = "the ";
			this.short = "Amarok";
			this.imageName = "amarok";
			this.long = "You are fighting an Amarok, a massive wolf that seems set on hunting you. The buffeting snow does nothing to hide its thick, black fur, and hardly manages to even ruffle it. It has golden, hungry eyes that watch your every move and sharp teeth capable of crushing bones. It looms over you in both height and width, with well-defined muscles, long legs, and bulky paws with deadly claws only adding to its intimidating stature. Even its tail looks capable of knocking you down. It's the most normal animal-like creature you've seen here yet, a normal wolf despite its size, but is no less terrifying. You get the feeling this won't be an easy fight, especially considering it's not about to let you run away.";
			this.race = "Wolf";
			this.plural = false;
			this.createVagina(false, 1, 1);
			this.createCock(8, 1.5, CockTypesEnum.WOLF);
			this.balls = 2;
			this.ballSize = 2;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			createBreastRow(2,1);
			createBreastRow(2,1);
			createBreastRow(2,1);
			createBreastRow(2,1);
			this.ass.analLooseness = Ass.LOOSENESS_TIGHT;
			this.ass.analWetness = Ass.WETNESS_DRY;
			this.tallness = 8*12;
			this.hips.rating = Hips.RATING_AVERAGE;
			this.butt.rating = Butt.RATING_AVERAGE;
			this.lowerBody.type = LowerBody.WOLF;
			this.arms.type = Arms.WOLF;
			this.skin.tone = "black";
			this.skin.setType(Skin.FUR);
			this.hair.color = "black";
			this.hair.length = 3;
			this.face.type = Face.WOLF;
			this.ears.type = Ears.WOLF;
			this.eyes.type = Eyes.WOLF;
			initStrTouSpeInte(90,110,75,85);
			initLibSensCor(0,10,10);
			this.weaponName = "teeth";
			this.weaponVerb = "bite";
			this.weaponAttack = 20;
			this.armorName = "thick fur";
			this.armorDef = 15;
			this.bonusHP = 400;
			this.lust = 0;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_AVOID_GRAPPLES;
			this.level = 22;
			this.gems = 40 + rand(25);
			this.drop = new WeightedDrop(consumables.WOLF_PP, 1);
			this.special1 = amarokClaw;
			this.special2 = amarokTail;
			this.tail.type = Tail.WOLF;
			if (!player.canFly()) {
				//"Watching your movements" alluded to this. Its lore is stalking and hunting people, so I imagine you can't get away
				this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
				//Otherwise I'd suggest doing a hellhound knock-off of the scent tracking, which makes it harder to run
			}
			checkMonster();
		}
	}
}
