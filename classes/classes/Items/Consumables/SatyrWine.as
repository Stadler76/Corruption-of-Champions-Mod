package classes.Items.Consumables 
{
	import classes.BodyParts.*;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.*;
	import classes.Items.Consumable;
	import classes.StatusEffects;

	/**
	 * Satyr Wine, part of the Black Cock by Foxxling
	 * @author Kitteh6660
	 */
	public class SatyrWine extends Consumable
	{
		
		public function SatyrWine() 
		{
			super("SatyrWn", "SatyrWine", "a bottle of satyr wine", 30, "A dark bottle with a brilliant red liquid sloshing around inside. On the label there is a picture of a satyr playing pipes.");
		}
		
		override public function useItem():Boolean
		{
			var tfSource:String = "satyrTFs";
			outputText("Feeling parched you tug the cork from a bottle of wine. As you put the bottle to your lips and drink the rich, invigorating liquid you soon find yourself with an empty bottle and a smile. ");
			player.refillHunger(10);
			mutations.initTransformation(null, 3);
			//Stats and genital changes
			if (rand(2) == 0) {
				outputText("\n\nHeat floods your loins as thoughts of tight round asses and dripping pussies flood your mind.");
				dynStats("lus", 25);
				if (player.lib100 < 100) {
					if (player.lib100 < 50) dynStats("lib", 1);
					dynStats("lib", 1);
				}
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.cocks[player.smallestCockIndex()].cockLength < 12) {
				outputText("\n\nHeat funnels into your cock as the alcohol flushes through you. Reaching down to inspect it, you find it has grown longer.");
				player.cocks[player.smallestCockIndex()].cockLength++;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.cocks[player.smallestCockIndex()].cockThickness < 4) {
				outputText("\n\nYou cock feels warm. When you reach down to inspect it your suspicions are confirmed; it's gotten thicker.");
				player.cocks[player.smallestCockIndex()].cockThickness += 0.5;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.balls > 0) {
				outputText("\n\nYou feel a warmth rising into your face along with a bubbling of alcohol tickling your nose. Once it's subsided, you notice your face has a more masculine, angular shape to it.");
				//player.modFem(0, 2 + rand(4));
				dynStats("lus", 20);
				if (player.cumMultiplier < 10) player.cumMultiplier += 1;
				if (player.cumMultiplier < 50) player.cumMultiplier += 0.5;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && player.hasStatusEffect(StatusEffects.BonusVCapacity)) {
				outputText("\n\nYou feel a tingling sensation in your vagina… that was weird.");
				if (player.statusEffectv1(StatusEffects.BonusVCapacity) >= 0) {
					player.addStatusValue(StatusEffects.BonusVCapacity, 1, -(rand(5) + 5));
					if (player.statusEffectv1(StatusEffects.BonusVCapacity) <= 0) player.removeStatusEffect(StatusEffects.BonusVCapacity);
				}
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && !player.hasCock()) {
				outputText("\n\nYour vagina begins to feel hot. Removing your [armor], you look down and watch your vagina shrinks to nothing, <b>while your clitoris enlarges to form a human dick</b>.");
				player.removeVagina();
				player.createCock(6, 1, CockTypesEnum.HUMAN);
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.balls <= 0) {
				outputText("Without warning your body begins to tremble as just below [eachCock] you feel a warm trickling sensation of fluid sliding down your body. Before you can check it, the sensation becomes overwhelming as [eachCock] grows hard and ejaculates " + player.clothedOrNaked("into your [armor]", "all over the ground") + ". Once you've recovered from your intense orgasm you " + player.clothedOrNakedLower("remove your [armor] to ") + "clean yourself and find a <b>new pair of balls</b> hanging just below [eachCock].");
				player.balls = 2;
				player.ballSize = 1;
				player.orgasm('Generic');
				changes++;
			}
			//Transformations
			//Neck restore
			if (player.neck.type != Neck.NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) == 0) mutations.updateOvipositionPerk(tfSource);

			if (rand(3) == 0 && changes < changeLimit && player.hasScales()) {
				outputText("\n\nYou feel an odd rolling sensation as your scales begin to shift, spreading and reforming as they grow and disappear, <b>becoming normal human skin</b>.");
				player.skin.type = Skin.PLAIN;
				player.underBody.restore();
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.HUMAN) {
				outputText("\n\nYou feel a pleasant heat in your arms as smoke rises from them, <b>leaving normal human arms</b>.");
				player.arms.type = Arms.HUMAN;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.lowerBody.type != LowerBody.CLOVEN_HOOFED) {
				outputText("\n\nYou feel an odd sensation in your lower region. Your [feet] shift and you hear bones cracking as they reform. Fur grows on your legs and soon you're looking at a <b>new pair of goat legs</b>.");
				player.lowerBody.type = LowerBody.CLOVEN_HOOFED;
				player.lowerBody.legCount = 2;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.lowerBody.type == LowerBody.CLOVEN_HOOFED && player.horns.type == Horns.GOAT && player.face.type != Face.HUMAN) {
				outputText("\n\nYour face grows warm as suddenly your vision is engulfed in smoke, coughing and beating the smoke back you noticed a marked change in your features. Touching yourself you confirm you have a <b>normal human shaped face once again</b>.");
				player.face.type = Face.HUMAN;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && !player.hasScales() && player.ears.type != Ears.ELFIN) {
				outputText("\n\nYou feel an odd shifting sensation on the side of your head and, reaching up to inspect it, find a <b>pair of fleshy pointed ears</b>. "); 
				if (player.hasFur()) ("As you examine your new elvish ears you feel fur grow around them, matching the rest of you.");
				player.ears.type = Ears.ELFIN;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.horns.type == Horns.NONE) {
				outputText("\n\nYou begin to feel a prickling sensation at the top of your head. Reaching up to inspect it, you find a pair of hard stubs. <b>You now have a pair of goat horns.</b>");
				player.horns.type = Horns.GOAT;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.horns.type != Horns.GOAT) {
				outputText("\n\nYou begin to feel an odd itching sensation as you feel your horns repositioning. Once it's over, you reach up and find a pair of hard stubs. <b>You now have a pair of goat horns.</b>");
				player.horns.value = 1;
				player.horns.type = Horns.GOAT;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.horns.type == Horns.GOAT && player.horns.value == 1) {
				outputText("\n\nYou feel heat blooming in your forehead. Confused you reach up to find your goat horns growing and thickening into a pair of horns with ridges and a slight curve. <b>You now have a pair of tall-standing goat horns.</b>");
				player.horns.value = 2;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.antennae.type != Antennae.NONE) {
				mutations.removeAntennae();
			}
			if (rand(3) == 0 && changes < changeLimit && player.cockTotal() == 1 && player.countCocksOfType(CockTypesEnum.HUMAN) == 0) {
				outputText("\n\nYou feel a stirring in your loins as your cock grows rock hard. You " + player.clothedOrNakedLower("pull it out from your [armor], to ") + "take a look. It seems you now <b>have a human dick again</b>.");
				player.cocks[0].cockType = CockTypesEnum.HUMAN;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.cockTotal() > 1 && (player.cockTotal() - player.countCocksOfType(CockTypesEnum.HUMAN)) > 0) {
				outputText("\n\nOne of your penises begins to feel strange. You " + player.clothedOrNakedLower("pull it out from your [armor], releasing", "notice") + " a plume of thick smoke. When you look down you see it has <b>become a human dick</b>.");
				for (var i:int = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockType != CockTypesEnum.HUMAN) {
						player.cocks[i].cockType = CockTypesEnum.HUMAN;
						break;
					}
				}
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.tail.type == 0) {
				outputText("\n\nYou feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a short stubby tail that wags when you're happy. <b>You now have a goat tail.</b>");
				player.tail.type = Tail.GOAT;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.tail.type > 0 && player.tail.type != Tail.GOAT) {
				outputText("\n\nYou [tail] suddenly goes numb. Looking back you see it changing, twisting and reforming into a <b>short stubby goat-like tail</b>.");
				player.tail.type = Tail.GOAT;
				changes++;
			}
			//No changes?
			if (changes == 0) {
				outputText("\n\nAside from a mild buzz, the wine has no further effect.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}
}
