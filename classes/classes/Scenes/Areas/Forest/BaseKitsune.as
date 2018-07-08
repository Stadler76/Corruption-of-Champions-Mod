package classes.Scenes.Areas.Forest 
{
	import classes.Monster;
	import classes.PerkLib;
	import classes.StatusEffects;
	
	/**
	 * This class contains code and text that are shared between Aiko and Yamata.
	 */
	public class BaseKitsune extends Monster 
	{
		protected static const PHYSICAL_SKILL:String = "physical";
		protected static const MAGICAL_SKILL:String = "magical";
		
		public function BaseKitsune() 
		{
			super();
		}
		
		/**
		 * Calculate the resist value for attacks. This is based on INT and modified by certain perks.
		 * @return the calculated resist value
		 */
		protected function calculateAttackResist(): int
		{
			var resist:int = 0;
			
			if (player.inte < 30) {
				resist = Math.round(player.inte);
			} else {
				resist = 30;
			}
			
			if (player.findPerk(PerkLib.Whispered) >= 0) {
				resist += 20;
			}
			
			if (player.findPerk(PerkLib.HistoryReligious) >= 0 && player.isPureEnough(20)) {
				resist += 20 - player.corAdjustedDown();
			}
			
			return resist;
		}
		
		/**
		 * Seal the player's attacks, rendering them unable to attack until it wears off.
		 */
		protected function sealPlayerAttack(): void
		{
			outputText("The kitsune playfully darts around you, grinning coyly.  She somehow slips in under your reach, and before you can react, draws a small circle on your chest with her fingertip.  As you move to strike again, the flaming runic symbol she left on you glows brightly, and your movements are halted mid-swing.");
			outputText("\n\n\"<i>Naughty naughty, you should be careful with that.</i>\"");

			outputText("\n\nDespite your best efforts, every time you attempt to attack her, your muscles recoil involuntarily and prevent you from going through with it.  <b>The kitsune's spell has sealed your attack!</b>  You'll have to wait for it to wear off before you can use your basic attacks.");
			player.createStatusEffect(StatusEffects.Sealed, 4, 0, 0, 0);
		}
		
		/**
		 * Seal the players physical special attacks. Prints text and creates the matching status effect.
		 */
		protected function sealPlayerPhysicalSpecialSkills(): void
		{
			sealPlayerSpecial(PHYSICAL_SKILL);
		}
		
		/**
		 * Seal the players magical special attacks. Prints text and creates the matching status effect.
		 */
		protected function sealPlayerMagicSpecialSkills(): void
		{
			sealPlayerSpecial(MAGICAL_SKILL);
		}
		
		/**
		 * Seals the players special skill. Prints the matching text and applies a status effect.
		 * @param	skillType the type of skill to seal (physical, magical)
		 * @throws ArgumentError if the selected skill is invalid
		 */
		private function sealPlayerSpecial(skillType:String):void
		{
			outputText("You jump with surprise as the kitsune appears in front of you, grinning coyly.  As she draws a small circle on your forehead with her fingertip, you find that you suddenly can't remember how to use any of your " + skillType + " skills!");
			outputText("\n\n\"<i>Oh no darling, </i>I'm<i> the one with all the tricks here.</i>\"");
			outputText("\n\n<b>The kitsune's spell has sealed your " + skillType + " skills!</b>  You won't be able to use any of them until the spell wears off.");
			
			if (skillType === PHYSICAL_SKILL) {
				player.createStatusEffect(StatusEffects.Sealed, 4, 5, 0, 0);
			} else if (skillType === MAGICAL_SKILL) {
				player.createStatusEffect(StatusEffects.Sealed, 4, 6, 0, 0);
			} else {
				throw new ArgumentError("Invalid skill type!");
			}
		}
		
		/**
		 * Seals the players ability to use the tease skill.
		 */
		protected function sealPlayerTease(): void
		{
			outputText("You are taken by surprise when the kitsune appears in front of you out of nowhere, trailing a fingertip down your chest.  She draws a small circle, leaving behind a glowing, sparking rune made of flames.  You suddenly find that all your knowledge of seduction and titillation escapes you.  <b>The kitsune's spell has sealed your ability to tease!</b>  Seems you won't be getting anyone hot and bothered until it wears off.");
			player.createStatusEffect(StatusEffects.Sealed, 4, 1, 0, 0);
		}
		
		/**
		 * Seals the players ability to use items during combat.
		 */
		protected function sealPlayerItems(): void
		{
			outputText("\"<i>Tsk tsk, using items?  That's cheating!</i>\"  the kitsune says as she appears right in front of you, taking you off guard.  Her finger traces a small circle on your pouch, leaving behind a glowing rune made of crackling flames.  No matter how hard you try, you can't seem to pry it open.  <b>The kitsune's spell has sealed your item pouch!</b>  Looks like you won't be using any items until the spell wears off.");
			player.createStatusEffect(StatusEffects.Sealed, 4, 3, 0, 0);
		}
		
		/**
		 * Seals the players spells, preventing them from using magic.
		 */
		protected function sealPlayerSpells(): void
		{
			outputText("\"<i>Oh silly, trying to beat me at my own game are you?</i>\"  the kitsune says with a smirk, surprising you as she appears right in front of you.  She traces a small circle around your mouth, and you find yourself stricken mute!  You try to remember the arcane gestures to cast your spell and find that you've forgotten them too.  <b>The kitsune's spell has sealed your magic!</b>  You won't be able to cast any spells until it wears off.");
			player.createStatusEffect(StatusEffects.Sealed, 4, 2, 0, 0);
		}
		
		/**
		 * The player resists the seal attempt.
		 */
		protected function resistSeal():void
		{
			outputText("\n\nUpon your touch, the seal dissipates, and you are free of the kitsune's magic!  She pouts in disappointment, looking thoroughly irritated, but quickly resumes her coy trickster facade.");
			player.removeStatusEffect(StatusEffects.Sealed);
		}
		
		/**
		 * Seal the players movements, preventing them from escaping.
		 */
		protected function sealPlayerMovement():void
		{
			outputText("\"<i>Tsk tsk, leaving so soon?</i>\"  the kitsune says, popping up in front of you suddenly as you attempt to make your escape.  Before you can react, she draws a small circle on your chest with her fingertip, leaving behind a glowing rune made of crackling blue flames.  You try to run the other way, but your " + player.legs() + " won't budge!\n\n\"<i>Sorry baby, you'll just have to stay and play~.</i>\" she says in a singsong tone, appearing in front of you again.  <b>The kitsune's spell prevents your escape!</b>  You'll have to tough it out until the spell wears off.");
			player.createStatusEffect(StatusEffects.Sealed, 4, 4, 0, 0);
		}
		
		/**
		 * Cancels and disables whatever command the player uses this round. Lasts 3 rounds, cannot seal more than one command at a time.
		 * PCs with "Religious" background and < 20 corruption have up to 20% resistance to sealing at 0 corruption, losing 1% per corruption.
		 */
		protected function kitsuneSealAttack():void
		{
			var resist:int = calculateAttackResist();
			var select:int = rand(7);
			
			if (select == 0) {
				sealPlayerAttack();
			}
			else if (select == 1) {
				sealPlayerTease();
			}
			else if (select == 2) {
				sealPlayerSpells();
			}
			else if (select == 3) {
				sealPlayerItems();
			}
			else if (select == 4) {
				sealPlayerMovement();
			}
			else if (select == 5) {
				sealPlayerPhysicalSpecialSkills();
			}
			else {
				sealPlayerMagicSpecialSkills();
			}
			
			if (resist >= rand(100)) {
				resistSeal();
			}
			combatRoundOver();
		}
	}
}
