package classes.menus 
{
	import classes.Player;
	import classes.internals.GuiOutput;
	import classes.internals.GuiInput;
	import classes.lists.BreastCup;
	import mx.utils.StringUtil;
	
	/**
	 * Debug menu to add / remove gender related parts.
	 */
	public class GenderDebug implements Menu 
	{
		public static const BUTTON_NAME:String = "Gender";
		public static const BUTTON_HINT:String = "Add and remove parts related to gender";
		
		private var player:Player;
		private var gui:GuiInput;
		private var output:GuiOutput;
		private var onMenuExit:Function;
		
		public function GenderDebug(gui:GuiInput, output:GuiOutput, player:Player, onMenuExit:Function)  
		{
			this.player = player;
			this.gui = gui;
			this.output = output;
			this.onMenuExit = onMenuExit;
		}
		
		private function printMenuHeader():void {
			output.clear();
			
			output.header("Gender debug menu");
			output.text("<b>Use at your own risk!</b>\n");
			output.text("This menu allows you to create game states that are not possible during normal gameplay, you might want to create a backup save just to be sure.\n\n");
		}
		
		private function printGenderStats():void {
			output.text("Current body state:\n\n");
			
			output.text(StringUtil.substitute("You have {0} vagina(s)\n", player.vaginas.length));
			output.text(StringUtil.substitute("You have {0} cock(s)\n", player.cocks.length));
			output.text(StringUtil.substitute("You have {0} ball(s)\n", player.balls));
			output.text(StringUtil.substitute("You have {0} breast row(s)\n", player.breastRows.length));
		}
		
		private function refreshMenuText():void {
			printMenuHeader();
			printGenderStats();
			output.flush();
		}
		
		public function enter():void 
		{
			refreshMenuText();
			gui.menu();
			
			gui.addButton(0, "Remove Vaginas", removeVaginas).hint("Removes ALL vaginas");
			gui.addButton(1, "Remove Cocks", removeCocks).hint("Removes ALL cocks");
			gui.addButton(2, "Remove Balls", removeBalls).hint("Removes 2 balls");
			gui.addButton(3, "Remove Breasts", removeBreasts).hint("Removes ALL breasts");
			
			gui.addButton(5, "Add Vagina", addVagina);
			gui.addButton(6, "Add Cock", addCock);
			gui.addButton(7, "Add Balls", addBalls).hint("Adds 2 balls");
			gui.addButton(8, "Add Breasts", addBreasts).hint("Adds a row of breasts");
			
			gui.addButton(9, "Back", onMenuExit);
		}
		
		public function getButtonText():String 
		{
			return BUTTON_NAME;
		}
		
		public function getButtonHint():String 
		{
			return BUTTON_HINT;
		}
		
		public function removeVaginas(): void {
			while (player.hasVagina()) {
				player.removeVagina();
			}
			
			refreshMenuText();
		}
		
		public function removeCocks(): void {
			while (player.hasCock()) {
				player.removeCock(0, 1);
			}
			
			refreshMenuText();
		}
		
		public function addCock(): void {
			player.createCock();
			refreshMenuText();
		}
		
		public function addVagina(): void {
			player.createVagina();
			refreshMenuText();
		}
		
		public function removeBalls(): void {
			player.balls -= 2;
			
			if (player.balls < 0) {
				player.balls = 0;
			}
			
			refreshMenuText();
		}
		
		public function addBalls(): void {
			player.balls += 2;
			refreshMenuText();
		}
		
		public function removeBreasts():void {
			while (player.breastRows.length > 1) {
				player.removeBreastRow(0, 1);
			}
			
			// make sure the last pair of breasts are flat
			if (player.hasBreasts()) {
				player.breastRows[0].breastRating = 0;
			}
			
			refreshMenuText();
		}
		
		public function addBreasts(): void {
			player.createBreastRow(BreastCup.A);
			refreshMenuText();
		}
	}
}
