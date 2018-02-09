package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.StatusEffects;
	import classes.BreastRowClass;
	
	/**
	 * Reset player character.
	 */
	public class SuperHummus extends Consumable 
	{
		public function SuperHummus() 
		{
			super("Hummus2","S.Hummus", "a blob of cheesy-looking super hummus", ConsumableLib.DEFAULT_VALUE, "This pile of hummus doesn't look that clean, and you really don't remember where you got it from.  It looks bland.  So bland that you feel blander just by looking at it.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "superHummus";
			clearOutput();
			if (game.debug) {
				outputText("You're about to eat the humus when you see it has bugs in it. Not wanting to eat bugged humus or try to debug it you throw it into the portal and find something else to eat.");
				var consumables:ConsumableLib = game.consumables;
				player.destroyItems(consumables.HUMMUS_, 1);
				return false;
			}
			outputText("You shovel the stuff into your face, not sure WHY you're eating it, but once you start, you just can't stop.  It tastes incredibly bland, and with a slight hint of cheese.");
			player.refillHunger(100);
			player.str = 30;
			player.spe = 30;
			player.tou = 30;
			player.inte = 30;
			player.sens = 20;
			player.lib = 25;
			player.cor = 5;
			player.lust = 10;
			player.hair.type = Hair.NORMAL;
			if (player.humanScore() > 4) {
				outputText("\n\nYou blink and the world twists around you.  You feel more like yourself than you have in a while, but exactly how isn't immediately apparent.  Maybe you should take a look at yourself?");
			}
			else {
				outputText("\n\nYou cry out as the world spins around you.  You're aware of your entire body sliding and slipping, changing and morphing, but in the sea of sensation you have no idea exactly what's changing.  You nearly black out, and then it's over.  Maybe you had best have a look at yourself and see what changed?");
			}
			player.arms.restore();
			player.eyes.type = Eyes.HUMAN;
			player.antennae.type = Antennae.NONE;
			player.face.type = Face.HUMAN;
			player.lowerBody.type = LowerBody.HUMAN;
			player.lowerBody.legCount = 2;
			player.wings.type = Wings.NONE;
			player.tail.type = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.tail.recharge = 0;
			player.horns.value = 0;
			player.horns.type = Horns.NONE;
			player.ears.type = Ears.HUMAN;
			player.skin.type = Skin.PLAIN;
			player.skin.desc = "skin";
			player.skin.adj = "";
			player.underBody.restore();
			player.neck.restore();
			player.rearBody.restore();
			player.tongue.type = Tongue.HUMAN;
			player.eyes.type = Eyes.HUMAN;
			if (player.fertility > 15) player.fertility = 15;
			if (player.cumMultiplier > 50) player.cumMultiplier = 50;
			var virgin:Boolean = false;
			//Clear cocks
			while (player.cocks.length > 0) {
				player.removeCock(0, 1);
			}
			//Reset dongs!
			if (player.gender === 1 || player.gender === 3) {
				player.createCock();
				player.cocks[0].cockLength = 6;
				player.cocks[0].cockThickness = 1;
				player.ballSize = 2;
				if (player.balls > 2) player.balls = 2;
			}
			//Non duders lose any nuts
			else {
				player.balls = 0;
				player.ballSize = 2;
			}
			//Clear vaginas
			while (player.vaginas.length > 0) {
				virgin = player.vaginas[0].virgin;
				player.removeVagina(0, 1);
			}
			//Reset vaginal virginity to correct state
			if (player.gender >= 2) {
				player.createVagina();
				player.vaginas[0].virgin = virgin;
			}
			player.setClitLength(.25);
			//Tighten butt!
			player.butt.rating = 2;
			player.hips.rating = 2;
			if (player.ass.analLooseness > 1) player.ass.analLooseness = 1;
			if (player.ass.analWetness > 1) player.ass.analWetness = 1;
			//Clear breasts
			player.breastRows = new Vector.<BreastRowClass>();
			player.createBreastRow();
			player.nippleLength = .25;
			//Girls and herms get bewbs back
			if (player.gender > 2) {

				player.breastRows[0].breastRating = 2;
			}
			else player.breastRows[0].breastRating = 0;
			player.gills.type = Gills.NONE;
			player.removeStatusEffect(StatusEffects.Uniball);
			player.removeStatusEffect(StatusEffects.BlackNipples);
			player.vaginaType(0);
			mutations.updateOvipositionPerk(tfSource);
			
			return false;
		}
	}
}
