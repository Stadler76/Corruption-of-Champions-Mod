/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.CoC;
	import classes.CoC_Settings;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.ItemType;

	/**
	 * Represent item that can be used but does not necessarily disappears on use. Direct subclasses should overrride
	 * "useItem" method.
	 */
	public class Useable extends ItemType {
		
		public function Useable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null) {
			super(id, shortName, longName, value, description);
		}
		
		public function get game():CoC{
			return kGAMECLASS;
		}
		public function getGame():CoC{
			return kGAMECLASS;
		}

		public function clearOutput():void{
			kGAMECLASS.clearOutput();
		}
		public function outputText(text:String):void {
			kGAMECLASS.outputText(text);
		}
		
		public function set description(newDesc:String):void {
			this._description = newDesc;
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: ";
			if (shortName == "Condom" || shortName == "GldStat") desc += "Miscellaneous";
			else if (shortName == "Debug Wand") desc += "Miscellaneous (Cheat Item)";
			else desc += "Material";
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		public function canUse():Boolean { return game.prison.prisonCanUseItem(this); } //If an item cannot be used it should provide some description of why not
		
		public function useItem():Boolean {
			CoC_Settings.errorAMC("Useable", "useItem", id);
			return(false);
		}
		
		public function useText():void {} //Produces any text seen when using or equipping the item normally

		
	}
}
