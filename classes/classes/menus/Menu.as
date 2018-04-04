package classes.menus 
{
	/**
	 * Interface for GUI menus, which are a collection of buttons
	 */
	public interface Menu {
		/**
		 * This function is used as the entry point into the menu.
		 * It is usually responsible for drawing the menu.
		 */
		function enter(): void;

		/**
		 * Returns the text that should be displayed in a button that will
		 * call this menu.
		 * 
		 * @return the button text for this menu
		 */
		function getButtonText(): String;

		/**
		 * Returns the hint text for the Button that calls this menu.
		 * 
		 * @return the button hint for this menu.
		 */
		function getButtonHint(): String;
	}
}
