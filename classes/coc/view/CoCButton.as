package coc.view {

	/****
		coc.view.CoCButton

		note that although this stores its current tool tip text,
		it does not display the text.  That is taken care of
		by whoever owns this.

		The mouse event handlers are public to facilitate reaction to
		keyboard events.
	****/

import classes.ItemType;
import classes.internals.Utils;

	import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
	import flash.text.TextFormat;

	import flash.events.MouseEvent;

	public class CoCButton extends Block {

		[Embed(source='../../../res/ui/Shrewsbury-Titling_Bold.ttf',
				advancedAntiAliasing='true',
				fontName='ShrewsburyTitlingBold',
				embedAsCFF='false')]
		private static const ButtonLabelFont:Class;
		public static const ButtonLabelFontName:String = (new ButtonLabelFont() as Font).fontName;


		private var _labelField:TextField,
					_backgroundGraphic:BitmapDataSprite,
					_enabled:Boolean = true,
				_callback:Function = null,
				_preCallback:Function = null;

		public var toolTipHeader:String,
				   toolTipText:String;

		/**
		 * @param options  enabled, labelText, bitmapClass, callback
		 */
		public function CoCButton(options:Object = null):void {
			super();
			_backgroundGraphic = addBitmapDataSprite({
				stretch: true,
				width  : MainView.BTN_W,
				height : MainView.BTN_H
			});
			_labelField        = addTextField({
				width            : MainView.BTN_W,
				embedFonts       : true,
				y                : 8,
				height           : MainView.BTN_H - 8,
				defaultTextFormat: {
					font : ButtonLabelFontName,
					size : 18,
					align: 'center'
				}
			});

			this.mouseChildren = true;
			this.buttonMode    = true;
			this.visible       = true;
			UIUtils.setProperties(this, options);

			this.addEventListener(MouseEvent.ROLL_OVER, this.hover);
			this.addEventListener(MouseEvent.ROLL_OUT, this.dim);
			this.addEventListener(MouseEvent.CLICK, this.click);
		}



		//////// Mouse Events... ////////

		public function hover(event:MouseEvent = null):void {
			if (this._backgroundGraphic)
				this._backgroundGraphic.alpha = enabled ? 0.5 : 0.4;
		}

		public function dim(event:MouseEvent = null):void {
			if (this._backgroundGraphic)
				this._backgroundGraphic.alpha = enabled ? 1 : 0.4;
		}

		public function click(event:MouseEvent = null):void {
		if (!this.enabled) return;
		if (this._preCallback != null)
			this._preCallback(this);
			if (this._callback != null)
				this._callback();
		}



		//////// Getters and Setters ////////

		public function get enabled():Boolean {
			return _enabled;
		}

		public function set enabled(value:Boolean):void {
			_enabled                      = value;
			this._labelField.alpha        = value ? 1 : 0.4;
			this._backgroundGraphic.alpha = value ? 1 : 0.4;
		}

		public function get labelText():String {
			return this._labelField.text;
		}

		public function set labelText(value:String):void {
			this._labelField.text = value;
		}

		public function set bitmapClass(value:Class):void {
			_backgroundGraphic.bitmapClass = value;
		}
		
		public function get bitmapClass():Class {
			return null;
		}

		public function get callback():Function {
			return this._callback;
		}

		public function set callback(value:Function):void {
			this._callback = value;
		}

		public function get preCallback():Function {
			return _preCallback;
		}
		
		public function set preCallback(value:Function):void {
			_preCallback = value;
		}
		//////////// Builder functions
		/**
		 * Setup (text, callback, tooltip) and show enabled button. Removes all previously set options
		 * @return this
		 */
		public function show(text:String,callback:Function,toolTipText:String="",toolTipHeader:String=""):CoCButton {
			this.labelText     = text;
			this.callback      = callback;
			hint(toolTipText,toolTipHeader);
			this.visible       = true;
			this.enabled       = true;
			this.alpha         = 1;
			return this;
		}
		/**
		 * Setup (text, tooltip) and show disabled button. Removes all previously set options
		 * @return this
		 */
		public function showDisabled(text:String,toolTipText:String="",toolTipHeader:String=""):CoCButton {
			this.labelText     = text;
			this.callback      = null;
			hint(toolTipText,toolTipHeader);
			this.visible       = true;
			this.enabled       = false;
			this.alpha         = 1;
			return this;
		}
		/**
		 * Set text and tooltip. Don't change callback, enabled, visibility
		 * @return this
		 */
		public function text(text:String,toolTipText:String = "",toolTipHeader:String=""):CoCButton {
			this.labelText = text;
			hint(toolTipText,toolTipHeader);
			return this;
		}
		/**
		 * Set tooltip only. Don't change text, callback, enabled, visibility
		 * @return this
		 */
		public function hint(toolTipText:String = "",toolTipHeader:String=""):CoCButton {
			this.toolTipText   = toolTipText   || getToolTipText(this.labelText);
			this.toolTipHeader = toolTipHeader || getToolTipHeader(this.labelText);
			return this;
		}
		/**
		 * Disable if condition is true, optionally change tooltip. Does not un-hide button.
		 * @return this
		 */
		public function disableIf(condition:Boolean, toolTipText:String=null):CoCButton {
			enabled = !condition;
			if (toolTipText!==null) this.toolTipText = condition?toolTipText:"";
			return this;
		}
		/**
		 * Disable, optionally change tooltip. Does not un-hide button.
		 * @return this
		 */
		public function disable(toolTipText:String=null):CoCButton {
			enabled = false;
			if (toolTipText!==null) this.toolTipText = toolTipText;
			return this;
		}
		/**
		 * Set callback to fn(...args)
		 * @return this
		 */
		public function call(fn:Function,...args:Array):CoCButton {
			this.callback = Utils.curry.apply(null,args);
			return this;
		}
		/**
		 * Hide the button
		 * @return this
		 */
		public function hide():CoCButton {
			visible = false;
			return this;
		}

		public static function getToolTipHeader(buttonText:String):String
		{
			var toolTipHeader:String;

			if (buttonText.indexOf(" x") != -1)
			{
				buttonText = buttonText.split(" x")[0];
			}

			//Get items
			var itype:ItemType = ItemType.lookupItem(buttonText);
			var temp:String = "";
			if (itype != null) temp = itype.longName;
			itype = ItemType.lookupItemByShort(buttonText);
			if (itype != null) temp = itype.longName;
			if (temp != "") {
				temp = Utils.capitalizeFirstLetter(temp);
				toolTipHeader = temp;
			}

			//Set tooltip header to button.
			if (toolTipHeader == null) {
				toolTipHeader = buttonText;
			}

			return toolTipHeader;
		}

		// Returns a string or undefined.
		public static function getToolTipText(buttonText:String):String
		{
			var toolTipText :String;

			buttonText = buttonText || '';

			//Items
			//if (/^....... x\d+$/.test(buttonText)){
			//	buttonText = buttonText.substring(0,7);
			//}

			// Fuck your regex
			if (buttonText.indexOf(" x") != -1)
			{
				buttonText = buttonText.split(" x")[0];
			}

			var itype:ItemType = ItemType.lookupItem(buttonText);
			if (itype != null) toolTipText = itype.description;
			itype = ItemType.lookupItemByShort(buttonText);
			if (itype != null) toolTipText = itype.description;

			//------------
			// COMBAT
			//------------
			if (buttonText.indexOf("Defend") != -1) { //Not used at the moment.
				toolTipText = "Selecting defend will reduce the damage you take by 66 percent, but will not affect any lust incurred by your enemy's actions.";
			}
			//Urta's specials - MOVED
			//P. Special attacks - MOVED
			//M. Special attacks - MOVED

			//------------
			// MASTURBATION
			//------------
			//Masturbation Toys
			if (buttonText == "Masturbate") {
				toolTipText = "Selecting this option will make you attempt to manually masturbate in order to relieve your lust buildup.";
			}
			if (buttonText == "Meditate") {
				toolTipText = "Selecting this option will make you attempt to meditate in order to reduce lust and corruption.";
			}
			if (buttonText.indexOf("AN Stim-Belt") != -1) {
				toolTipText = "This is an all-natural self-stimulation belt.  The methods used to create such a pleasure device are unknown.  It seems to be organic in nature.";
			}
			if (buttonText.indexOf("Stim-Belt") != -1) {
				toolTipText = "This is a self-stimulation belt.  Commonly referred to as stim-belts, these are clockwork devices designed to pleasure the female anatomy.";
			}
			if (buttonText.indexOf("AN Onahole") != -1) {
				toolTipText = "An all-natural onahole, this device looks more like a bulbous creature than a sex-toy.  Nevertheless, the slick orifice it presents looks very inviting.";
			}
			if (buttonText.indexOf("D Onahole") != -1) {
				toolTipText = "This is a deluxe onahole, made of exceptional materials and with the finest craftsmanship in order to bring its user to the height of pleasure.";
			}
			if (buttonText.indexOf("Onahole") != -1) {
				toolTipText = "This is what is called an 'onahole'.  This device is a simple textured sleeve designed to fit around the male anatomy in a pleasurable way.";
			}
			if (buttonText.indexOf("Dual Belt") != -1) {
				toolTipText = "This is a strange masturbation device, meant to work every available avenue of stimulation.";
			}
			if (buttonText.indexOf("C. Pole") != -1) {
				toolTipText = "This 'centaur pole' as it's called appears to be a sex-toy designed for females of the equine persuasion.  Oddly, it's been sculpted to look like a giant imp, with an even bigger horse-cock.";
			}
			if (buttonText.indexOf("Fake Mare") != -1) {
				toolTipText = "This fake mare is made of metal and wood, but the anatomically correct vagina looks as soft and wet as any female centaur's.";
			}
			//Books - MOVED
			//------------
			// TITLE SCREEN
			//------------
			if (buttonText.indexOf("ASPLODE") != -1) {
				toolTipText = "MAKE SHIT ASPLODE";
			}
			return toolTipText;
		}
	}
}
