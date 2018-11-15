/**
 * ...
 * @author melchi'is first attempt at making a monster 
 * special thanks to ox and everyone for helping
 */
package classes.Scenes.Areas.Forest 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.internals.*;
	import classes.GlobalFlags.*;
	import classes.Items.ArmorLib;
	
	public class Dryad extends Monster
	{

		//Melee special
		public function slash():void {
			outputText("The dryad reaches for you with claw-like wooden hands!  As soon as she is close, she slashes with her claws ");
			if (player.getEvasionRoll()) {
				outputText("and you deftly avoid her claws!");
			}
			else {
				outputText("and tears into your flesh! ");
				//Get hit
				var damage:int = str + weaponAttack + rand(40);
				damage = player.reduceDamage(damage);
				if (damage < 10) damage = 10;
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		//lust special
		public function pollen():void {
			var lustDmg:int = player.lib / 10 + player.cor / 10 + 10;
			outputText("The dryad runs her hands through her leafy hair and spins around.   \n\n Yellow and pink sparkles of pollen gently float through the air in your direction. ");
			if (player.getEvasionRoll()) {
				outputText("You cover your mouth and nose and avoid breathing in most of the pollen!");
			}
			else {
				outputText("You take a deep breath of the pollen!\n ");
				outputText("Your mind becomes a haze as a hot wave of arousal washes over you.");
				player.takeLustDamage(lustDmg, true);
				if (player.lust >= player.maxLust())
					doNext(game.combat.endLustLoss);
				else doNext(game.playerMenu);
			}
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			(new DryadScene()).winagainstdryad();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
			(new DryadScene()).loseTodryad();
		}
		function Dryad() 
		{
			this.a = "the ";
			this.short = "Corrupted Dryad";
			this.imageName = "dryad";
			this.long = "The dryad before you is brimming with corruption, her hair is composed of dark brown leaves. Her skin looks to be made of corrupted wood, especially her fingers which are shaped like sharp claws. Her clothing is nothing more than leaves and straw put into a gown. Her eyes are a deep and hungry dark red. Her bark-like skin seeps a thick pink substance.  ";
			this.race = "Dryad";
			this.createVagina(false, Vagina.WETNESS_DRY, Vagina.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = Ass.LOOSENESS_TIGHT;
			this.ass.analWetness = Ass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 60;
			this.hips.rating = Hips.RATING_AMPLE+2;
			this.butt.rating = Butt.RATING_LARGE;
			this.skin.tone = "birch-white";
			this.hair.color = "dark brown";
			this.hair.length = 4;
			initStrTouSpeInte(95, 75, 70, 100);
			initLibSensCor(55, 35, 45);
			this.weaponName = "claws";
			this.weaponVerb = "slash";
			this.weaponAttack = 25;
			this.armorName = "forest gown";
			this.armorDef = 24;
			this.fatigue = 0;
			this.bonusHP = 425;
			this.lust = 35;
			this.lustVuln = 0.4;
			this.level = 20;
			this.gems = rand(15) + 25;
			this.drop = new WeightedDrop().
						add(armors.FRSGOWN, 1);
			this.special1 = slash;
			this.special2 = pollen;

			checkMonster();
		}
	}
}
