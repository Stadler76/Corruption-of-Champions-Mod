package classes 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.Scenes.*;
	import classes.Scenes.Combat.*;
	import classes.Scenes.Dungeons.LethicesKeep.*;
	import classes.Scenes.Places.*;
	import classes.internals.*;
	import coc.view.*;
	/**
	 * Quick hacky method to wrap new content in a class-based structure
	 * BaseContent acts as an access wrapper around CoC, enabling children of BaseContent to interact with
	 * function instances/properties of CoC in the same manner older content does with the minimal amount
	 * of modification.
	 * Also this means we might start being able to get IDE autocomplete shit working again! Huzzah!
	 * @author Gedan
	 */
	public class BaseContent extends Utils
	{
		public function BaseContent()
		{
			
		}
		protected function getGame():CoC
		{
			return kGAMECLASS;
		}

		protected function cheatTime(time:Number, needNext:Boolean = false):void
		{
			kGAMECLASS.cheatTime(time, needNext);
		}

		protected function get output():Output
		{
			return kGAMECLASS.output;
		}

		protected function get credits():Credits
		{
			return kGAMECLASS.credits;
		}

		protected function get timeQ():Number
		{
			return kGAMECLASS.timeQ;
		}

		protected function get camp():Camp {
			return kGAMECLASS.camp;
		}
		
		protected function get ingnam():Ingnam {
			return kGAMECLASS.ingnam;
		}
		
		protected function get prison():Prison {
			return kGAMECLASS.prison;
		}
		
		protected function get lethicesKeep():LethicesKeep {
			return kGAMECLASS.lethicesKeep;
		}

		protected function get combat():Combat
		{
			return kGAMECLASS.combat;
		}

		protected function get mutations():Mutations
		{
			return kGAMECLASS.mutations;
		}

		public function goNext(time:Number,defNext:Boolean):Boolean
		{
			return kGAMECLASS.goNext(time,defNext);
		}
		
		protected function awardAchievement(title:String, achievement:int, display:Boolean = true, nl:Boolean = false, nl2:Boolean = true):void
		{
			return kGAMECLASS.awardAchievement(title, achievement, display, nl, nl2);
		}
		
		protected function unlockCodexEntry(title:String, codexEntry:int, nlBefore:Boolean = true, nlAfter:Boolean = false):void
		{
			return kGAMECLASS.unlockCodexEntry(title, codexEntry, nlBefore, nlAfter);
		}
		
		//SEASONAL EVENTS!
		protected function isHalloween():Boolean {
			return kGAMECLASS.fera.isItHalloween();
		}

		protected function isValentine():Boolean {
			return kGAMECLASS.valentines.isItValentine();
		}

		protected function isHolidays():Boolean {
			return kGAMECLASS.xmas.isItHolidays();
		}

		protected function isEaster():Boolean {
			return kGAMECLASS.plains.bunnyGirl.isItEaster();
		}

		protected function isThanksgiving():Boolean {
			return kGAMECLASS.thanksgiving.isItThanksgiving();
		}

		protected function isAprilFools():Boolean {
			return kGAMECLASS.aprilFools.isItAprilFools();
		}
		
		protected function get date():Date
		{
			return kGAMECLASS.date;
		}

		//Curse you, CoC updates!
		protected function get inDungeon():Boolean
		{
			return kGAMECLASS.inDungeon;
		}
		protected function set inDungeon(v:Boolean):void
		{
			kGAMECLASS.inDungeon = v;
		}
		
		protected function get inRoomedDungeon():Boolean
		{
			return kGAMECLASS.inRoomedDungeon;
		}
		protected function set inRoomedDungeon(v:Boolean):void
		{
			kGAMECLASS.inRoomedDungeon = v;
		}
		
		protected function get inRoomedDungeonResume():Function
		{
			return kGAMECLASS.inRoomedDungeonResume;
		}
		protected function set inRoomedDungeonResume(v:Function):void
		{
			kGAMECLASS.inRoomedDungeonResume = v;
		}

		protected function get inRoomedDungeonName():String
		{
			return kGAMECLASS.inRoomedDungeonName;
		}
		protected function set inRoomedDungeonName(v:String):void
		{
			kGAMECLASS.inRoomedDungeonName = v;
		}
		
		/**
		 * Displays the sprite on the lower-left corner.
		 * Can accept frame index or SpriteDb.s_xxx (class extends Bitmap)
		 * */
		protected function spriteSelect(choice:Object = 0):void
		{
			kGAMECLASS.spriteSelect(choice);
		}
		
		/** Refreshes the stats panel. */
		protected function statScreenRefresh():void
		{
			kGAMECLASS.output.statScreenRefresh();
		}
		
		/** Displays the stats panel. */
		protected function showStats():void
		{
			kGAMECLASS.output.showStats();
		}

		/** Hide the stats panel. */
		protected function hideStats():void
		{
			kGAMECLASS.output.hideStats();
		}
		
		/** Hide the up/down arrows. */
		protected function hideUpDown():void
		{
			kGAMECLASS.output.hideUpDown();
		}

		/** Create a function that will pass one argument. */
		protected function createCallBackFunction(func:Function, arg:*, arg2:* = null, arg3:* = null):Function
		{
			return kGAMECLASS.createCallBackFunction(func, arg, arg2, arg3);
		}

		protected function doSFWloss():Boolean {
			return kGAMECLASS.doSFWloss();
		}
		
		protected function isPeaceful():Boolean {
			return kGAMECLASS.isPeaceful();
		}
		
		/**
		 * Start a new combat.
		 * @param	monster_ The new monster to be initialized.
		 * @param	plotFight_ Determines if the fight is important. Also prevents randoms from overriding uniques.
		 */
		protected function startCombat(monster_:Monster,plotFight_:Boolean=false):void{
			kGAMECLASS.combat.beginCombat(monster_, plotFight_);
		}
		
		protected function startCombatImmediate(monster:Monster, _plotFight:Boolean = false):void
		{
			kGAMECLASS.combat.beginCombatImmediate(monster, _plotFight);
		}

		protected function displayHeader(text:String):void
		{
			kGAMECLASS.output.header(text);
		}
		
		// Needed in a few rare cases for dumping text coming from a source that can't properly escape it's brackets
		// (Mostly traceback printing, etc...)
		protected function rawOutputText(text:String):void
		{
			kGAMECLASS.output.raw(text);
		}

		protected function outputText(output:String):void
		{
			kGAMECLASS.output.text(output);
		}
		
		protected function clearOutput():void
		{
			kGAMECLASS.output.clear();
			kGAMECLASS.mainView.clearOutputText();
		}

		protected function doNext(eventNo:Function):void //Now typesafe
		{
			kGAMECLASS.output.doNext(eventNo);
		}
		
		/**
		 * Hides all bottom buttons.
		 * 
		 * <b>Note:</b> Calling this with open formatting tags can result in strange behaviour, 
		 * e.g. all text will be formatted instead of only a section.
		 */
		protected function menu():void
		{
			kGAMECLASS.output.menu();
		}

		protected function hideMenus():void
		{
			kGAMECLASS.output.hideMenus();
		}
		
		protected function doYesNo(eventYes:Function, eventNo:Function):void { //Now typesafe
			kGAMECLASS.output.doYesNo(eventYes, eventNo);
		}

		protected function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return kGAMECLASS.output.addButton(pos, text, func1, arg1, arg2, arg3, toolTipText, toolTipHeader);
		}
		
		protected function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return kGAMECLASS.output.addButtonDisabled(pos, text, toolTipText, toolTipHeader);
		}
		protected function addDisabledButton(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return kGAMECLASS.output.addButtonDisabled(pos, text, toolTipText, toolTipHeader);
		}
		protected function button(pos:int):CoCButton
		{
			return kGAMECLASS.output.button(pos);
		}
		
		protected function removeButton(arg:*):void
		{
			kGAMECLASS.output.removeButton(arg);
		}
		
		protected function openURL(url:String):void{
			return kGAMECLASS.openURL(url);
		}
		
		/**
		 * Apply statmods to the player. dynStats wraps the regular stats call, but supports "named" arguments of the form:
		 * 		"statname", value.
		 * Exclusively supports either long or short stat names with a single call.
		 * "str", "lib" "lus", "cor" etc
		 * "strength, "libido", lust", "corruption"
		 * Specify the stat you wish to modify and follow it with the value.
		 * Separate each stat and value with a comma, and each stat/value pair, again, with a comma.
		 * eg: dynStats("str", 10, "lust" -100); will add 10 to str and subtract 100 from lust
		 * Also support operators could be appended with + - * /=
		 * eg: dynStats("str+", 1, "tou-", 2, "spe*", 1.1, "int/", 2, "cor=", 0)
		 *     will add 1 to str, subtract 2 from tou, increase spe by 10%, decrease int by 50%, and set cor to 0
		 * 
		 * @param	... args
		 * @return Object of (newStat-oldStat) with keys str, tou, spe, int, lib, sen, lus, cor
		 */
		protected function dynStats(... args):Object
		{
			// Bullshit to unroll the incoming array
			return kGAMECLASS.dynStats.apply(null, args);
		}

		protected function silly():Boolean
		{
			return kGAMECLASS.silly();
		}
		
		protected function playerMenu():void { 
			kGAMECLASS.mainMenu.hideMainMenu();
			kGAMECLASS.playerMenu();
		}
		
		protected function get player():Player
		{
			return kGAMECLASS.player;
		}
		
		/**
		 * This is alias for player.
		 */
		protected function get pc():Player
		{
			return kGAMECLASS.player;
		}
		
		protected function set player(val:Player):void
		{
			kGAMECLASS.player = val;
		}
		
		protected function get player2():Player
		{
			return kGAMECLASS.player2;
		}
		
		protected function set player2(val:Player):void
		{
			kGAMECLASS.player2 = val;
		}
		
		protected function get debug():Boolean
		{
			return kGAMECLASS.debug;
		}
		
		protected function set debug(val:Boolean):void
		{
			kGAMECLASS.debug = val;
		}
		
		protected function get ver():String
		{
			return kGAMECLASS.ver;
		}
		
		protected function set ver(val:String):void
		{
			kGAMECLASS.ver = val;
		}
		
		protected function get images():ImageManager
		{
			return kGAMECLASS.images;
		}
		
		protected function set images(val:ImageManager):void
		{
			kGAMECLASS.images = val;
		}
		
		protected function get monster():Monster
		{
			return kGAMECLASS.monster;
		}
		
		/**
		 * This is alias for monster.
		 */
		protected function get enemy():Monster
		{
			return kGAMECLASS.monster;
		}
		
		protected function set monster(val:Monster):void
		{
			kGAMECLASS.monster = val;
		}

		protected function get consumables():ConsumableLib{
			return kGAMECLASS.consumables;
		}
		protected function get useables():UseableLib{
			return kGAMECLASS.useables;
		}
		protected function get weapons():WeaponLib{
			return kGAMECLASS.weapons;
		}
		protected function get armors():ArmorLib{
			return kGAMECLASS.armors;
		}
		protected function get jewelries():JewelryLib{
			return kGAMECLASS.jewelries;
		}
		protected function get shields():ShieldLib{
			return kGAMECLASS.shields;
		}
		protected function get undergarments():UndergarmentLib{
			return kGAMECLASS.undergarments;
		}
		protected function get inventory():Inventory{
			return kGAMECLASS.inventory;
		}
		
		protected function get time():Time
		{
			return kGAMECLASS.time;
		}
		
		protected function set time(val:Time):void
		{
			kGAMECLASS.time = val;
		}
		
		protected function get temp():int
		{
			return kGAMECLASS.temp;
		}
		
		protected function set temp(val:int):void
		{
			kGAMECLASS.temp = val;
		}
		
		protected function get args():Array
		{
			return kGAMECLASS.args;
		}
		
		protected function set args(val:Array):void
		{
			kGAMECLASS.args = val;
		}
		
		protected function get funcs():Array
		{
			return kGAMECLASS.funcs;
		}
		
		protected function set funcs(val:Array):void
		{
			kGAMECLASS.funcs = val;
		}
		
		protected function get mainView():MainView
		{
			return kGAMECLASS.mainView;
		}

		protected function get mainViewManager():MainViewManager
		{
			return kGAMECLASS.mainViewManager;
		}
		
		protected function get flags():DefaultDict
		{
			return kGAMECLASS.flags;
		}
		
		protected function set flags(val:DefaultDict):void
		{
			kGAMECLASS.flags = val;
		}
		
		protected function get achievements():DefaultDict
		{
			return kGAMECLASS.achievements;
		}
		
		protected function set achievements(val:DefaultDict):void
		{
			kGAMECLASS.achievements = val;
		}
		
		protected function showStatDown(arg:String):void
		{
			kGAMECLASS.mainView.statsView.showStatDown(arg);
		}
		
		protected function showStatUp(arg:String):void
		{
			kGAMECLASS.mainView.statsView.showStatUp(arg);
		}
		
				
		/**
		 * PRIMO BULLSHIT FUNCTION ACCESS
		 */
		// Need to work out a better way of doing this -- I THINK maybe treating external functions as a string and calling
		// addButton like "addButton(0, "thing", "thisFunc");" might be a way to do it -- check if Func var is a Func type in this.addbutton args
		// if it is, pass it into kGAMECLASS, if it isn't, check if string. If it is, use the string to pull the func from kGAMECLASS
		// before passing it into addbutton etc.
		// Going the string route also makes it... not awful to call into other content classes too - split string on . and chain
		// lookups into objects ie "umasShop.firstVisitPart1" -> kGAMECLASS["umasShop"].["firstVisitPart1"]()
		// @aimozg: but kGAMECLASS.umasShop.firstVisistPart1 instead of String is compile-time safe.
		// Clearly this isn't going to fly long term, but it's... functional for now.

	}

}
