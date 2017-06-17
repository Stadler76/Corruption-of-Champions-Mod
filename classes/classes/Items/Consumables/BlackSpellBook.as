package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.StatusEffects;
	
	/**
	 * A spellbook that teaches the player one the following spells: 'Arouse', 'Heal' or 'Might'.
	 * May also raise int.
	 */
	public class BlackSpellBook extends Consumable 
	{
		private static const ITEM_VALUE:int = 40;
		
		public function BlackSpellBook() 
		{
			super("B. Book","B. Book", "a small book with a midnight-black cover", ITEM_VALUE, "This solid black book is totally unmarked, saved for a blood red clasp that holds the covers closed until you are ready to read it.  The pages are edged with gold, like some of the fancy books in the monastery back home.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You open the small black book, and discover it to be an instructional book on the use of black magic.  Most of it is filled with generic information about black magic - how it is drawn from emotions (typically lust), and how it has the power to affect bodies and emotions.  It also warns against using it on oneself, as it is difficult to draw on your emotions while meddling with your own body.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
			if (player.inte100 < 30) {
				outputText("\n\nYou feel greatly enlightened by your time spent reading.");
				dynStats("int", 4);
			}
			else if (player.inte100 < 60) {
				outputText("\n\nSpending some time reading was probably good for you, and you definitely feel smarter for it.");
				dynStats("int", 2);
			}
			else if (player.inte100 < 80) {
				outputText("\n\nAfter reading the small tome your already quick mind feels invigorated.");
				dynStats("int", 1);
			}
			else {
				outputText("\n\nThe contents of the book did little for your already considerable intellect.");
				dynStats("int", .6);
			}
			//Smart enough for arouse and doesnt have it
			if (player.inte >= 25 && !player.hasStatusEffect(StatusEffects.KnowsArouse)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Arouse.</b>");
				player.createStatusEffect(StatusEffects.KnowsArouse, 0, 0, 0, 0);
				return false;
			}
			//Smart enough for arouse and doesnt have it
			if (player.inte >= 30 && !player.hasStatusEffect(StatusEffects.KnowsHeal)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Heal.</b>");
				player.createStatusEffect(StatusEffects.KnowsHeal, 0, 0, 0, 0);
				return false;
			}
			//Smart enough for arouse and doesnt have it
			if (player.inte >= 40 && !player.hasStatusEffect(StatusEffects.KnowsMight)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Might.</b>");
				player.createStatusEffect(StatusEffects.KnowsMight, 0, 0, 0, 0);
			}
			//Smart enough for blackfire and doesnt have it
			if (player.inte >= 50 && !player.hasStatusEffect(StatusEffects.KnowsBlackfire)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Blackfire.</b>");
				player.createStatusEffect(StatusEffects.KnowsBlackfire, 0, 0, 0, 0);
			}
			return false;
		}
	}
}
