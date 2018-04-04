/**
 * Style.as
 * Keith Peters
 * version 0.9.10
 * 
 * A collection of style variables used by the components.
 * If you want to customize the colors of your components, change these values BEFORE instantiating any components.
 * 
 * Copyright (c) 2011 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package com.bit101.components
{

	public class Style
	{
		//All those privately declared static variables.
		private static var _textBackground:uint = 0xFFFFFF;
		private static var _background:uint = 0xCCCCCC;
		private static var _buttonFace:uint = 0xFFFFFF;
		private static var _buttonDown:uint = 0xEEEEEE;
		private static var _inputText:uint = 0x333333;
		private static var _labelText:uint = 0x666666;
		private static var _dropShadow:uint = 0x000000;
		private static var _panel:uint = 0xF3F3F3;
		private static var _progressBar:uint = 0xFFFFFF;
		private static var _listDefault:uint = 0xFFFFFF;
		private static var _listAlternate:uint = 0xF3F3F3;
		private static var _listSelected:uint = 0xCCCCCC;
		private static var _listRollover:uint = 0XDDDDDD;
		
		private static var _embedFonts:Boolean = true;
		private static var _fontName:String = "PF Ronda Seven";
		private static var _fontSize:Number = 10;
		
		public static const DARK:String = "dark";
		public static const LIGHT:String = "light";
		
		//Getter and setter functions.
		public static function set TEXT_BACKGROUND(newColor:uint):void { _textBackground = newColor; }
		public static function get TEXT_BACKGROUND():uint { return _textBackground; }
		
		public static function set BACKGROUND(newColor:uint):void { _background = newColor; }
		public static function get BACKGROUND():uint { return _background; }
		
		public static function set BUTTON_FACE(newColor:uint):void { _buttonFace = newColor; }
		public static function get BUTTON_FACE():uint { return _buttonFace; }
		
		public static function set BUTTON_DOWN(newColor:uint):void { _buttonDown = newColor; }
		public static function get BUTTON_DOWN():uint { return _buttonDown; }
		
		public static function set INPUT_TEXT(newColor:uint):void { _inputText = newColor; }
		public static function get INPUT_TEXT():uint { return _inputText; }
		
		public static function set LABEL_TEXT(newColor:uint):void { _labelText = newColor; }
		public static function get LABEL_TEXT():uint { return _labelText; }
		
		public static function set DROPSHADOW(newColor:uint):void { _dropShadow = newColor; }
		public static function get DROPSHADOW():uint { return _dropShadow; }
		
		public static function set PANEL(newColor:uint):void { _panel = newColor; }
		public static function get PANEL():uint { return _panel; }
		
		public static function set PROGRESS_BAR(newColor:uint):void { _progressBar = newColor; }
		public static function get PROGRESS_BAR():uint { return _progressBar; }
		
		public static function set LIST_DEFAULT(newColor:uint):void { _listDefault = newColor; }
		public static function get LIST_DEFAULT():uint { return _listDefault; }
		
		public static function set LIST_ALTERNATE(newColor:uint):void { _listAlternate = newColor; }
		public static function get LIST_ALTERNATE():uint { return _listAlternate; }
		
		public static function set LIST_SELECTED(newColor:uint):void { _listSelected = newColor; }
		public static function get LIST_SELECTED():uint { return _listSelected; }
		
		public static function set LIST_ROLLOVER(newColor:uint):void { _listRollover = newColor; }
		public static function get LIST_ROLLOVER():uint { return _listRollover; }
		
		public static function set embedFonts(newValue:Boolean):void { _embedFonts = newValue; }
		public static function get embedFonts():Boolean { return _embedFonts; }
		
		public static function set fontName(newValue:String):void { _fontName = newValue; }
		public static function get fontName():String { return _fontName; }
		
		public static function set fontSize(newValue:Number):void { _fontSize = newValue; }
		public static function get fontSize():Number { return _fontSize; }

		
		/**
		 * Applies a preset style as a list of color values. Should be called before creating any components.
		 */
		public static function setStyle(style:String):void
		{
			switch(style)
			{
				case DARK:
					Style.BACKGROUND = 0x444444;
					Style.BUTTON_FACE = 0x666666;
					Style.BUTTON_DOWN = 0x222222;
					Style.INPUT_TEXT = 0xBBBBBB;
					Style.LABEL_TEXT = 0xCCCCCC;
					Style.PANEL = 0x666666;
					Style.PROGRESS_BAR = 0x666666;
					Style.TEXT_BACKGROUND = 0x555555;
					Style.LIST_DEFAULT = 0x444444;
					Style.LIST_ALTERNATE = 0x393939;
					Style.LIST_SELECTED = 0x666666;
					Style.LIST_ROLLOVER = 0x777777;
					break;
				case LIGHT:
				default:
					Style.BACKGROUND = 0xCCCCCC;
					Style.BUTTON_FACE = 0xFFFFFF;
					Style.BUTTON_DOWN = 0xEEEEEE;
					Style.INPUT_TEXT = 0x333333;
					Style.LABEL_TEXT = 0x666666;
					Style.PANEL = 0xF3F3F3;
					Style.PROGRESS_BAR = 0xFFFFFF;
					Style.TEXT_BACKGROUND = 0xFFFFFF;
					Style.LIST_DEFAULT = 0xFFFFFF;
					Style.LIST_ALTERNATE = 0xF3F3F3;
					Style.LIST_SELECTED = 0xCCCCCC;
					Style.LIST_ROLLOVER = 0xDDDDDD;
					break;
			}
		}
	}
}