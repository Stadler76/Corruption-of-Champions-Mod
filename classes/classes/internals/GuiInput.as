package classes.internals 
{
	import coc.view.CoCButton;
	/**
	 * Using 'Extract interface' to use GUI functions without having to drag the CoC class, and with it,
	 * the entire fucking game, into a unit test.
	 */
	public interface GuiInput 
	{
		function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):CoCButton;
		
		function menu():void;
	}
}
