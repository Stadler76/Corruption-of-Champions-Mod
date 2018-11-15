package classes.Scenes.Dungeons.Factory
{
	import classes.*;
	import classes.BodyParts.*;
	import classes.Scenes.Monsters.AbstractSuccubus;
	import classes.Scenes.Dungeons.Factory;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;

	public class SecretarialSuccubus extends AbstractSuccubus 
	{
		public var factory:Factory = new Factory()
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.gender > 0) {
				clearOutput();
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you rape her?");
					player.takeLustDamage(1, true);
					kGAMECLASS.output.doYesNo(factory.secretarialSuccubus.doRapeSuccubus, factory.secretarialSuccubus.doLeaveSuccubus)
					if (player.hasKeyItem("Deluxe Dildo") >= 0) kGAMECLASS.output.addButton(2, "Dildo Rape", factory.secretarialSuccubus.dildoSuccubus);
				} else if (player.lust >= 33) {	
					outputText("You smile in satisfaction as the " + short + " gives up on fighting you and starts masturbating, begging for you to fuck her.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you fuck her?");
					player.takeLustDamage(1, true);
					kGAMECLASS.output.doYesNo(factory.secretarialSuccubus.doRapeSuccubus, factory.secretarialSuccubus.doLeaveSuccubus)
					if (player.hasKeyItem("Deluxe Dildo") >= 0) kGAMECLASS.output.addButton(2, "Dildo Rape", factory.secretarialSuccubus.dildoSuccubus);
				} else {
					doNext(factory.secretarialSuccubus.doLeaveSuccubus);
				}
			} else {
				doNext(factory.secretarialSuccubus.doLeaveSuccubus);
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(game.combat.endLustLoss);
			} else {
				doNext(factory.secretarialSuccubus.doLossSuccubus);
			}
		}

		public function SecretarialSuccubus() {
			this.a = "the ";
			this.short = "secretarial succubus";
			this.imageName = "secretarialsuccubus";
			this.long = "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.";
			this.race = "Demon";
			// this.plural = false;
			this.createVagina(false, Vagina.WETNESS_SLAVERING, Vagina.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = Ass.LOOSENESS_STRETCHED;
			this.ass.analWetness = Ass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 60;
			this.hips.rating = Hips.RATING_CURVY;
			this.butt.rating = Butt.RATING_LARGE+1;
			this.lowerBody.type = LowerBody.DEMONIC_HIGH_HEELS;
			this.skin.tone = "blue";
			this.hair.color = "blond";
			this.hair.length = 13;
			initStrTouSpeInte(50, 40, 75, 35);
			initLibSensCor(80, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="slap";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 4;
			this.bonusHP = 100;
			this.lust = 30;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 7;
			this.gems = rand(25) + 10;
			this.additionalXP = 50;
			this.drop = new WeightedDrop(consumables.LACTAID, 1);
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.tail.type = Tail.DEMONIC;
			this.special1 = kissAttack;
			this.special2 = seduceAttack;
			this.special3 = whipAttack;
			checkMonster();
		}

	}

}
