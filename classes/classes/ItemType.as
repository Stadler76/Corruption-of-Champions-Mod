/**
 * Created by aimozg on 09.01.14.
 */
package classes
{
	import classes.internals.Utils;
	import flash.utils.Dictionary;

	public class ItemType extends Utils
	{
		private static var ITEM_LIBRARY:Dictionary = new Dictionary();
		private static var ITEM_SHORT_LIBRARY:Dictionary = new Dictionary();
		public static const NOTHING:ItemType = new ItemType("NOTHING!");

		/**
		 * Looks up item by <b>ID</b>.
		 * @param	id 7-letter string that identifies an item.
		 * @return  ItemType
		 */
		public static function lookupItem(id:String):ItemType{
			return ITEM_LIBRARY[id];
		}

		/**
		 * Looks up item by <b>shortName</b>.
		 * @param	shortName The short name that was displayed on buttons.
		 * @return  ItemType
		 */
		public static function lookupItemByShort(shortName:String):ItemType{
			return ITEM_SHORT_LIBRARY[shortName];
		}

		public static function getItemLibrary():Dictionary
		{
			return ITEM_LIBRARY;
		}

		private var _id:String;
		protected var _shortName:String;
		protected var _longName:String;
		protected var _description:String;
		protected var _value:Number;

		protected var _degradable:Boolean = false; //True indicates degrades in durability.
		protected var _durability:Number = 0; //If it's greater than 0, when threshold is crossed, it will cause item to break.
		protected var _breaksInto:ItemType = null; //If the weapon breaks, turns into the specific item or vanish into nothing.
		
		/**
		 * Short name to be displayed on buttons
		 */
		public function get shortName():String
		{
			return _shortName;
		}

		/**
		 * A full name of the item, to be described in text
		 */
		public function get longName():String
		{
			return _longName;
		}

		/**
		 * Item base price
		 */
		public function get value():Number
		{
			return _value;
		}

		/**
		 * Detailed description to use on tooltips
		 */
		public function get description():String
		{
			return _description;
		}

		/**
		 * 7-character unique (across all the versions) string, representing that item type.
		 */
		public function get id():String
		{
			return _id;
		}

		public function ItemType(_id:String,_shortName:String=null,_longName:String=null,_value:Number=0,_description:String=null)
		{

			this._id = _id;
			this._shortName = _shortName || _id;
			this._longName = _longName || this.shortName;
			this._description = _description || this.longName;
			this._value = _value;
			if (ITEM_LIBRARY[_id] != null) {
				CoC_Settings.error("Duplicate itemid "+_id+", old item is "+(ITEM_LIBRARY[_id] as ItemType).longName);
			}
			if (ITEM_SHORT_LIBRARY[this.shortName] != null){
				CoC_Settings.error("WARNING: Item with duplicate shortname: '"+_id+"' and '"+(ITEM_SHORT_LIBRARY[this.shortName] as ItemType)._id+"' share "+this.shortName);
			}
			ITEM_LIBRARY[_id] = this;
			ITEM_SHORT_LIBRARY[this.shortName] = this;
		}

		protected function appendStatsDifference(diff:int):String {
			if (diff > 0)
				return " (<font color=\"#007f00\">+" + String(Math.abs(diff)) + "</font>)";
			else if (diff < 0)
				return " (<font color=\"#7f0000\">-" + String(Math.abs(diff)) + "</font>)";
			else
				return "";
		}

		public function toString():String
		{
			return "\""+_id+"\"";
		}
		
		public function getMaxStackSize():int {
			return 5;
		}
		
		//Durability & Degradation system
		public function isDegradable():Boolean {
			return this._degradable;
		}
		
		public function set durability(newValue:int):void {
			if (newValue > 0) this._degradable = true;
			this._durability = newValue;
		}
		public function get durability():int {
			return this._durability;
		}
		
		public function set degradesInto(newValue:ItemType):void {
			this._breaksInto = newValue;
		}
		public function get degradesInto():ItemType {
			return this._breaksInto;
		}
	}
}
