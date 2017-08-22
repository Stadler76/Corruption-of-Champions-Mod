/**
 * Coded by aimozg on 28.07.2017.
 */
package coc.view.charview {
import classes.internals.LoggerFactory;

import coc.view.Color;

import mx.logging.ILogger;

public class KeyColor {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(KeyColor);
	private var _src:uint;
	private var _base:String;
	private var tfs:/*String*/Array;
	public function KeyColor(src:uint, base:String, tf:String) {
		this._src  = src;
		this._base = base;
		if (tf) this.tfs = tf.split(";");
		else this.tfs = [];
	}
	public function transform(baseValue:uint):uint {
		for each (var tf:String in tfs) {
			var fn:Array      = tf.match(/^(\w+)\(([\d.]+)\)/);
			var fname:String  = fn ? fn[1] : undefined;
			var fvalue:Number = fn ? fn[2] : undefined;
			switch (fname) {
				case "darken":
					baseValue = Color.darken(baseValue, fvalue);
					break;
				case "lighten":
					baseValue = Color.lighten(baseValue, fvalue);
					break;
				default:
					LOGGER.error("Invalid color transform '" + tf + "'");
					break;
			}
		}
		return baseValue;
	}
	public function get src():uint {
		return _src;
	}
	public function get base():String {
		return _base;
	}
}
}
