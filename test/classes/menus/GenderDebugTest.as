package classes.menus 
{
	import classes.Player;
	import classes.internals.GuiOutput;
	import classes.lists.BreastCup;
	
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.*;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	public class GenderDebugTest 
	{
		private var full:Player;
		private var fullyEquippedPlayer: GenderDebug;
		
		private var empty:Player;
		private var noEquipmentPlayer:GenderDebug;
		
		private var hasExited: Boolean;
		
		public function GenderDebugTest() 
		{
			hasExited = false;
			
			full = new Player();
			full.clearGender();
			full.createCock();
			full.createCock();
			full.createVagina();
			full.createVagina();
			full.createBreastRow(BreastCup.B);
			full.createBreastRow(BreastCup.B);
			full.balls = 4;
			
			empty = new Player();
			empty.clearGender();
			
			fullyEquippedPlayer = new GenderDebug(new DummyGUI(), new DummyOutput(), full, exitFunction);
			noEquipmentPlayer = new GenderDebug(new DummyGUI(), new DummyOutput(), empty, exitFunction);
		}
		
		private function exitFunction():void {
			hasExited = true;
		}
		
		[Test]
		public function buttonName(): void {
			assertThat(fullyEquippedPlayer.getButtonText(), equalTo(GenderDebug.BUTTON_NAME));
		}
		
		[Test]
		public function buttonHint(): void {
			assertThat(fullyEquippedPlayer.getButtonHint(), equalTo(GenderDebug.BUTTON_HINT));
		}
		
		[Test]
		public function removeVaginas(): void {
			fullyEquippedPlayer.removeVaginas();
			
			assertThat(full.hasVagina(), equalTo(false));
		}
		
		[Test]
		public function removeCocks(): void {
			fullyEquippedPlayer.removeCocks();
			
			assertThat(full.hasCock(), equalTo(false));
		}
		
		[Test]
		public function removeSomeBalls(): void {
			fullyEquippedPlayer.removeBalls();
			
			assertThat(full.balls, equalTo(2));
		}
		
		[Test]
		public function removeAllBalls(): void {
			fullyEquippedPlayer.removeBalls();
			fullyEquippedPlayer.removeBalls();
			
			assertThat(full.balls, equalTo(0));
		}
		
		[Test]
		public function removeBreasts(): void {
			fullyEquippedPlayer.removeBreasts();
			
			assertThat(full.hasBreasts(), equalTo(false));
		}
		
		[Test]
		public function removeBreastsWithNoBreasts(): void {
			noEquipmentPlayer.removeBreasts();
			
			assertThat(empty.hasBreasts(), equalTo(false));
		}
		
		[Test]
		public function addVagina(): void {
			noEquipmentPlayer.addVagina();
			
			assertThat(empty.hasVagina(), equalTo(true));
		}
		
		[Test]
		public function addCock(): void {
			noEquipmentPlayer.addCock();
			
			assertThat(empty.hasCock(), equalTo(true));
		}
		
		[Test]
		public function addSomeBalls(): void {
			noEquipmentPlayer.addBalls();
			
			assertThat(empty.balls, equalTo(2));
		}
		
		[Test]
		public function addMoreBalls(): void {
			noEquipmentPlayer.addBalls();
			noEquipmentPlayer.addBalls();
			
			assertThat(empty.balls, equalTo(4));
		}
		
		[Test]
		public function addBreasts(): void {
			noEquipmentPlayer.addBreasts();
			
			assertThat(empty.hasBreasts(), equalTo(true));
		}
	}
}

import classes.internals.GuiOutput;
import classes.internals.GuiInput;
import coc.view.CoCButton;

class DummyGUI implements GuiInput {
	public function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):CoCButton 
	{
		// addButton stub
		return null;
	}
	
	public function menu():void 
	{
		// menu stub
	}
}

class DummyOutput implements GuiOutput {
	public function text(text:String):GuiOutput 
	{
		//text stub
		return this;
	}
	
	public function flush():void 
	{
		//flush stub
	}
	
	public function header(headLine:String):GuiOutput 
	{
		//header stub
		return this;
	}
	
	public function clear(hideMenuButtons:Boolean = false):GuiOutput 
	{
		//clear stub
		return this;
	}
}
