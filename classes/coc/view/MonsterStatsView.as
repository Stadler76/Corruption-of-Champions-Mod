package coc.view {
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Player;
import classes.internals.LoggerFactory;
import classes.internals.Utils;
import flash.events.TimerEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Timer;
import flash.events.Event;
import flash.events.MouseEvent;
import mx.logging.ILogger;
import classes.Monster;

public class MonsterStatsView extends Block {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(StatsView);
	[Embed(source = "../../../res/ui/sidebar1.png")]
	public static const SidebarBg1:Class;
	[Embed(source = "../../../res/ui/sidebar2.png")]
	public static const SidebarBg2:Class;
	[Embed(source = "../../../res/ui/sidebar3.png")]
	public static const SidebarBg3:Class;
	[Embed(source = "../../../res/ui/sidebar4.png")]
	public static const SidebarBg4:Class;
	[Embed(source = "../../../res/ui/sidebarKaizo.png")]
	public static const SidebarBgKaizo:Class;
	public static const SidebarBackgrounds:Array = [SidebarBg1, SidebarBg2, SidebarBg3, SidebarBg4, null, SidebarBgKaizo];
	public static const ValueFontOld:String    = 'Lucida Sans Typewriter';
	public static const ValueFont:String       = 'Palatino Linotype';

	private var sideBarBG:BitmapDataSprite;
	private var nameText:TextField;
	private var coreStatsText:TextField;
	private var combatStatsText:TextField;
	private var levelBar:StatBar;
	private var genderBar:StatBar;
	private var raceBar:StatBar;

	private var hpBar:StatBar;
	private var lustBar:StatBar;
	private var fatigueBar:StatBar;
	public var toolTipHeader:String;
	public var toolTipText:String;
	public var moved:Boolean = false;
	private var allStats:Array;

	/* [INTERMOD: xianxia]
	private var spiritstonesBar:StatBar;
	*/

	public function MonsterStatsView(mainView:MainView) {
		super({
			x           : MainView.MONSTER_X,
			y           : MainView.MONSTER_Y,
			width       : MainView.MONSTER_W,
			height      : MainView.MONSTER_H,
			layoutConfig: {
				//padding: MainView.GAP,
				type: 'flow',
				direction: 'column',
				ignoreHidden: true
				//gap: 1
			}
		});
		const LABEL_FORMAT:Object = {
			font:'Palatino Linotype',
			bold:true,
			size:22
		};
		StatBar.setDefaultOptions({
			barColor: '#600000',
			width: innerWidth
		});
		sideBarBG = addBitmapDataSprite({
			width  : MainView.MONSTER_W,
			height : MainView.MONSTER_H,
			stretch: true
		}, {ignore: true});
		nameText      = addTextField({
			defaultTextFormat: LABEL_FORMAT
		});
		coreStatsText = addTextField({
			text: 'General info:',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		addElement(levelBar = new StatBar({
			statName: "Level:",
			hasBar  : false
		}));
		addElement(raceBar = new StatBar({
			statName: "Race:",
			hasBar  : false
		}));
		addElement(genderBar = new StatBar({
			statName: "Gender:",
			hasBar  : false
		}));

		combatStatsText = addTextField({
			text: 'Combat stats',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		addElement(hpBar = new StatBar({
			statName: "HP:",
			barColor: '#00c000',
			showMax : true
		}));
		addElement(lustBar = new StatBar({
			statName   : "Lust:",
			barColor   : '#c02020',
			minBarColor: '#c00000',
			hasMinBar  : true,
			showMax    : true
		}));
		addElement(fatigueBar = new StatBar({
			statName: "Fatigue:",
			showMax: true
		}));
		/* [INTERMOD: xianxia]
		addElement(manaBar = new StatBar({
			statName: "Mana:",
			barColor: '#0000c0',
			showMax : true
		}));
		*/
		allStats = [];
		///////////////////////////
		for (var ci:int = 0, cn:int = this.numElements; ci < cn; ci++) {
			var e:StatBar = this.getElementAt(ci) as StatBar;
			if (e) allStats.push(e);
		}
		this.addEventListener(MouseEvent.ROLL_OVER, this.hover);
		this.addEventListener(MouseEvent.ROLL_OUT, this.dim);
	}


	public function show():void {
		this.visible = true;
	}

	public function hide():void {
		this.visible = false;
	}
	
	public function hideUpDown():void {
		var ci:int, cc:int = this.allStats.length;
		for (ci = 0; ci < cc; ++ci) {
			var c:StatBar = this.allStats[ci];
			c.isUp        = false;
			c.isDown      = false;
		}
	}
	
	public function hover(event:MouseEvent = null):void {
			if (this.alpha)
				this.alpha = 0.5;
	}

	public function dim(event:MouseEvent = null):void {
			if (this.alpha)
				this.alpha = 1;
	}

	public function statByName(statName:String):StatBar {
		switch (statName.toLowerCase()) {
			case 'hp':
				return hpBar;
			/* [INTERMOD: xianxia]
			case 'wrath':
				return wrathBar;
			*/
			case 'lust':
				return lustBar;
			case 'fatigue':
				return fatigueBar;
			case 'level':
				return levelBar;
			case 'race':
				return raceBar;
			case 'gender':
				return genderBar;
			/* [INTERMOD: xianxia]
			case 'mana':
				return manaBar;
			case 'soulforce':
				return soulforceBar;
			*/
			/* [INTERMOD: xianxia]
			case 'spiritstones':
				return spiritstonesBar;
			*/
			default:
				return null;
		}
	}
	public function showStatUp(statName:String):void {
		var stat:StatBar = statByName(statName);
		if (stat) stat.isUp        = true;
		else LOGGER.error("Cannot showStatUp "+statName);
	}

	public function showStatDown(statName:String):void {
		var stat:StatBar = statByName(statName);
		if (stat) stat.isDown      = true;
		else LOGGER.error("[ERROR] Cannot showStatDown "+statName);
	}
	
	public function refreshStats(game:CoC):void {
		var monster:Monster            = game.monster;
		nameText.htmlText     = "<b>Name: " + Utils.capitalizeFirstLetter(monster.short) + "</b>";
		levelBar.value        = monster.level;
		raceBar.valueText     = monster.race;
		genderBar.valueText   = monster.plural ? "Multiple" : monster.genderText("Male", "Female", "Herm", "???");
		hpBar.maxValue        = monster.maxHP();
		animateBarChange(hpBar, monster.HP);
		lustBar.maxValue      = monster.maxLust();
		lustBar.minValue      = monster.minLust();
		animateBarChange(lustBar, monster.lust);
		fatigueBar.maxValue   = monster.maxFatigue();
		animateBarChange(fatigueBar, monster.fatigue);
		/* [INTERMOD: xianxia]
		manaBar.maxValue 	  = player.maxMana();
		manaBar.value    	  = player.mana;
		*/
		toolTipHeader = "Details";
		toolTipText = monster.generateTooltip();
		invalidateLayout();
	}

	public function setBackground(bitmapClass:Class):void {
		sideBarBG.bitmapClass = bitmapClass;
	}
	
	public function setTheme(font:String, textColor:uint, barAlpha:Number):void {
		var dtf:TextFormat;
		var shadowFilter:DropShadowFilter = new DropShadowFilter();
		
		for each(var e:StatBar in allStats) {
			dtf = e.valueLabel.defaultTextFormat;
			dtf.color = textColor;
			dtf.font = font;
			e.valueLabel.defaultTextFormat = dtf;
			e.valueLabel.setTextFormat(dtf);
			dtf = e.nameLabel.defaultTextFormat;
			dtf.color = textColor;
			e.nameLabel.defaultTextFormat = dtf;
			e.nameLabel.setTextFormat(dtf);
			
			if (e.bar) {
				e.bar.alpha = barAlpha;
				
				if (e.bar.filters.length < 1) {
					e.bar.filters = [shadowFilter];
				}
			}
			
			if (e.minBar) {
				e.minBar.alpha = (1 - (1 - barAlpha) / 2); // 2 times less transparent than bar
			}
		}
		
		for each(var tf:TextField in [nameText,coreStatsText,combatStatsText]) {
			dtf = tf.defaultTextFormat;
			dtf.color = textColor;
			tf.defaultTextFormat = dtf;
			tf.setTextFormat(dtf);
		}
		
	}
	
	public function animateBarChange(bar:StatBar, newValue:Number):void {
		if (kGAMECLASS.flags[kFLAGS.ANIMATE_STATS_BARS] == 0) {
			bar.value = newValue;
			return;
		}
		var oldValue:Number = bar.value;
		//Now animate the bar.
		var tmr:Timer = new Timer(32, 30);
		tmr.addEventListener(TimerEvent.TIMER, kGAMECLASS.createCallBackFunction(stepBarChange, bar, [oldValue, newValue, tmr]));
		tmr.start();
	}
	
	private function stepBarChange(bar:StatBar, args:Array):void {
		var originalValue:Number = args[0]; 
		var targetValue:Number = args[1]; 
		var timer:Timer = args[2];
		bar.value = originalValue + (((targetValue - originalValue) / timer.repeatCount) * timer.currentCount);
		if (timer.currentCount >= timer.repeatCount) bar.value = targetValue;
		if (bar == hpBar) bar.bar.fillColor = Color.fromRgbFloat((1 - (bar.value / bar.maxValue)) * 0.8, (bar.value / bar.maxValue) * 0.8, 0);
	}
	
	public function hint(toolTipText:String = "",toolTipHeader:String=""):void {
			this.toolTipText   = toolTipText;
			this.toolTipHeader = toolTipHeader;
	}
}
}
