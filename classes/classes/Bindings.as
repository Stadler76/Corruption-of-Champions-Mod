package classes 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import coc.view.MainView;
	import flash.net.SharedObject;

	/**
	 * class to relocate ControlBindings-code into single method-calls
	 * @author Stadler76
	 */
	public class Bindings 
	{
		public function get game():CoC { return kGAMECLASS; }
		public function get flags():DefaultDict { return game.flags; }

		public function Bindings() {}

		public function execQuickSave(slot:int):void
		{
			if (game.mainView.menuButtonIsVisible(MainView.MENU_DATA) && game.player.str > 0) {
				var slotX:String = "CoC_" + slot;
				if (flags[kFLAGS.HARDCORE_MODE] > 0) slotX = flags[kFLAGS.HARDCORE_SLOT];
				var doQuickSave:Function = function():void {
					game.mainView.nameBox.text = "";
					game.saves.saveGame(slotX);
					game.clearOutput();
					game.outputText("Game saved to " + slotX + "!");
					kGAMECLASS.output.doNext(game.playerMenu);
				};
				if (flags[kFLAGS.DISABLE_QUICKSAVE_CONFIRM] !== 0) {
					doQuickSave();
					return;
				}
				game.clearOutput();
				game.outputText("You are about to quicksave the current game to <b>" + slotX + "</b>\n\nAre you sure?");
				kGAMECLASS.output.menu();
				kGAMECLASS.output.addButton(0, "No", game.playerMenu);
				kGAMECLASS.output.addButton(1, "Yes", doQuickSave);
			}
		}

		public function execQuickLoad(slot:uint):void
		{
			if (game.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
				var saveFile:SharedObject = SharedObject.getLocal("CoC_" + slot, "/");
				var doQuickLoad:Function = function():void {
					if (game.saves.loadGame("CoC_" + slot)) {
						kGAMECLASS.output.showStats();
						kGAMECLASS.output.statScreenRefresh();
						game.clearOutput();
						game.outputText("Slot " + slot + " Loaded!");
						kGAMECLASS.output.doNext(game.playerMenu);
					}
				};
				if (saveFile.data.exists) {
					if (game.player.str === 0 || flags[kFLAGS.DISABLE_QUICKLOAD_CONFIRM] !== 0) {
						doQuickLoad();
						return;
					}
					game.clearOutput();
					game.outputText("You are about to quickload the current game from slot <b>" + slot + "</b>\n\nAre you sure?");
					kGAMECLASS.output.menu();
					kGAMECLASS.output.addButton(0, "No", game.playerMenu);
					kGAMECLASS.output.addButton(1, "Yes", doQuickLoad);
				}
			}
		}
	}
}
