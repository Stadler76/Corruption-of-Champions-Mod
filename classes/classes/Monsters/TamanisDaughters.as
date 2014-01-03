package classes.Monsters
{
	import classes.Monster;

	/**
	 * ...
	 * @author aimozg
	 */
	public class TamanisDaughters extends Goblin
	{
		private function midRoundMadness():void {
			var selector:Number = rand(4);
			if(selector == 0) {
				outputText("A slender hand reaches inside your " + player.armorName + " and gives your ", false);
				if(player.balls > 0) {
					if(rand(2) == 0) outputText(player.multiCockDescriptLight(), false);
					else outputText(player.ballsDescriptLight(), false);
				}
				else outputText(player.multiCockDescriptLight(), false);
				outputText(" a gentle squeeze.  You twist away but your breathing gets a little heavier.\n\n", false);
			}
			else if(selector == 1) {
				outputText("A girl latches onto your " + player.legs() + " and begins caressing your body lovingly, humming happily.  You quickly shake her loose but the attention makes you blush a little more.\n\n", false);
			}
			else if(selector == 2) {
				outputText("One of your daughters launches onto your back and presses her hard, pierced nipples against your neck.  She whispers in your ear, \"<i>Twist my nipples dad!</i>\"\n\n", false);
				outputText("You reach back and throw her off, but her perverted taunts still leave you feeling a little hot under the collar.\n\n", false);
			}
			else outputText("A daughter lays down in front of you and starts jilling herself on the spot.  It's impossible to not glance down and see her or hear her pleasured moans.  You step away to remove the distraction but it definitely causes some discomfort in your " + player.armorName + ".\n\n", false);
			game.dynStats("lus", 1 + player.lib/15+rand(player.cor/30));
		}
		
		private function tamaniShowsUp():void {
			if(hasStatusAffect("Tamani") < 0 && rand(6) == 0) {
				createStatusAffect("Tamani",0,0,0,0);
				outputText("A high-pitched yet familiar voice calls out, \"<i><b>So this is where you skanks ran off to---wait a second.  Are you trying to poach Tamani's man!?</b></i>\"\n\n", false);
				outputText("You can see Tamani lurking around the rear of the goblin pack, visibly berating her daughters.  On one hand it sounds like she might help you, but knowing goblins, she'll probably forget about her anger and help them subdue you for more cum...\n\n", false);
				//(+5 mob strength)
				str += 5;
				//(+5 mob toughness)
				tou += 5;
				HP += 10;
				//(-20 mob lust)
				lust -= 20;
				//append combat desc
				long += " <b>Tamani lurks in the back of the crowd, curvier than her brood and watching with a mixture of amusement and irritation.  She runs a hand through her pink and black hair, waiting for an opportunity to get involved...</b>";
			}
			//Tamani already there - chance of potion
			else if(rand(4) == 0 && hasStatusAffect("Tamani") >= 0) {
				goblinDrugAttack();
			}
		}

		override protected function performCombatAction():void
		{
			var select:Number=1;
			//mid-round madness!
			midRoundMadness();
			tamaniShowsUp();
				
			if(special1 > 0) select++;
			if(special2 > 0) select++;
			if(special3 > 0) select++;
			var rando:int = rand(select);
			//Tamani's Daughters get multiattacks!
			if(rando == 0) {
				createStatusAffect("attacks",int(player.statusAffectv2("Tamani")/2/10),0,0,0);
				eAttack();
			}
			if(rando == 1) game.eventParser(special1);
			if(rando == 2) game.eventParser(special2);
			if(rando == 3) game.eventParser(special3);
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.combatWinAgainstDaughters();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foes seem visibly disgusted and leave, telling you to, \"<i>quit being so fucking gross...</i>\"");
				game.cleanupAfterCombat();
			} else {
				game.loseToDaughters();
			}
		}

		public function TamanisDaughters()
		{
			super(false);
			init01Names("the group of ","Tamani's daughters","tamanisdaughters","A large grouping of goblin girls has gathered around you, surrounding you on all sides.  Most have varying shades of green skin, though a few have yellowish or light blue casts to their skin.  All are barely clothed, exposing as much of their flesh as possible in order to excite a potential mate.  Their hairstyles are as varied as their clothing and skin-tones, and the only things they seem to have in common are cute faces and curvy forms.  It looks like they want something from you.",true);
			init02Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_TIGHT,40);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,25);
			init05Body(40,HIP_RATING_AMPLE+1,BUTT_RATING_NOTICEABLE+1);
			init06Skin("greenish gray");
			init07Hair("pink",16);
			init08Face();
			init09PrimaryStats(55,30,45,50,70,70,50);
			init10Weapon("fists","tiny punch");
			init11Armor("leather straps");
			var bonusHP:Number = 50 + (int(player.statusAffectv2("Tamani")/2)*15);
			init12Combat(bonusHP,30,.65,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			var level:int = 8 + (Math.floor(player.statusAffectv2("Tamani")/2/10));
			init13Level(level,rand(15) + 5);
		}

	}

}