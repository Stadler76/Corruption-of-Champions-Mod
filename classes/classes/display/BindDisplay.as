package classes.display 
{
	import coc.view.Block;
	import coc.view.CoCButton;
	import coc.view.MainView;
	import flash.text.TextField;
	
	/**
	 * Defines a composite display object of all the seperate components required to display a 
	 * single BoundControlMethod, its associated primary and secondary bindings with the buttons
	 * used to bind methods to new keys.
	 * @author Gedan
	 */
	public class BindDisplay extends Block
	{
		// Object components and settings
		private var _nameLabel:TextField;
		private var _buttons:Array = [];
		
		/**
		 * Create a new composite object, initilizing the label to be used for display, as well as the two
		 * buttons used for user interface.
		 * 
		 * @param	maxWidth	Defines the maximum available width that the control can consume for positining math
		 * @param	buttons		Defines the number of buttons to be generated
		 */
		public function BindDisplay(maxWidth:int, maxHeight:int = 40, buttons:int = 2) 
		{
			layoutConfig = {
				type: Block.LAYOUT_FLOW,
				cols: 1 + buttons,
				setWidth: true
			};
			width = maxWidth;
			height = maxHeight;
			_nameLabel = addTextField( {
				text:"THIS IS SOME KINDA CRAZY LABEL",
				width: 290,
				defaultTextFormat: {
					font: 'Times New Roman',
					size: 20,
					align: 'left'
				}
			});
			for (var i:int = 0; i < buttons; i++) {
				var button:CoCButton = new CoCButton({
					labelText: 'Unbound',
					bitmapClass: MainView.ButtonBackground0,
					callback: null
				})
				_buttons.push(button);
				addElement(button);
			}
		}
		
		public function addButton(label:String, cb:Function):CoCButton {
			var button:CoCButton = new CoCButton({
				labelText: label,
				bitmapClass: MainView.ButtonBackground0,
				callback: cb
			})
			_buttons.push(button);
			addElement(button);
			return button;
		}
		
		public function get htmlText():String { return _nameLabel.htmlText; }
		public function set htmlText(value:String):void { _nameLabel.htmlText = value; }
		
		public function get buttons():Array { return _buttons; }
		public function get label():TextField { return _nameLabel; }
	}

}