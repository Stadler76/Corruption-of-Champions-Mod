package classes 
{
import flash.utils.setTimeout;

/**
	 * Class to replace the old and somewhat outdated output-system, which mostly uses the include-file includes/engineCore.as
	 * @since  08.08.2016
	 * @author Stadler76
	 */
	public class Output extends BaseContent
	{
		import flash.text.TextFormat;
		import classes.GlobalFlags.kGAMECLASS;
		import classes.GlobalFlags.kFLAGS;
		import coc.view.MainView;

		private static var _instance:Output = new Output();
		private static const HISTORY_MAX:int = 20;

		public function Output()
		{
			if (_instance != null)
			{
				throw new Error("Output can only be accessed through Output.init()");
			}
		}

		public static function init():Output { return _instance; }

		protected var _currentText:String = "";
		protected var _history:Array = [""];

		public function forceUpdate():void { kGAMECLASS.forceUpdate(); }

		/**
		 * Passes the text through the parser and adds it to the output-buffer 
		 *
		 * In debug-mode the output is directly flushed to the GUI.
		 * If you want to clear the output before adding text, use clear(true) or just clear()
		 * The old second param `purgeText:Boolean = false` from outputText(...) is not supported anymore
		 * in favor of using clear() and will never return.
		 * 
		 * Unfortunately no one succeded to support markdown formatting for CoC, although this was attempted.
		 *
		 * This must not be made possible to be called directly from the outside, use wrapper-methods instead.
		 *
		 * @param   text    The text to be added
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		protected function _addText(text:String):Output
		{
			// This is cleaup in case someone hits the Data or new-game button when the event-test window is shown. 
			// It's needed since those buttons are available even when in the event-tester
			mainView.hideTestInputPanel();

			text = kGAMECLASS.parser.recursiveParser(text);
			record(text);
			_currentText += text;
			//if (debug) mainView.setOutputText(_currentText);

			return this;
		}

		/**
		 * Add text to the output-buffer
		 *
		 * Actually this is a wrapper around _addText(text)
		 *
		 * @param   text    The text to be added
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function text(text:String):Output
		{
			return _addText(text);
		}

		/**
		 * Flushes the buffered output to the GUI aka displaying it
		 *
		 * This doesn't clear the output buffer, so you can add more text after that and flush it again.
		 * flush() always ends a method chain, so you need to start a new one.
		 * 
		 * <b>Note:</b> Calling this with open formatting tags can result in strange behaviour, 
		 * e.g. all text will be formatted instead of only a section.
		 */
		public function flush():void
		{
			mainViewManager.setText(_currentText);
		}

		/**
		 * Adds a formatted headline to the output-buffer
		 *
		 * @param	headLine    The headline to be formatted and added
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function header(headLine:String):Output
		{
			return text("<font size=\"36\" face=\"Georgia\"><u>" + headLine + "</u></font>\n");
		}

		/**
		 * Clears the output-buffer
		 *
		 * @param   hideMenuButtons   Set this to true to hide the menu-buttons (rarely used)
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function clear(hideMenuButtons:Boolean = false):Output
		{
			if (hideMenuButtons) {
				forceUpdate();
				if (kGAMECLASS.gameState != 3) mainView.hideMenuButton(MainView.MENU_DATA);
				mainView.hideMenuButton(MainView.MENU_APPEARANCE);
				mainView.hideMenuButton(MainView.MENU_LEVEL);
				mainView.hideMenuButton(MainView.MENU_PERKS);
				mainView.hideMenuButton(MainView.MENU_STATS);
			}
			nextEntry();
			_currentText = "";
			mainView.clearOutputText();
			return this;
		}

		/**
		 * Adds raw text to the output without passing it through the parser
		 *
		 * If you want to clear the output before adding raw text, use clear(true) or just clear()
		 * The second param `purgeText:Boolean = false` is not supported anymore in favor of using clear() and will never return.
		 *
		 * @param   text    The text to be added to the output-buffer
		 * @return  The instance of the class to support the 'Fluent interface' aka method-chaining
		 */
		public function raw(text:String):Output
		{
			_currentText += text;
			record(text);
			//mainView.setOutputText(_currentText);
			return this;
		}

		/**
		 * Appends a raw text to history, appending to last entry
		 * @param text The text to be added to history
		 * @return this
		 */
		public function record(text:String):Output {
			if (_history.length==0) _history=[""];
			_history[_history.length-1] += text;
			return this;
		}
		/**
		 * Appends a new text entry to the history
		 * @param text The text to be added to history as a separate and complete entry
		 * @return this
		 */
		public function entry(text:String):Output {
			nextEntry();
			record(text);
			nextEntry();
			return this;
		}

		/**
		 * Finishes the history entry, starting a new one and removing old entries as
		 * history grows
		 * @return this
		 */
		public function nextEntry():Output {
			if (_history.length==0) _history=[""];
			if (_history[_history.length-1].length>0) _history.push("");
			while(_history.length > HISTORY_MAX) _history.shift();
			return this;
		}

		/**
		 * Clears current history enter -- removes everything recorded since last 'clearOutput', 'entry', or 'nextEntry'
		 * @return this
		 */
		public function clearCurrentEntry():Output {
			if (_history.length==0) _history=[""];
			_history[_history.length-1] = "";
			return this;
		}
		/**
		 * @return this
		 */
		public function clearHistory():Output {
			_history = [""];
			return this;
		}

		/**
		 * Displays all recorded history (with current text at the end), and scrolls to the bottom.
		 * @return this
		 */
		public function showHistory():Output
		{
			clear();
			var txt:String = _history.join("<br>");
			nextEntry();
			raw(txt);
			clearCurrentEntry();
			// On the next animation frame
			setTimeout(function():void {
				mainView.scrollBar.scrollPosition = mainView.scrollBar.maxScrollPosition;
			},0);
			return this;
		}
	}
}
