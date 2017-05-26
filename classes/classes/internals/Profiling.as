/**
 * Created by aimozg on 13.05.2017.
 */
package classes.internals {
import mx.logging.ILogger;

public class Profiling {
	function Profiling() {
	}

	private static const PF_LOGGER:ILogger        = LoggerFactory.getLogger(Profiling);
	private static var PF_DEPTH:int               = 0; // Callstack depth
	private static const PF_NAME:Array            = [];// Callstack method names
	private static const PF_START:Array           = [];// Callstack of Begin() times
	private static const PF_ARGS:Array            = [];// Callstack of method arguments
	private static const PF_COUNT:Object          = {};// method -> times called
	private static const PF_TIME:Object           = {};// method -> total execution time
	private static function shouldProfile(classname:String, methodName:String):Boolean {
		return true;
	}
	private static function shouldReportProfiling(classname:String, origMethodName:String, dt:Number, pfcount:int):Boolean {
		return dt > 100;
	}
	public static function LogProfilingReport():void {
		for (var key:String in PF_COUNT) {
			var s:String    = "[PROFILE] ";
			s += key;
			var pfcount:int = PF_COUNT[key];
			s += ", called " + pfcount + " times";
			var pftime:*    = PF_TIME[key];
			s += ", total time ";
			if (pftime > 10000) s += Math.floor(pftime / 1000) + "s";
			else s += pftime + "ms";
			if (pftime > 0 && pfcount > 0) {
				s += ", avg time " + (pftime / pfcount).toFixed(1) + "ms";
			}
			PF_LOGGER.info(s);
		}
	}
	public static function Begin(classname:String, methodName:String, ...rest:Array):void {
		if (!shouldProfile(classname, methodName)) return;
		methodName           = classname + "." + methodName;
		PF_NAME[PF_DEPTH]    = methodName;
		PF_START[PF_DEPTH]   = new Date().getTime();
		PF_ARGS[PF_DEPTH]    = rest;
		PF_COUNT[methodName] = (PF_COUNT[methodName] | 0) + 1;
		PF_DEPTH++;
	}
	public static function End(classname:String, methodName:String):void {
		if (!shouldProfile(classname, methodName)) return;
		var origMethodName:String = methodName;
		methodName                = classname + "." + methodName;
		var t1:Number             = new Date().getTime();
		PF_DEPTH--;
		while (PF_DEPTH >= 0 && PF_NAME[PF_DEPTH] != methodName) {
			PF_LOGGER.error("[ERROR] Inconsistent callstack, expected '" + methodName + "', got '" + PF_NAME[PF_DEPTH] + "'(" +
							PF_ARGS[PF_DEPTH].join() + ")");
			PF_DEPTH--;
		}
		if (PF_DEPTH < 0) {
			PF_LOGGER.error("[ERROR] Empty callstack, expected '" + methodName + "'");
			PF_DEPTH = 0;
			return;
		}
		var dt:Number       = t1 - PF_START[PF_DEPTH];
		PF_TIME[methodName] = (PF_TIME[methodName] | 0) + dt;
		var pfcount:int     = PF_COUNT[methodName];
		var args:Array      = PF_ARGS[PF_DEPTH];
		if (shouldReportProfiling(classname, origMethodName, dt, pfcount)) {
			var s:String = "[PROFILE] ";
			for (var i:int = PF_DEPTH; i-- > 0;) s += "  ";
			s += methodName;
			if (args.length > 0) s += "(" + args.join(", ") + ")";
			s += " " + dt + "ms";
			if (pfcount > 1) {
				s += ", called " + pfcount + " times";
				var pftime:* = PF_TIME[methodName];
				if (pftime > 0) {
					s += ", total time ";
					if (pftime > 10000) s += Math.floor(pftime / 1000) + "s";
					else s += pftime + "ms";
					s += ", avg time " + (pftime / pfcount).toFixed(1) + "ms";
				}
			}
			PF_LOGGER.info(s);
		}
	}
}
}
