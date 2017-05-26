/**
 * Created by aimozg on 13.05.2017.
 */
package classes.internals.profiling {
import classes.internals.Profiling;

public function Begin(classname:String, methodName:String, ...rest:Array):void {
	Profiling.Begin.apply(null,[classname,methodName].concat(rest));
}
}
