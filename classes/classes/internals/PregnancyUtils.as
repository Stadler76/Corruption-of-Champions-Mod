package classes.internals 
{
	import classes.internals.GuiOutput;
	import classes.Player;
	import flash.errors.IllegalOperationError;
	
	/**
	 * Utility methods replated to pregnancy.
	 */
	public class PregnancyUtils 
	{
		public function PregnancyUtils() 
		{
			throw new IllegalOperationError("Cannot create instance of a Util class");
		}
		
		/**
		 * Check if the player has a vagina and create one if missing.
		 * This is usually used when a pregnant player is giving birth,
		 * as the scene text would be inconsistent and any operations on a
		 * non-existent vagina would crash the game.
		 */
		public static function createVaginaIfMissing(guiForOutput:GuiOutput, player:Player): void {
			if (player.vaginas.length === 0) {
				guiForOutput.text("\nYou feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n");
				player.createVagina();
			}
		}
	}
}
