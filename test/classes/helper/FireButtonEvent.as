package classes.helper 
{
	import classes.MainViewManager;
	import coc.view.MainView;
	import flash.events.MouseEvent;
	
	/**
	 * Fires Button click events to simulate user button clicks.
	 */
	public class FireButtonEvent 
	{
		private static const NEXT_BUTTON_LOCATION:int = 0;
		
		private var mainView:MainView;
		private var maxButtonIndex:int;
		
		/**
		 * Create a new instance that can be used to fire button events.
		 * @param	mainView the view that caontains the buttons
		 * @param	maxButtonIndex the maximum number of buttons, should usually be Output.MAX_BUTTON_INDEX
		 */
		public function FireButtonEvent(mainView:MainView, maxButtonIndex:int) 
		{
			this.mainView = mainView;
			this.maxButtonIndex = maxButtonIndex;
		}
		
		/**
		 * Fires a event for the given button.
		 * @param	buttonIndex for which the event should be fired
		 * @throws  ArgumentError if the button is out of bounds
		 */
		public function fireButtonClick(buttonIndex:int):void {
			indexRangeCheck(buttonIndex);
			
			mainView.bottomButtons[buttonIndex].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function indexRangeCheck(buttonIndex:int):void{
			if (buttonIndex > maxButtonIndex) {
				throw new ArgumentError("The maximum allowed button index is " + maxButtonIndex);
			}
			
			if (buttonIndex < 0) {
				throw new ArgumentError("The button index cannot be negative");
			}
		}
		
		/**
		 * Presses the next button (Button 0).
		 * Useful for pressing 'Next' on doNext() events.
		 */
		public function fireNextButtonEvent():void {
			fireButtonClick(NEXT_BUTTON_LOCATION);
		}
	}
}
