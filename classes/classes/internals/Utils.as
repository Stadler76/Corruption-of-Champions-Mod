/**
 * Created by aimozg on 18.01.14.
 */
package classes.internals
{
	import classes.*;
	import coc.script.Eval;
	import classes.internals.LoggerFactory;
	import mx.logging.ILogger;
	import classes.internals.ActionScriptRNG;
	
	public class Utils extends Object
	{
		private static const LOGGER:ILogger = LoggerFactory.getLogger(Utils);
		
		private static const NUMBER_WORDS_NORMAL:Array		= ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"];
		private static const NUMBER_WORDS_CAPITAL:Array		= ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
		private static const NUMBER_WORDS_POSITIONAL:Array	= ["zeroth", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth"];

		/**
		 * Default RNG instance. Uses Utils.rand internally.
		 */
		public static const DEFAULT_RNG:RandomNumberGenerator = new ActionScriptRNG();
		
		public function Utils()
		{
		}
		
		// curryFunction(f,args1)(args2)=f(args1.concat(args2))
		// e.g. curryFunction(f,x,y)(z,w) = f(x,y,z,w)
		public static function curry(func:Function,...args):Function
		{
			if (func == null) CoC_Settings.error("carryFunction(null,"+args+")");
			return function (...args2):*{
				return func.apply(null,args.concat(args2));
			};
		}
		public static function bindThis(func:Function,thiz:Object):Function {
			return function(...args2):* {
				return func.apply(thiz,args2);
			}
		}
		public static function formatStringArray(stringList:Array):String { //Changes an array of values into "1", "1 and 2" or "1, (x, )y and z"
			switch (stringList.length) {
				case  0: return "";
				case  1: return stringList[0];
				case  2: return stringList[0] + " and " + stringList[1];
				default:
			}
			var concat:String = stringList[0];
			for (var x:int = 1; x < stringList.length - 1; x++) concat += ", " + stringList[x];
			return concat + " and " + stringList[stringList.length - 1];
		}
		public static function stringOr(input:*,def:String=""):String {
			return (input is String) ? input : def;
		}
		public static function intOr(input:*,def:int=0):int {
			return (input is int) ? input :
					(input is Number) ? input|0 : def;
		}
		public static function numberOr(input:*,def:Number=0):Number {
			return (input is Number) ? input : def;
		}
		public static function objectOr(input:*,def:Object=null):Object {
			return (input is Object && input !== null) ? input : def;
		}
		public static function boundInt(min:int, x:int, max:int):int {
			return x < min ? min : x > max ? max : x;
		}
		public static function boundFloat(min:Number, x:Number, max:Number):Number {
			if (!isFinite(x)) return min;
			return x < min ? min : x > max ? max : x;
		}
		public static function ipow(base:int,exponent:int):int {
			if (exponent<0) return 0;
			var x:int=1;
			while(exponent-->0) x*=base;
			return x;
		}
		/**
		 * Round (value) to (decimals) decimal digits
		 */
		public static function round(value:Number,decimals:int=0):Number {
			if (decimals<=0) return Math.round(value);
			var factor:Number = ipow(10,decimals);
			return Math.round(value*factor)/factor;
		}
		/**
		 * Round (value) up to (decimals) decimal digits
		 */
		public static function ceil(value:Number,decimals:int=0):Number {
			if (decimals<=0) return Math.ceil(value);
			var factor:Number = ipow(10,decimals);
			return Math.ceil(value*factor)/factor;
		}
		/**
		 * Round (value) down to (decimals) decimal digits
		 */
		public static function floor(value:Number,decimals:int=0):Number {
			if (decimals<=0) return Math.floor(value);
			var factor:Number = ipow(10,decimals);
			return Math.floor(value*factor)/factor;
		}
		/**
		 * Deleting obj[key] with default.
		 *
		 * If `key` in `obj`: return `obj[key]` and delete `obj[key]`
		 * Otherwise return `defaultValue`
		 */
		public static function moveValue(obj:Object,key:String,defaultValue:*):* {
			if (key in obj) {
				defaultValue = obj[key];
				delete obj[key];
			}
			return defaultValue;
		}
		/**
		 * Performs a shallow copy of properties from `src` to `dest`, then from `srcRest` to `dest`
		 * A `hasOwnProperties` check is performed.
		 */
		public static function extend(dest:Object, src:Object, ...srcRest:Array):Object {
			srcRest.unshift(src);
			for each(src in srcRest) {
				for (var k:String in src) {
					if (src.hasOwnProperty(k)) dest[k] = src[k];
				}
			}
			return dest;
		}
		/**
		 * Returns a shallow copy of `src` ownProperties
		 */
		public static function shallowCopy(src:Object):Object {
			return copyObject({},src);
		}
		/**
		 * Performs a shallow copy of properties from `src` to `dest`.
		 * If `properties` is supplied, only listed properties are copied.
		 * If not, all ownProperties of `src` are copied.
		 *
		 * @param properties array of property descriptors:
		 * <ul><li><code>key:String</code>
		 *     =&gt; <code>dest[key] = src.key]</code></li>
		 *     <li><code>[dkey:String, skey:String]</code>
		 *     =&gt; <code>dest[dkey] = src[skey]</code>
		 *     <li>object with properties:
		 *         <ul><li><code>skey:String, dkey:String</code> or <code>key:String</code></li>
		 *         <li>(optional) <code>'default':*|Function</code> to provide default value.
		 *         If function, called with no arguments</li></ul>
		 * </ul>
		 * @return dest
		 */
		public static function copyObject(dest:Object, src:Object,...properties:Array):Object {
			return copyObjectEx(dest, src, properties, true);
		}
		/**
		 * @see Utils.copyObject
		 * @param forward if true, use <code>dest[dkey]</code> and <code>src[skey]</code>.
		 * if false, use <code>dest[skey]</code> and <code>src[dkey]</code>.
		 * This option is useful when you have one set of descriptors to use it in both directions
		 * @param ignoreErrors If assignment throws an error, continue to next property.
		 * @return dest
		 */
		public static function copyObjectEx(dest:Object, src:Object, properties:Array, forward:Boolean = true, ignoreErrors:Boolean = false):Object {
			if (properties.length == 0) return extend(dest,src);
			for each (var pd:* in properties) {
				var skey:String,dkey:String,v:*;
				var def:*,hasDefault:Boolean=false;
				if (pd is String) {
					skey = pd;
					dkey = pd;
				} else if (pd is Array) {
					if (pd.length==2) {
						if (forward) {
							dkey = pd[0];
							skey = pd[1];
						}else {
							dkey = pd[1];
							skey = pd[0];
						}
					} 
				} else if (pd is Object) {
					if ("key" in pd) {
						skey = dkey = pd.key;
					} else if ("skey" in pd && "dkey" in pd) {
						skey = pd.skey;
						dkey = pd.dkey;
					} else {
						LOGGER.warn("Missing 'key' or 'skey'+'dkey' in property descriptor {0}", pd);
						continue;
					}
					if (!forward) {
						// we can't do it in the assignment below because of the check
						var tmp:String = skey;
						skey = dkey;
						dkey = tmp;
					}
					if ("default" in pd) {
						def = pd["default"];
						hasDefault = true;
					}
				}
				if (skey in src) {
					v = src[skey];
				} else if (hasDefault) {
					if (def is Function) v = def();
					else v = def();
				} else continue;
				try {
					dest[dkey] = v;
				} catch (e:Error) {
					if (!ignoreErrors) throw e;
				}
			}
			return dest;
		}
		/**
		 * [ [key1,value1], [key2, value2], ... ] -> { key1: value1, key2: value2, ... }
		 */
		public static function createMapFromPairs(src:Array):Object {
			return multipleMapsFromPairs(src)[0];
		}
		/**
		 * [ [key1, value1_1, value1_2, ...],
		 *   [key2, value2_1, value2_2, ...], ... ]
		 *   ->
		 * [ { key1: value1_1,
		 *     key2: value2_1, ...
		 *   }, {
		 *     key1: value1_2,
		 *     key2: value2_2, ...
		 *   }, ... ]
		 */
		public static function multipleMapsFromPairs(src:Array):Array {
			var results:Array = [{}];
			for each(var tuple:Array in src) {
				while (results.length < tuple.length-1) results.push({});
				var key:* = tuple[0];
				for (var i:int = 1; i<tuple.length; i++) results[i-1][key] = tuple[i];
			}
			return results;
		}

		/**
		 * Convert a mixed array to an array of strings
		 *
		 * Some string lists (color lists for example) may contain strings and arrays containing 2+ strings.
		 * e. g.: ["blue", "green", ["black", "white", "gray"], ["red", "orange"], "blue"]
		 * With this method such an array would be converted to contain only string.
		 * So the above example would return:
		 * ["blue", "green", "black, white and gray", "red and orange", "blue"]
		 *
		 * @param   list  An array with mixed strings and arrays of strings
		 * @return  An array of strings
		 */
		public static function convertMixedToStringArray(list:Array):Array
		{
			var returnArray:Array = [];
			for (var i:String in list)
				returnArray.push((list[i] is Array) ? formatStringArray(list[i]) : list[i]);

			return returnArray;
		}

		public static function isObject(val:*):Boolean
		{
			return typeof val == "object" && val != null;
		}

		public static function num2Text(number:int):String {
			if (number >= 0 && number <= 10) return NUMBER_WORDS_NORMAL[number];
			return number.toString();
		}
		
		public static function num2Text2(number:int):String {
			if (number < 0) return number.toString(); //Can't really have the -10th of something
			if (number <= 10) return NUMBER_WORDS_POSITIONAL[number];
			
			return number.toString() + "th";
		}
		
		public static function Num2Text(number:int):String {
			if (number >= 0 && number <= 10) return NUMBER_WORDS_CAPITAL[number];
			return number.toString();
		}
		
		public static function addComma(num:int):String{
			var str:String = "";
			if (num <= 0) return "0";
			while (num>0){
				var tmp:uint = num % 1000;
				str = ( num > 999 ?"," + (tmp < 100 ? ( tmp < 10 ? "00": "0"): ""): "") + tmp + str;
				num = num / 1000;
			}
			return str;
		}
		
		public static function capitalizeFirstLetter(string:String):String {
			return (string.substr(0, 1).toUpperCase() + string.substr(1));
		}
		
		/**
		 * Basically, you pass an arbitrary-length list of arguments, and it returns one of them at random. Accepts any type.
		 * Can also accept a *single* array of items, in which case it picks from the array instead.
		 * This lets you pre-construct the argument, to make things cleaner
		 * 
		 * @param	...args arguments to pick from
		 * @return a randomly selected argument
		 */
		public static function randomChoice(...args):*
		{
			var tar:Array;
			
			if (args.length == 1 && args[0] is Array) tar = args[0];
			else if (args.length > 1) tar = args;
			else throw new Error("RandomInCollection could not determine usage pattern.");
			
			return tar[rand(tar.length)];
		}
		
		/**
		 * Utility function to search for a specific value within a target array or collection of values.
		 * Collection can be supplied either as an existing array or as varargs:
		 * ex: 	InCollection(myValue, myArray)
		 * 		InCollection(myValue, myPossibleValue1, myPossibleValue2, myPossibleValue3)
		 * @param	tar			Target value to search for
		 * @param	... args	Collection to look in
		 * @return				Boolean true/false if found/not found.
		 */
		public static function InCollection(tar:*, ... args):Boolean
		{
			if (args.length == 0) return false;
			
			var collection:*;
			
			for (var ii:int = 0; ii < args.length; ii++)
			{
				collection = args[ii];
				
				if (!(collection is Array))
				{
					if (tar == collection) return true;
				}
				else
				{
					for (var i:int = 0; i < collection.length; i++)
					{
						if (tar == collection[i]) return true;
					}
				}
			}
			
			return false;
		}
		
		/**
		 * Generate a random number from 0 to max - 1 inclusive.
		 * @param	max the upper limit for the generated number
		 * @return a number from 0 to max - 1 inclusive
		 */
		public static function rand(max:Number):int
		{
			return int(Math.random() * max);
		}
		public static function trueOnceInN(n:Number):Boolean
		{
			return Math.random()*n < 1;
		}

		public static function validateNonNegativeNumberFields(o:Object, func:String, nnf:Array):String
		{
			var error:String = "";
			var propExists:Boolean;
			var fieldRef:*;
			for each (var field:String in nnf) {
				try {
					var value:* = Eval.eval(o, field);
					if (value === undefined || !(value is Number)) error += "Misspelling in "+func+".nnf: '"+field+"'. ";
					else if (value === null) error += "Null '"+field+"'. ";
					else if (value < 0) error += "Negative '"+field+"'. ";
				} catch (e:Error) {
					error += "Error calling eval on '"+func+"': "+e.message+". ";
				}
			}
			return error;
		}
		
		public static function validateNonEmptyStringFields(o:Object, func:String, nef:Array):String
		{
			var error:String = "";
			var propExists:Boolean;
			var fieldRef:*;
			for each (var field:String in nef) {
				try {
					var value:* = Eval.eval(o, field);
					if (value === undefined || !(value is String)) error += "Misspelling in " + func + ".nef: '" + field + "'. ";
					else if (value == null) error += "Null '" + field + "'. ";
					else if (value == "") error += "Empty '" + field + "'. ";
				} catch (e:Error) {
					error += "Error calling eval on '"+func+"': "+e.message+". ";
				}
			}
			return error;
		}
		/**
		 * numberOfThings(0,"brain") = "no brains"
		 * numberOfThings(1,"head") = "one head"
		 * numberOfThings(2,"tail") = "2 tails"
		 * numberOfThings(3,"hoof","hooves") = "3 hooves"
		 */
		public static function numberOfThings(n:int, name:String, pluralForm:String = null):String
		{
			pluralForm = pluralForm || (name + "s");
			if (n == 0) return "no " + pluralForm;
			if (n == 1) return "one " + name;
			return n + " " + pluralForm;
		}
		public static function repeatString(s:String,n:int):String {
			var rslt:String = "";
			while (n-->0) rslt += s;
			return rslt;
		}
	}
}
