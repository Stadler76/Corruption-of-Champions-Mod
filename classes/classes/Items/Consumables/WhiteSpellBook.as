package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.StatusEffects;
	
	/**
	 * A spellbook that teaches the player one the following spells: 'Charge Weapon', 'Blind' or 'Whitefire'.
	 * May also raise int.
	 */
	public class WhiteSpellBook extends Consumable 
	{
		private static const ITEM_VALUE:int = 40;
		
		public function WhiteSpellBook() 
		{
			super("W. Book","W. Book", "a small book with a pristine white cover", ITEM_VALUE, "This white book is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass clasp keeps the covers closed until you are ready to read it.");
		}

		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You open the white tome, and discover it to be an instructional book on the use of white magic.  Most of it is filled with generic information about white magic - how it is drawn for mental focus, is difficult to use when tired or aroused, and can be used to create and control energy.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
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
			if (player.inte100 >= 25 && !player.hasStatusEffect(StatusEffects.KnowsCharge)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Charge Weapon.</b>");
				player.createStatusEffect(StatusEffects.KnowsCharge, 0, 0, 0, 0);
				return false;
			}
			//Smart enough for arouse and doesnt have it
			if (player.inte100 >= 30 && !player.hasStatusEffect(StatusEffects.KnowsBlind)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Blind.</b>");
				player.createStatusEffect(StatusEffects.KnowsBlind, 0, 0, 0, 0);
				return false;
			}
			//Smart enough for arouse and doesnt have it
			if (player.inte100 >= 40 && !player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
				outputText("\n\nYou blink in surprise, assaulted by the knowledge of a <b>new spell: Whitefire.</b>");
				player.createStatusEffect(StatusEffects.KnowsWhitefire, 0, 0, 0, 0);
			}
			
			return false;
		}
	}
}
