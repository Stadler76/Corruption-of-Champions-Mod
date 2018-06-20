//CoC Creature.as
package classes
{
	import classes.BodyParts.Antennae;
	import classes.BodyParts.Arms;
	import classes.BodyParts.Beard;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Claws;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Gills;
	import classes.BodyParts.Hair;
	import classes.BodyParts.Hips;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Neck;
	import classes.BodyParts.RearBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Tongue;
	import classes.BodyParts.Udder;
	import classes.BodyParts.UnderBody;
	import classes.BodyParts.Wings;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.JewelryLib;
	import classes.Scenes.Places.TelAdre.UmasShop;
	import classes.StatusEffects.Combat.CombatInteBuff;
	import classes.StatusEffects.Combat.CombatSpeBuff;
	import classes.StatusEffects.Combat.CombatStrBuff;
	import classes.StatusEffects.Combat.CombatTouBuff;
	import classes.VaginaClass;
	import classes.internals.RandomNumberGenerator;
	import classes.internals.LoggerFactory;
	import classes.internals.Utils;
	import classes.internals.profiling.Begin;
	import classes.internals.profiling.End;
	import classes.lists.BodyPartLists;
	import classes.lists.BreastCup;
	import classes.lists.Gender;
	import classes.lists.PerkLists;
	import flash.errors.IllegalOperationError;
	import mx.logging.ILogger;


	public class Creature extends Utils
	{
		private static const LOGGER:ILogger = LoggerFactory.getLogger(Creature);

		public function get game():CoC {
			return kGAMECLASS;
		}
		public function get flags():DefaultDict {
			return game.flags;
		}

		//Variables
		
		//Short refers to player name and monster name. BEST VARIABLE NAME EVA!
		//"a" refers to how the article "a" should appear in text. 
		private var _short:String = "You";
		private var _a:String = "a ";
		private var _race:String = "";
		
		/**
		 * Normally creatures do not need a unique RNG,
		 * so to avoid unnecessary memory usage they use the default instance.
		 */
		private var _rng:RandomNumberGenerator = Utils.DEFAULT_RNG;
		
		/**
		 * Set the RNG this class uses. Intended for testing.
		 * @param	rng to use for random numbers
		 * @return the RNG that was set
		 */
		public function set rng(rng:RandomNumberGenerator):void {
			if (rng === null) {
				throw new ArgumentError("RNG cannot be null");
			}
			
			this._rng = rng;
		}
		
		/**
		 * Get the RNG this class uses. Intended for testing.
		 * @return the RNG used
		 */
		public function get rng():RandomNumberGenerator {
			return this._rng;
		}
		
		public function get short():String { return _short; }
		public function set short(value:String):void { _short = value; }
		public function get a():String { return _a; }
		public function set a(value:String):void { _a = value; }
		public function get capitalA():String {
			if (_a.length == 0) return "";
			return _a.charAt(0).toUpperCase() + _a.substr(1);
		}

		//Weapon
		private var _weaponName:String = "";
		private var _weaponVerb:String = "";
		private var _weaponAttack:Number = 0;
		private var _weaponPerk:String = "";
		private var _weaponValue:Number = 0;
		public function get weaponName():String { return _weaponName; }
		public function get weaponVerb():String { return _weaponVerb; }
		public function get weaponAttack():Number { return _weaponAttack; }
		public function get weaponPerk():String { return _weaponPerk; }
		public function get weaponValue():Number { return _weaponValue; }
		public function set weaponName(value:String):void { _weaponName = value; }
		public function set weaponVerb(value:String):void { _weaponVerb = value; }
		public function set weaponAttack(value:Number):void { _weaponAttack = value; }
		public function set weaponPerk(value:String):void { _weaponPerk = value; }
		public function set weaponValue(value:Number):void { _weaponValue = value; }
		//Clothing/Armor
		private var _armorName:String = "";
		private var _armorDef:Number = 0;
		private var _armorPerk:String = "";
		private var _armorValue:Number = 0;
		public function get armorName():String { return _armorName; }
		public function get armorDef():Number { return _armorDef; }
		public function get armorPerk():String { return _armorPerk; }
		public function get armorValue():Number { return _armorValue; }
		public function set armorValue(value:Number):void { _armorValue = value; }
		public function set armorName(value:String):void { _armorName = value; }
		public function set armorDef(value:Number):void { _armorDef = value; }
		public function set armorPerk(value:String):void { _armorPerk = value; }
		//Jewelry!
		private var _jewelryName:String = "";
		private var _jewelryEffectId:Number = 0;
		private var _jewelryEffectMagnitude:Number = 0;
		private var _jewelryPerk:String = "";
		private var _jewelryValue:Number = 0;
		public function get jewelryName():String { return _jewelryName; }
		public function get jewelryEffectId():Number { return _jewelryEffectId; }
		public function get jewelryEffectMagnitude():Number { return _jewelryEffectMagnitude; }
		public function get jewelryPerk():String { return _jewelryPerk; }
		public function get jewelryValue():Number { return _jewelryValue; }
		public function set jewelryValue(value:Number):void { _jewelryValue = value; }
		public function set jewelryName(value:String):void { _jewelryName = value; }
		public function set jewelryEffectId(value:Number):void { _jewelryEffectId = value; }
		public function set jewelryEffectMagnitude(value:Number):void { _jewelryEffectId = value; }
		public function set jewelryPerk(value:String):void { _jewelryPerk = value; }
		//Shield!
		private var _shieldName:String = "";
		private var _shieldBlock:Number = 0;
		private var _shieldPerk:String = "";
		private var _shieldValue:Number = 0;
		public function get shieldName():String { return _shieldName; }
		public function get shieldBlock():Number { return _shieldBlock; }
		public function get shieldPerk():String { return _shieldPerk; }
		public function get shieldValue():Number { return _shieldValue; }
		public function set shieldValue(value:Number):void { _shieldValue = value; }
		public function set shieldName(value:String):void { _shieldName = value; }
		public function set shieldBlock(value:Number):void { _shieldBlock = value; }
		public function set shieldPerk(value:String):void { _shieldPerk = value; }
		//Undergarments!
		private var _upperGarmentName:String = "";
		private var _upperGarmentPerk:String = "";
		private var _upperGarmentValue:Number = 0;
		public function get upperGarmentName():String { return _upperGarmentName; }
		public function get upperGarmentPerk():String { return _upperGarmentPerk; }
		public function get upperGarmentValue():Number { return _upperGarmentValue; }
		public function set upperGarmentName(value:String):void { _upperGarmentName = value; }
		public function set upperGarmentPerk(value:String):void { _upperGarmentPerk = value; }
		public function set upperGarmentValue(value:Number):void { _upperGarmentValue = value; }
		
		private var _lowerGarmentName:String = "";
		private var _lowerGarmentPerk:String = "";
		private var _lowerGarmentValue:Number = 0;
		public function get lowerGarmentName():String { return _lowerGarmentName; }
		public function get lowerGarmentPerk():String { return _lowerGarmentPerk; }
		public function get lowerGarmentValue():Number { return _lowerGarmentValue; }
		public function set lowerGarmentName(value:String):void { _lowerGarmentName = value; }
		public function set lowerGarmentPerk(value:String):void { _lowerGarmentPerk = value; }
		public function set lowerGarmentValue(value:Number):void { _lowerGarmentValue = value; }
		//Primary stats
		public var str:Number = 0;
		public var tou:Number = 0;
		public var spe:Number = 0;
		public var inte:Number = 0;
		public var lib:Number = 0;
		public var sens:Number = 0;
		public var cor:Number = 0;
		//Combat Stats
		private var _HP:Number = 0;
		private var _lust:Number = 0;		
		private var _fatigue:Number = 0;
		//Level Stats
		public var XP:Number = 0;
		public var level:Number = 0;
		public var gems:Number = 0;
		public var additionalXP:Number = 0;

		public function get str100():Number { return 100*str/getMaxStats('str'); }
		public function get tou100():Number { return 100*tou/getMaxStats('tou'); }
		public function get spe100():Number { return 100*spe/getMaxStats('spe'); }
		public function get inte100():Number { return 100*inte/getMaxStats('inte'); }
		public function get lib100():Number { return 100*lib/getMaxStats('lib'); }
		public function get sens100():Number { return 100*sens/getMaxStats('sens'); }
		public function get fatigue100():Number { return 100*fatigue/maxFatigue(); }
		public function get hp100():Number { return 100*HP/maxHP(); }
		public function get lust100():Number { return 100*lust/maxLust(); }

		public function HPRatio():Number { return HP / maxHP(); }
		
		/**
		 * @return keys: str, tou, spe, inte
		 */
		public function getAllMaxStats():Object {
			return {
				str:100,
				tou:100,
				spe:100,
				inte:100
			};
		}

		/**
		 * Modify stats.
		 *
		 * Arguments should come in pairs nameOp:String, value:Number/Boolean <br/>
		 * where nameOp is ( stat_name + [operator] ) and value is operator argument<br/>
		 * valid operators are "=" (set), "+", "-", "*", "/", add is default.<br/>
		 * valid stat_names are "str", "tou", "spe", "int", "lib", "sen", "lus", "cor" or their full names;
		 * also "scaled"/"sca" (default true: apply resistances, perks; false - force values)
		 * and "max" (default true: don't overflow above max value)
		 *
		 * @return Object of (newStat-oldStat) with keys str, tou, spe, inte, lib, sens, lust, cor
		 * */
		public function dynStats(... args):Object {
			Begin("Creature","dynStats");
			var argz:Object = parseDynStatsArgs(this, args);
			var prevStr:Number  = str;
			var prevTou:Number  = tou;
			var prevSpe:Number  = spe;
			var prevInte:Number  = inte;
			var prevLib:Number  = lib;
			var prevSens:Number  = sens;
			var prevLust:Number  = lust;
			var prevCor:Number  = cor;
			modStats(argz.str, argz.tou, argz.spe, argz.inte, argz.lib, argz.sens, argz.lust, argz.cor, argz.scale, argz.max);
			End("Creature","dynStats");
			return {
				str:str-prevStr,
				tou:tou-prevTou,
				spe:spe-prevSpe,
				inte:inte-prevInte,
				lib:lib-prevLib,
				sens:sens-prevSens,
				lust:lust-prevLust,
				cor:cor-prevCor
			};
		}
		public function modStats(dstr:Number, dtou:Number, dspe:Number, dinte:Number, dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean, max:Boolean):void {
			var oldHP100:Number = hp100;
			var maxes:Object;
			if (max) {
				maxes = getAllMaxStats();
				// TODO maybe move lib & sens to getAllMaxStats() too?
				maxes.lib = 100;
				maxes.sens = 100;
				maxes.cor = 100;
				maxes.lust = maxLust();
			} else {
				maxes = {
					str:Infinity,
					tou:Infinity,
					spe:Infinity,
					inte:Infinity,
					lib:Infinity,
					sens:Infinity,
					lust:Infinity,
					cor:100
				}
			}
			str   = boundFloat(1,str+dstr,maxes.str);
			tou   = boundFloat(1,tou+dtou,maxes.tou);
			spe   = boundFloat(1,spe+dspe,maxes.spe);
			inte  = boundFloat(1,inte+dinte,maxes.inte);
			lib   = boundFloat(minLib(),lib+dlib,maxes.lib);
			sens  = boundFloat(minSens(),sens+dsens,maxes.sens);
			lust  = boundFloat(minLust(),lust+dlust,maxes.lust);
			cor   = boundFloat(0,cor+dcor,maxes.cor);
			var newHPmax:Number = maxHP();
			HP = boundFloat(-Infinity, oldHP100*newHPmax/100, newHPmax);
		}
		/**
		 * Modify Strength by `delta`. If scale = true, apply perk & effect modifiers. Return actual increase applied.
		 */
		public function modStr(delta:Number,scale:Boolean=true):Number {
			if (scale) return dynStats('str',delta)['str'];
			var s0:Number = str;
			str = boundFloat(1,str+delta,getMaxStats('str'));
			return str-s0;
		}
		/**
		 * Modify Toughness by `delta`. If scale = true, apply perk & effect modifiers. Return actual increase applied.
		 */
		public function modTou(delta:Number,scale:Boolean=true):Number {
			if (scale) return dynStats('tou',delta)['tou'];
			var s0:Number = tou;
			tou = boundFloat(1,tou+delta,getMaxStats('tou'));
			return tou-s0;
		}
		/**
		 * Modify Speed by `delta`. If scale = true, apply perk & effect modifiers. Return actual increase applied.
		 */
		public function modSpe(delta:Number,scale:Boolean=true):Number {
			if (scale) return dynStats('spe',delta)['spe'];
			var s0:Number = spe;
			spe = Utils.boundFloat(1,spe+delta,getMaxStats('spe'));
			return spe-s0;
		}
		/**
		 * Modify Intelligence by `delta`. If scale = true, apply perk & effect modifiers. Return actual increase applied.
		 */
		public function modInt(delta:Number,scale:Boolean=true):Number {
			if (scale) return dynStats('inte',delta)['inte'];
			var s0:Number = inte;
			inte = Utils.boundFloat(1,inte+delta,getMaxStats('int'));
			return inte-s0;
		}
		public function corruptionTolerance():Number {
			return 0;
		}
		public function corAdjustedUp():Number {
			return boundFloat(0, cor + corruptionTolerance(), 100);
		}
		public function corAdjustedDown():Number {
			return boundFloat(0, cor - corruptionTolerance(), 100);
		}
		/**
		 * Requires corruption >= minCor, corruption tolerance relaxes the requirement (lowers the bar).
		 * If `falseIfZero` is true, having 0 corruption makes check always fail
		 */
		public function isCorruptEnough(minCor:Number, falseIfZero:Boolean = false):Boolean {
			if (falseIfZero && cor < 0.5) return false;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) return true;
			return corAdjustedUp() >= minCor;
		}
		/**
		 * Requires corruption < maxCor, corruption tolerance relaxes the requirement (raises the bar)
		 * If `falseIf100` is true, having 100 corruption makes check always fail
		 */
		public function isPureEnough(maxCor:Number, falseIf100:Boolean = false):Boolean {
			if (falseIf100 && cor >= 99.5) return false;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) return true;
			return corAdjustedDown() < maxCor;
		}

		//Appearance Variables
		/**
		 * Get the gender of the creature, based on its genitalia or lack thereof. Not to be confused with gender identity by femininity.
		 * @return the current gender (0 = gender-less, 1 = male, 2 = female, 3 = hermaphrodite)
		 */
		public function get gender():int
		{
			if (hasCock() && hasVagina()) {
				return Gender.HERM;
			}
			if (hasCock()) {
				return Gender.MALE;
			}
			if (hasVagina()) {
				return Gender.FEMALE;
			}
			return Gender.NONE;
		}
		public function get race():String { return this._race; }
		public function set race(value:String):void { this._race = value; }
		private var _tallness:Number = 0;
		public function get tallness():Number { return _tallness; }
		public function set tallness(value:Number):void { _tallness = value; }

		public var antennae:Antennae = new Antennae();
		public var arms:Arms; // Set in the constructor ...
		public var beard:Beard = new Beard();
		public var butt:Butt = new Butt();
		public var ears:Ears = new Ears();
		public var eyes:Eyes = new Eyes();
		public var face:Face = new Face();
		public var gills:Gills = new Gills();
		public var hair:Hair = new Hair();
		public var hips:Hips = new Hips();
		public var horns:Horns = new Horns();
		public var lowerBody:LowerBody = new LowerBody();
		public var neck:Neck = new Neck();
		public var rearBody:RearBody = new RearBody();
		public var skin:Skin = new Skin();
		public var tail:Tail = new Tail();
		public var tongue:Tongue = new Tongue();
		public var underBody:UnderBody = new UnderBody();
		public var wings:Wings = new Wings();
		public var udder:Udder = new Udder();

		//Piercings
		//TODO: Pull this out into it's own class and enum.
		public var nipplesPierced:Number = 0;
		public var nipplesPShort:String = "";
		public var nipplesPLong:String = "";
		public var lipPierced:Number = 0;
		public var lipPShort:String = "";
		public var lipPLong:String = "";
		public var tonguePierced:Number = 0;
		public var tonguePShort:String = "";
		public var tonguePLong:String = "";
		public var eyebrowPierced:Number = 0;
		public var eyebrowPShort:String = "";
		public var eyebrowPLong:String = "";
		public var earsPierced:Number = 0;
		public var earsPShort:String = "";
		public var earsPLong:String = "";
		public var nosePierced:Number = 0;
		public var nosePShort:String = "";
		public var nosePLong:String = "";

		//Sexual Stuff		
		//MALE STUFF
		//public var cocks:Array;
		//TODO: Tuck away into Male genital class?
		public var cocks:Vector.<Cock>;
		//balls
		public var balls:Number = 0;
		public var cumMultiplier:Number = 1;
		public var ballSize:Number = 0;
		
		private var _hoursSinceCum:Number = 0;
		public function get hoursSinceCum():Number { return _hoursSinceCum; }
		public function set hoursSinceCum(v:Number):void {
			/*if (v == 0)
			{
				trace("noop");
			}*/
			_hoursSinceCum = v; 
		}
		
		//FEMALE STUFF
		//TODO: Box into Female genital class?
		public var vaginas:Vector.<VaginaClass>;
		//Fertility is a % out of 100. 
		public var fertility:Number = 10;
		public var nippleLength:Number = .25;
		public var breastRows:Vector.<BreastRowClass>;
		public var ass:AssClass = new AssClass();
		
		/**
		 * Check if the Creature has a vagina. If not, throw an informative Error.
		 * This should be more informative than the usual RangeError (Out of bounds).
		 * @throws IllegalOperationError if no vagina is present
		 */
		private function checkVaginaPresent():void {
			if (!hasVagina()) {
				throw new IllegalOperationError("Creature does not have vagina.")
			}
		}
		
		/**
		 * Get the clit length for the selected vagina (defaults to the first vagina).
		 * @param	vaginaIndex the vagina to query for the clit length
		 * @return the clit length of the vagina
		 * @throws IllegalOperationError if the Creature does not have a vagina
		 * @throws IllegalOperationError if the Creature does not have a vagina
		 * @throws RangeError if the selected vagina cannot be found
		 */
		public function getClitLength(vaginaIndex : int = 0) : Number {
			checkVaginaPresent();
			
			return vaginas[vaginaIndex].clitLength;
		}
		
		/**
		 * Set the clit length for the selected vagina (defaults to the first vagina).
		 * @param clitLength the clit length to set for the vagina
		 * @param vaginaIndex the vagina on witch to set the clit length
		 * @return the clit length of the vagina
		 * @throws IllegalOperationError if the Creature does not have a vagina
		 * @throws RangeError if the selected vagina cannot be found
		 */
		public function setClitLength(clitLength:Number, vaginaIndex : int = 0) : Number {
			checkVaginaPresent();
			
			vaginas[vaginaIndex].clitLength = clitLength;
			return getClitLength(vaginaIndex);
		}
		
		/**
		 * Change the clit length by the given amount. If the resulting length drops below 0, it will be set to 0 instead.
		 * @param	delta the amount to change, can be positive or negative
		 * @param	vaginaIndex the vagina whose clit will be changed
		 * @return the updated clit length
		 * @throws IllegalOperationError if the Creature does not have a vagina
		 * @throws RangeError if the selected vagina cannot be found
		 */
		public function changeClitLength(delta:Number, vaginaIndex:int = 0):Number {
			checkVaginaPresent();
			var newClitLength:Number = vaginas[vaginaIndex].clitLength += delta;
			return newClitLength < 0 ? 0 : newClitLength;
		}
		
		private var _femininity:Number = 50;
		public function get femininity():Number {
			var fem:Number = _femininity;
			const effect:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (effect != null && effect.value1 == UmasShop.MASSAGE_MODELLING_BONUS) {
				fem += effect.value2;
			}
			if (fem > 100)
				fem = 100;
			return fem;
		}
		public function set femininity(value:Number):void
		{
			if (value > 100)
				value = 100;
			else if (value < 0)
				value = 0;
			_femininity = value;
		}
		
		public function validate():String
		{
			var error:String = "";
			// 2. Value boundaries etc
			// 2.1. non-negative Number fields
			error += Utils.validateNonNegativeNumberFields(this,"Monster.validate",[
				"balls", "ballSize", "cumMultiplier", "hoursSinceCum",
				"tallness", "hips.rating", "butt.rating", "lowerBody.type", "arms.type",
				"skin.type", "hair.length", "hair.type",
				"face.type", "ears.type", "tongue.type", "eyes.type",
				"str", "tou", "spe", "inte", "lib", "sens", "cor",
				// Allow weaponAttack to be negative as a penalty to strength-calculated damage
				// Same with armorDef, bonusHP, additionalXP
				"weaponValue", "armorValue",
				"lust", "fatigue",
				"level", "gems",
				"tail.venom", "tail.recharge", "horns.value",
				"HP", "XP"
			]);
			// 2.2. non-empty String fields
			error += Utils.validateNonEmptyStringFields(this,"Monster.validate",[
				"short",
				"skin.desc",
				"weaponName", "weaponVerb", "armorName"
			]);
			// 3. validate members
			for each (var cock:Cock in cocks) {
				error += cock.validate();
			}
			for each (var vagina:VaginaClass in vaginas) {
				error += vagina.validate();
			}
			for each (var row:BreastRowClass in breastRows) {
				error += row.validate();
			}
			error += ass.validate();
			// 4. Inconsistent fields
			// 4.1. balls
			if (balls>0 && ballSize<=0){
				error += "Balls are present but ballSize = "+ballSize+". ";
			}
			if (ballSize>0 && balls<=0){
				error += "No balls but ballSize = "+ballSize+". ";
			}
			// 4.2. hair
			if (hair.length <= 0) {
				if (hair.type != Hair.NORMAL) error += "No hair but hairType = " + hair.type + ". ";
			}
			// 4.3. tail
			if (tail.type == Tail.NONE) {
				if (tail.venom != 0) error += "No tail but tailVenom = "+tail.venom+". ";
			}
			// 4.4. horns
			if (horns.type == Horns.NONE){
				if (horns.value>0) error += "horns.value > 0 but horns.type = Horns.NONE. ";
			} else {
				if (horns.value==0) error += "Has horns but their number 'horns' = 0. ";
			}
			return error;
		}
		
		//Monsters have few perks, which I think should be a status effect for clarity's sake.
		//TODO: Move perks into monster status effects.
		private var _perks:Array;
		public function perk(i:int):PerkClass{
			return _perks[i];
		}
		public function get perks():Array {
			return _perks;
		}
		public function get numPerks():int {
			return _perks.length;
		}
		//Current status effects. This has got very muddy between perks and status effects. Will have to look into it.
		//Someone call the grammar police!
		//TODO: Move monster status effects into perks. Needs investigation though.
		public var statusEffects:Array;

		//Constructor
		public function Creature()
		{
			//cocks = new Array();
			//The world isn't ready for typed Arrays just yet.
			cocks = new Vector.<Cock>();
			vaginas = new Vector.<VaginaClass>();
			breastRows = new Vector.<BreastRowClass>();
			_perks = [];
			statusEffects = [];
			arms = new Arms(this);
			//keyItems = new Array();
		}

		//Functions			
		public function orgasmReal():void
		{
			dynStats("lus=", 0, "res", false);
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
			
			if (countCockSocks("gilded") > 0) {
				var randomCock:int = rand( cocks.length );
				var bonusGems:int = rand( cocks[randomCock].cockThickness ) + countCockSocks("gilded"); // int so AS rounds to whole numbers
				game.outputText("\n\nFeeling some minor discomfort in your " + cockDescript(randomCock) + " you slip it out of your [armor] and examine it. <b>With a little exploratory rubbing and massaging, you manage to squeeze out " + bonusGems + " gems from its cum slit.</b>\n\n" );
				gems += bonusGems;
			}
		}
		public function orgasm(type:String = 'Default', real:Boolean = true):void
		{
			// None-tails original doc includes ability to recover fatigue with after-combat sex. Though it could be OP...
			//if (game.inCombat && game.monster != null && (hasPerk(PerkLib.EnlightenedNinetails) || hasPerk(PerkLib.CorruptedNinetails))) {
				//fatigue -= game.monster.level * 2;
				//if (fatigue < 0) fatigue = 0;
			//}
			switch (type) {
				// Start with that, whats easy
				case 'Vaginal': if (kGAMECLASS.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_VAGINAL] < 10) flags[kFLAGS.TIMES_ORGASM_VAGINAL]++; break;
				case 'Anal':    if (kGAMECLASS.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;    break;
				case 'Dick':    if (kGAMECLASS.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_DICK]    < 10) flags[kFLAGS.TIMES_ORGASM_DICK]++;    break;
				case 'Lips':    if (kGAMECLASS.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_LIPS]    < 10) flags[kFLAGS.TIMES_ORGASM_LIPS]++;    break;
				case 'Tits':    if (kGAMECLASS.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_TITS]    < 10) flags[kFLAGS.TIMES_ORGASM_TITS]++;    break;
				case 'Nipples': if (kGAMECLASS.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_NIPPLES] < 10) flags[kFLAGS.TIMES_ORGASM_NIPPLES]++; break;
				case 'Ovi':     break;

				// Now to the more complex types
				case 'VaginalAnal':
					orgasm((hasVagina() ? 'Vaginal' : 'Anal'), real);
					return; // Prevent calling orgasmReal() twice

				case 'DickAnal':
					orgasm((rand(2) == 0 ? 'Dick' : 'Anal'), real);
					return;

				case 'Default':
				case 'Generic':
				default:
					if (!hasVagina() && !hasCock()) {
						orgasm('Anal'); // Failsafe for genderless PCs
						return;
					}

					if (hasVagina() && hasCock()) {
						orgasm((rand(2) == 0 ? 'Vaginal' : 'Dick'), real);
						return;
					}

					orgasm((hasVagina() ? 'Vaginal' : 'Dick'), real);
					return;
			}

			if (real) orgasmReal();
		}

		public function newGamePlusMod():int
		{
			//Constrains value between 0 and 4.
			return Math.max(0, Math.min(4, flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
		}

		public function ascensionFactor(multiplier:Number = 25):Number
		{
			return newGamePlusMod() * multiplier;
		}

		public function ngPlus(value:Number, multiplier:Number = 25):Number
		{
			return value + ascensionFactor(multiplier);
		}

		//Create a perk
		public function createPerk(ptype:PerkType, value1:Number = 0, value2:Number = 0, value3:Number = 0, value4:Number = 0):void
		{
			var newKeyItem:PerkClass = new PerkClass(ptype);
			//used to denote that the array has already had its new spot pushed on.
			var arrayed:Boolean = false;
			//used to store where the array goes
			var keySlot:Number = 0;
			var counter:Number = 0;
			//Start the array if its the first bit
			if (perks.length == 0)
			{
				//trace("New Perk Started Array! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//If it belongs at the end, push it on
			if (perk(perks.length - 1).perkName < ptype.name && !arrayed)
			{
				//trace("New Perk Belongs at the end!! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = perks.length - 1;
			}
			//If it belongs in the beginning, splice it in
			if (perk(0).perkName > ptype.name && !arrayed)
			{
				//trace("New Perk Belongs at the beginning! " + keyName);
				perks.splice(0, 0, newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//Find the spot it needs to go in and splice it in.
			if (!arrayed)
			{
				//trace("New Perk using alphabetizer! " + keyName);
				counter = perks.length;
				while (counter > 0 && !arrayed)
				{
					counter--;
					//If the current slot is later than new key
					if (perk(counter).perkName > ptype.name)
					{
						//If the earlier slot is earlier than new key && a real spot
						if (counter - 1 >= 0)
						{
							//If the earlier slot is earlier slot in!
							if (perk(counter - 1).perkName <= ptype.name)
							{
								arrayed = true;
								perks.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
						//If the item after 0 slot is later put here!
						else
						{
							//If the next slot is later we are go
							if (perk(counter).perkName <= ptype.name) {
								arrayed = true;
								perks.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
					}
				}
			}
			//Fallback
			if (!arrayed)
			{
				//trace("New Perk Belongs at the end!! " + keyName);
				perks.push(newKeyItem);
				keySlot = perks.length - 1;
			}
			
			perk(keySlot).value1 = value1;
			perk(keySlot).value2 = value2;
			perk(keySlot).value3 = value3;
			perk(keySlot).value4 = value4;
			//trace("NEW PERK FOR PLAYER in slot " + keySlot + ": " + perk(keySlot).perkName);
		}

		/**
		 * Remove perk. Return true if there was such perk
		 */
		public function removePerk(ptype:PerkType):Boolean
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return false;
			}
			if (perkv4(ptype) > 0)
			{
				// trace('ERROR! Attempted to remove permanent "' + ptype.name + '" perk.');
				return false;
			}
			while (counter > 0)
			{
				counter--;
				if (perk(counter).ptype == ptype)
				{
					perks.splice(counter, 1);
					//trace("Attempted to remove \"" + perkName + "\" perk.");
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Find an array element number for a perk. Useful when you want to work with a PerkClass instance.
		 */
		public function findPerk(ptype:PerkType):Number
		{
			if (perks.length <= 0)
				return -2;
			for (var counter:int = 0; counter<perks.length; counter++)
			{
				if (perk(counter).ptype == ptype)
					return counter;
			}
			return -1;
		}
		
		/**
		 * Check if this creature has specified perk.
		 */
		public function hasPerk(ptype:PerkType):Boolean
		{
			if (perks.length <= 0)
				return false;
			for (var counter:int = 0; counter<perks.length; counter++)
			{
				if (perk(counter).ptype == ptype)
					return true;
			}
			return false;
		}

		/**
		 * Creates a perk only, if the creature (usually the player) doesn't already have that perk
		 * @param   ptype   The perk to be created
		 * @param   value1  Perk value 1
		 * @param   value2  Perk value 2
		 * @param   value3  Perk value 3
		 * @param   value4  Perk value 4
		 * @return  true, if the perk was created. false, if the creature (usually the player) already had that perk
		 */
		public function createPerkIfNotHasPerk(ptype:PerkType, value1:Number = 0, value2:Number = 0, value3:Number = 0, value4:Number = 0):Boolean
		{
			if (hasPerk(ptype)) {
				return false;
			}

			createPerk(ptype, value1, value2, value3, value4);
			return true;
		}
		
		//Duplicate perk
		//Deprecated?
		public function perkDuplicated(ptype:PerkType):Boolean
		{
			var timesFound:int = 0;
			if (perks.length <= 0)
				return false;
			for (var counter:int = 0; counter<perks.length; counter++)
			{
				if (perk(counter).ptype == ptype)
					timesFound++;
			}
			return (timesFound > 1);
		}
		
		//remove all perks
		public function removePerks():void
		{
			_perks = [];
		}
		
		public function addPerkValue(ptype:PerkType, valueIdx:Number = 1, bonus:Number = 0): void
		{
			var counter:int = findPerk(ptype);
			if (counter < 0) {
				CoC_Settings.error("ERROR? Looking for perk '" + ptype + "' to change value " + valueIdx + ", and player does not have the perk.");
				return;
			}
			if (valueIdx < 1 || valueIdx > 4) {
				CoC_Settings.error("addPerkValue(" + ptype.id + ", " + valueIdx + ", " + bonus + ").");
				return;
			}
			if (valueIdx == 1)
				perk(counter).value1 += bonus;
			if (valueIdx == 2)
				perk(counter).value2 += bonus;
			if (valueIdx == 3)
				perk(counter).value3 += bonus;
			if (valueIdx == 4)
				perk(counter).value4 += bonus;
		}
		
		public function setPerkValue(ptype:PerkType, valueIdx:Number = 1, newNum:Number = 0): void
		{
			var counter:Number = findPerk(ptype);
			//Various Errors preventing action
			if (counter < 0) {
				CoC_Settings.error("ERROR? Looking for perk '" + ptype + "' to change value " + valueIdx + ", and player does not have the perk.");
				return;
			}
			if (valueIdx < 1 || valueIdx > 4)
			{
				CoC_Settings.error("setPerkValue(" + ptype.id + ", " + valueIdx + ", " + newNum + ").");
				return;
			}
			if (valueIdx == 1)
				perk(counter).value1 = newNum;
			if (valueIdx == 2)
				perk(counter).value2 = newNum;
			if (valueIdx == 3)
				perk(counter).value3 = newNum;
			if (valueIdx == 4)
				perk(counter).value4 = newNum;
		}
		
		public function perkv1(ptype:PerkType):Number
		{
			var counter:Number = findPerk(ptype);
			if (counter < 0)
			{
				// trace("ERROR? Looking for perk '" + ptype + "', but player does not have it.");
				return 0;
			}
			return perk(counter).value1;
		}
		
	public function perkv2(ptype:PerkType):Number
	{
		var counter:Number = findPerk(ptype);
		if (counter < 0)
		{
			// trace("ERROR? Looking for perk '" + ptype + "', but player does not have it.");
			return 0;
		}
		return perk(counter).value2;
	}
		
	public function perkv3(ptype:PerkType):Number
	{
		var counter:Number = findPerk(ptype);
		if (counter < 0)
		{
			CoC_Settings.error("ERROR? Looking for perk '" + ptype + "', but player does not have it.");
			return 0;
		}
		return perk(counter).value3;
	}
		
	public function perkv4(ptype:PerkType):Number
	{
		var counter:Number = findPerk(ptype);
		if (counter < 0)
		{
			// trace("ERROR? Looking for perk '" + ptype + "', but player does not have it.");
			return 0;
		}
		return perk(counter).value4;
	}

	public function hasHistoryPerk():Boolean
	{
		for each (var p:Object in PerkLists.HISTORY) {
			if (hasPerk(p.perk)) {
				return true;
			}
		}
		return false;
	}
		
		/*
		
		[    S T A T U S   E F F E C T S    ]
		
		*/
		//{region StatusEffects
		public function createOrFindStatusEffect(stype:StatusEffectType):StatusEffectClass
		{
			var sec:StatusEffectClass = statusEffectByType(stype);
			if (!sec) sec = createStatusEffect(stype,0,0,0,0);
			return sec;
		}
		//Create a status
		public function createStatusEffect(stype:StatusEffectType, value1:Number, value2:Number, value3:Number, value4:Number, fireEvent:Boolean = true):StatusEffectClass
		{
			var newStatusEffect:StatusEffectClass = stype.create(value1,value2,value3,value4);
			statusEffects.push(newStatusEffect);
			newStatusEffect.addedToHostList(this,fireEvent);
			return newStatusEffect;
		}
		public function addStatusEffect(sec:StatusEffectClass/*,fireEvent:Boolean = true*/):void {
			if (sec.host != this) {
				sec.remove();
				sec.attach(this/*,fireEvent*/);
			} else {
				statusEffects.push(sec);
				sec.addedToHostList(this,true);
			}
		}
		//Remove a status
		public function removeStatusEffect(stype:StatusEffectType/*, fireEvent:Boolean = true*/):StatusEffectClass
		{
			var counter:Number = indexOfStatusEffect(stype);
			if (counter < 0) return null;
			var sec:StatusEffectClass = statusEffects[counter];
			statusEffects.splice(counter, 1);
			sec.removedFromHostList(true);
			return sec;
		}
		public function removeStatusEffectInstance(sec:StatusEffectClass/*, fireEvent:Boolean = true*/):void {
			var i:int = statusEffects.indexOf(sec);
			if (i < 0) return;
			statusEffects.splice(i, 1);
			sec.removedFromHostList(true);
		}
		
		public function indexOfStatusEffect(stype:StatusEffectType):int {
			for (var counter:int = 0; counter < statusEffects.length; counter++) {
				if ((statusEffects[counter] as StatusEffectClass).stype == stype)
					return counter;
			}
			return -1;
		}

		public function statusEffectByType(stype:StatusEffectType):StatusEffectClass {
			var idx:int = indexOfStatusEffect(stype);
			return idx<0 ? null : statusEffects[idx];
		}
		public function hasStatusEffect(stype:StatusEffectType):Boolean {
			return indexOfStatusEffect(stype) >= 0;
		}
		//}endregion
		
		public function changeStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, newNum:Number = 0):void {
			var effect:StatusEffectClass = statusEffectByType(stype);
			//Various Errors preventing action
			if (effect == null)return;
			if (statusValueNum < 1 || statusValueNum > 4) {
				CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
				return;
			}
			if (statusValueNum == 1)
				effect.value1 = newNum;
			if (statusValueNum == 2)
				effect.value2 = newNum;
			if (statusValueNum == 3)
				effect.value3 = newNum;
			if (statusValueNum == 4)
				effect.value4 = newNum;
		}
		
		public function addStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, bonus:Number = 0):void
		{
			//Various Errors preventing action
			var effect:StatusEffectClass = statusEffectByType(stype);
			if (effect == null) return;
			if (statusValueNum < 1 || statusValueNum > 4)
			{
				CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
				return;
			}
			if (statusValueNum == 1)
				effect.value1 += bonus;
			if (statusValueNum == 2)
				effect.value2 += bonus;
			if (statusValueNum == 3)
				effect.value3 += bonus;
			if (statusValueNum == 4)
				effect.value4 += bonus;
		}
		
		public function statusEffect(idx:int):StatusEffectClass
		{
			return statusEffects [idx];
		}
		
		public function statusEffectv1(stype:StatusEffectType,defaultValue:Number=0):Number
		{
			var effect:StatusEffectClass = statusEffectByType(stype);
			return (effect==null)?defaultValue:effect.value1;
		}
		
		public function statusEffectv2(stype:StatusEffectType,defaultValue:Number=0):Number
		{
			var effect:StatusEffectClass = statusEffectByType(stype);
			return (effect==null)?defaultValue:effect.value2;
		}

		public function statusEffectv3(stype:StatusEffectType,defaultValue:Number=0):Number
		{
			var effect:StatusEffectClass = statusEffectByType(stype);
			return (effect==null)?defaultValue:effect.value3;
		}

		public function statusEffectv4(stype:StatusEffectType,defaultValue:Number=0):Number
		{
			var effect:StatusEffectClass = statusEffectByType(stype);
			return (effect==null)?defaultValue:effect.value4;
		}

		public function removeStatuses(fireEvent:Boolean):void
		{
			var a:/*StatusEffectClass*/Array=statusEffects.splice(0,statusEffects.length);
			for (var n:int=a.length,i:int=0;i<n;i++) {
				a[i].removedFromHostList(fireEvent);
			}
		}
		
		/**
		 * Applies (creates or increases) a combat-long buff to stat.
		 * Stat is fully restored after combat.
		 * Different invocations are indistinguishable - do not use this if you need
		 * to check for _specific_ buff source (poison etc) mid-battle
		 * @param stat 'str','spe','tou','inte'
		 * @param buff Creature stat is incremented by this value.
		 * @return (oldStat-newStat)
		 */
		public function addCombatBuff(stat:String, buff:Number):Number {
			switch(stat) {
				case 'str':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatStrBuff)
							as CombatStrBuff).applyEffect(buff);
				case 'spe':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatSpeBuff)
							as CombatSpeBuff).applyEffect(buff);
				case 'tou':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatTouBuff)
							as CombatTouBuff).applyEffect(buff);
				case 'int':
				case 'inte':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatInteBuff)
							as CombatInteBuff).applyEffect(buff);
				default:
					CoC_Settings.error("/!\\ ERROR: addCombatBuff('"+stat+"', "+buff+")");
					return 0;
			}
		}
		
		/* [    ? ? ?    ] */
		public function biggestTitSize():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].breastRating < breastRows[counter].breastRating)
					index = counter;
			}
			return breastRows[index].breastRating;
		}
		
		public function cockArea(i_cockIndex:Number):Number
		{
			if (i_cockIndex >= cocks.length || i_cockIndex < 0)
				return 0;
			return (cocks[i_cockIndex].cockThickness * cocks[i_cockIndex].cockLength);
		}
		
		public function biggestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[biggestCockIndex()].cockLength;
		}
		
		public function biggestCockArea():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			return cockArea(index);
		}
		
		//Find the second biggest dick and it's area.
		public function biggestCockArea2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = -1;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Is this spot claimed by the biggest?
				if (counter != index)
				{
					//Not set yet?
					if (index2 == -1)
						index2 = counter;
					//Is the stored value less than the current one?
					if (cockArea(index2) < cockArea(counter))
					{
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return cockArea(index2);
		}
		
		public function longestCock():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength < cocks[counter].cockLength)
					index = counter;
			}
			return index;
		}
		
		public function longestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength < cocks[counter].cockLength)
					index = counter;
			}
			return cocks[index].cockLength;
		}
		
		public function longestHorseCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if ((cocks[index].cockType != CockTypesEnum.HORSE && cocks[counter].cockType == CockTypesEnum.HORSE) || (cocks[index].cockLength < cocks[counter].cockLength && cocks[counter].cockType == CockTypesEnum.HORSE))
					index = counter;
			}
			return cocks[index].cockLength;
		}
		
		public function twoDickRadarSpecial(width:int):Boolean
		{
			//No two dicks?  FUCK OFF
			if (cockTotal() < 2)
				return false;
			
			//Set up vars
			//Get thinnest, work done already
			var thinnest:int = thinnestCockIndex();
			var thinnest2:int = 0;
			//For ze loop
			var temp:int = 0;
			//Make sure they arent the same at initialization
			if (thinnest2 == thinnest)
				thinnest2 = 1;
			//Loop through to find 2nd thinnest
			while (temp < cocks.length)
			{
				if (cocks[thinnest2].cockThickness > cocks[temp].cockThickness && temp != thinnest)
					thinnest2 = temp;
				temp++;
			}
			//If the two thicknesses added together are less than the arg, true, else false
			return cocks[thinnest].cockThickness + cocks[thinnest2].cockThickness < width;
		}
		
		public function totalCockThickness():Number
		{
			var thick:Number = 0;
			var counter:Number = cocks.length;
			while (counter > 0)
			{
				counter--;
				thick += cocks[counter].cockThickness;
			}
			return thick;
		}
		
		public function thickestCock():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness < cocks[counter].cockThickness)
					index = counter;
			}
			return index;
		}
		
		public function thickestCockThickness():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness < cocks[counter].cockThickness)
					index = counter;
			}
			return cocks[index].cockThickness;
		}
		
		public function thinnestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness > cocks[counter].cockThickness)
					index = counter;
			}
			return index;
		}
		
		public function smallestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) > cockArea(counter))
				{
					index = counter;
				}
			}
			return index;
		}
		
		public function smallestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[smallestCockIndex()].cockLength;
		}
		
		public function shortestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength > cocks[counter].cockLength)
					index = counter;
			}
			return index;
		}
		
		public function shortestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength > cocks[counter].cockLength)
					index = counter;
			}
			return cocks[index].cockLength;
		}
		
		//Find the biggest cock that fits inside a given value
		public function cockThatFits(i_fits:Number = 0, type:String = "area"):Number
		{
			if (cocks.length <= 0)
				return -1;
			var cockIdxPtr:int = cocks.length;
			//Current largest fitter
			var cockIndex:int = -1;
			while (cockIdxPtr > 0)
			{
				cockIdxPtr--;
				if (type == "area")
				{
					if (cockArea(cockIdxPtr) <= i_fits)
					{
						//If one already fits
						if (cockIndex >= 0)
						{
							//See if the newcomer beats the saved small guy
							if (cockArea(cockIdxPtr) > cockArea(cockIndex))
								cockIndex = cockIdxPtr;
						}
						//Store the index of fitting dick
						else
							cockIndex = cockIdxPtr;
					}
				}
				else if (type == "length")
				{
					if (cocks[cockIdxPtr].cockLength <= i_fits)
					{
						//If one already fits
						if (cockIndex >= 0)
						{
							//See if the newcomer beats the saved small guy
							if (cocks[cockIdxPtr].cockLength > cocks[cockIndex].cockLength)
								cockIndex = cockIdxPtr;
						}
						//Store the index of fitting dick
						else
							cockIndex = cockIdxPtr;
					}
				}
			}
			return cockIndex;
		}
		
		//Find the 2nd biggest cock that fits inside a given value
		public function cockThatFits2(fits:Number = 0):Number
		{
			if (cockTotal() == 1)
				return -1;
			var counter:Number = cocks.length;
			//Current largest fitter
			var index:Number = -1;
			var index2:Number = -1;
			while (counter > 0)
			{
				counter--;
				//Does this one fit?
				if (cockArea(counter) <= fits)
				{
					//If one already fits
					if (index >= 0)
					{
						//See if the newcomer beats the saved small guy
						if (cockArea(counter) > cockArea(index))
						{
							//Save old wang
							if (index != -1)
								index2 = index;
							index = counter;
						}
						//If this one fits and is smaller than the other great
						else
						{
							if ((cockArea(index2) < cockArea(counter)) && counter != index)
							{
								index2 = counter;
							}
						}
						if (index >= 0 && index == index2)
							CoC_Settings.error("FUCK ERROR COCKTHATFITS2 SHIT IS BROKED!");
					}
					//Store the index of fitting dick
					else
						index = counter;
				}
			}
			return index2;
		}
		
		public function smallestCockArea():Number
		{
			if (cockTotal() == 0)
				return -1;
			return cockArea(smallestCockIndex());
		}
		
		public function smallestCock():Number
		{
			return cockArea(smallestCockIndex());
		}
		
		public function biggestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			return index;
		}
		
		//Find the second biggest dick's index.
		public function biggestCockIndex2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = 0;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if (index == index2 && counter != index)
					index2 = counter;
				//Is the stored value less than the current one?
				if (cockArea(index2) < cockArea(counter))
				{
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if (counter != index)
						index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return index2;
		}
		
		public function smallestCockIndex2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = 0;
			//Find the smallest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) > cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if (index == index2 && counter != index)
					index2 = counter;
				//Is the stored value less than the current one?
				if (cockArea(index2) > cockArea(counter))
				{
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if (counter != index)
						index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return index2;
		}
		
		//Find the third biggest dick index.
		public function biggestCockIndex3():Number
		{
			if (cocks.length <= 2)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = -1;
			var index3:Number = -1;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//If this index isn't used already
				if (counter != index)
				{
					//Has index been set to anything yet?
					if (index2 == -1)
						index2 = counter;
					//Is the stored value less than the current one?
					else if (cockArea(index2) < cockArea(counter))
					{
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2 || index2 == -1)
				index2 = 0;
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//If this index isn't used already
				if (counter != index && counter != index2)
				{
					//Has index been set to anything yet?
					if (index3 == -1)
						index3 = counter;
					//Is the stored value less than the current one?
					else if (cockArea(index3) < cockArea(counter))
					{
						index3 = counter;
					}
				}
			}
			//If it fails for some reason.
			if (index3 == -1)
				index3 = 0;
			return index3;
		}

		
		public function cockDescript(cockIndex:int = 0):String
		{
			return Appearance.cockDescript(this, cockIndex);
		}
		
		public function cockAdjective(index:Number = -1):String {
			if (index < 0) index = biggestCockIndex();
			var isPierced:Boolean = (cocks.length == 1) && (cocks[index].isPierced); //Only describe as pierced or sock covered if the creature has just one cock
			var hasSock:Boolean = (cocks.length == 1) && (cocks[index].sock != "");
			var isGooey:Boolean = (skin.type == Skin.GOO);
			return Appearance.cockAdjective(cocks[index].cockType, cocks[index].cockLength, cocks[index].cockThickness, lust, cumQ(), isPierced, hasSock, isGooey);
		}
		
		public function wetness():Number
		{
			if (vaginas.length == 0)
				return 0;
			else
				return vaginas[0].vaginalWetness;
		}
		
		public function vaginaType(newType:int = -1):int
		{
			if (!hasVagina())
				return -1;
			if (newType != -1)
			{
				vaginas[0].type = newType;
			}
			return vaginas[0].type;
		}
		
		public function looseness(vag:Boolean = true):Number
		{
			if (vag)
			{
				if (vaginas.length == 0)
					return 0;
				else
					return vaginas[0].vaginalLooseness;
			}
			else
			{
				return ass.analLooseness;
			}
		}
		
		/**
		 * Get the vaginal capacity bonus based on body type, perks and the bonus capacity status.
		 * 
		 * @return the vaginal capacity bonus for this creature
		 */
		private function vaginalCapacityBonus():Number {
			var bonus:Number = 0;
			
			if (!hasVagina()) {
				return 0;
			}

			if (isTaur()){
				bonus += 50;
			}else if (lowerBody.type == LowerBody.NAGA){
				bonus += 20;
			}
			if (hasPerk(PerkLib.WetPussy))
				bonus += 20;
			if (hasPerk(PerkLib.HistorySlut))
				bonus += 20;
			if (hasPerk(PerkLib.OneTrackMind))
				bonus += 10;
			if (hasPerk(PerkLib.Cornucopia))
				bonus += 30;
			if (hasPerk(PerkLib.FerasBoonWideOpen))
				bonus += 25;
			if (hasPerk(PerkLib.FerasBoonMilkingTwat))
				bonus += 40;
				
			bonus += statusEffectv1(StatusEffects.BonusVCapacity);	
				
			return bonus;
		}
		
		public function vaginalCapacity():Number
		{
			if (!hasVagina()) {
				return 0;
			}
				
			var bonus:Number = vaginalCapacityBonus();
			return vaginas[0].capacity(bonus);
		}
		
		public function analCapacity():Number
		{
			var bonus:Number = 0;
			//Centaurs = +30 capacity
			if (isTaur())
				bonus = 30;
			if (hasPerk(PerkLib.HistorySlut))
				bonus += 20;
			if (hasPerk(PerkLib.Cornucopia))
				bonus += 30;
			if (hasPerk(PerkLib.OneTrackMind))
				bonus += 10;
			if (ass.analWetness > 0)
				bonus += 15;
			return ((bonus + statusEffectv1(StatusEffects.BonusACapacity) + 6 * ass.analLooseness * ass.analLooseness) * (1 + ass.analWetness / 10));
		}
		
		public function hasFuckableNipples():Boolean
		{
			var counter:Number = breastRows.length;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].fuckable)
					return true;
			}
			return false;
		}
		
		public function hasBreasts():Boolean
		{
			if (breastRows.length > 0)
			{
				if (biggestTitSize() >= 1)
					return true;
			}
			return false;
		}
		
		public function hasNipples():Boolean
		{
			var counter:Number = breastRows.length;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].nipplesPerBreast > 0)
					return true;
			}
			return false;
		}
		
		public function lactationSpeed():Number
		{
			//Lactation * breastSize x 10 (milkPerBreast) determines scene
			return biggestLactation() * biggestTitSize() * 10;
		}
		
		//Hacky code till I can figure out how to move appearance code out.
		//TODO: Get rid of this 
		public virtual function dogScore():Number {
			throw new Error("Not implemented. BAD");
		}
		
		//Hacky code till I can figure out how to move appearance code out.
		//TODO: Get rid of this
		public virtual function foxScore():Number {
			throw new Error("Not implemented. BAD");
		}
		
		public function biggestLactation():Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
					index = counter;
			}
			return breastRows[index].lactationMultiplier;
		}
		public function milked():void
		{
			if (hasStatusEffect(StatusEffects.LactationReduction))
				changeStatusValue(StatusEffects.LactationReduction, 1, 0);
			if (hasStatusEffect(StatusEffects.LactationReduc0))
				removeStatusEffect(StatusEffects.LactationReduc0);
			if (hasStatusEffect(StatusEffects.LactationReduc1))
				removeStatusEffect(StatusEffects.LactationReduc1);
			if (hasStatusEffect(StatusEffects.LactationReduc2))
				removeStatusEffect(StatusEffects.LactationReduc2);
			if (hasStatusEffect(StatusEffects.LactationReduc3))
				removeStatusEffect(StatusEffects.LactationReduc3);
			if (hasPerk(PerkLib.Feeder))
			{
				//You've now been milked, reset the timer for that
				addStatusValue(StatusEffects.Feeder,1,1);
				changeStatusValue(StatusEffects.Feeder, 2, 0);
			}
		}
		public function boostLactation(todo:Number):Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			var changes:Number = 0;
			var temp2:Number = 0;
			//Prevent lactation decrease if lactating.
			if (todo >= 0)
			{
				if (hasStatusEffect(StatusEffects.LactationReduction))
					changeStatusValue(StatusEffects.LactationReduction, 1, 0);
				if (hasStatusEffect(StatusEffects.LactationReduc0))
					removeStatusEffect(StatusEffects.LactationReduc0);
				if (hasStatusEffect(StatusEffects.LactationReduc1))
					removeStatusEffect(StatusEffects.LactationReduc1);
				if (hasStatusEffect(StatusEffects.LactationReduc2))
					removeStatusEffect(StatusEffects.LactationReduc2);
				if (hasStatusEffect(StatusEffects.LactationReduc3))
					removeStatusEffect(StatusEffects.LactationReduc3);
			}
			if (todo > 0)
			{
				while (todo > 0)
				{
					counter = breastRows.length;
					todo -= .1;
					while (counter > 0)
					{
						counter--;
						if (breastRows[index].lactationMultiplier > breastRows[counter].lactationMultiplier)
							index = counter;
					}
					temp2 = .1;
					if (breastRows[index].lactationMultiplier > 1.5)
						temp2 /= 2;
					if (breastRows[index].lactationMultiplier > 2.5)
						temp2 /= 2;
					if (breastRows[index].lactationMultiplier > 3)
						temp2 /= 2;
					changes += temp2;
					breastRows[index].lactationMultiplier += temp2;
				}
			}
			else
			{
				while (todo < 0)
				{
					counter = breastRows.length;
					index = 0;
					if (todo > -.1)
					{
						while (counter > 0)
						{
							counter--;
							if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
								index = counter;
						}
						//trace(biggestLactation());
						breastRows[index].lactationMultiplier += todo;
						if (breastRows[index].lactationMultiplier < 0)
							breastRows[index].lactationMultiplier = 0;
						todo = 0;
					}
					else
					{
						todo += .1;
						while (counter > 0)
						{
							counter--;
							if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
								index = counter;
						}
						temp2 = todo;
						changes += temp2;
						breastRows[index].lactationMultiplier += temp2;
						if (breastRows[index].lactationMultiplier < 0)
							breastRows[index].lactationMultiplier = 0;
					}
				}
			}
			return changes;
		}
		
		public function averageLactation():Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				index += breastRows[counter].lactationMultiplier;
			}
			return Math.floor(index / breastRows.length);
		}
		
		//Calculate bonus virility rating!
		//anywhere from 5% to 100% of normal cum effectiveness thru herbs!
		public function virilityQ():Number
		{
			if (!hasCock())
				return 0;
			var percent:Number = 0.01;
			if (cumQ() >= 250)
				percent += 0.01;
			if (cumQ() >= 800)
				percent += 0.01;
			if (cumQ() >= 1600)
				percent += 0.02;
			if (hasPerk(PerkLib.BroBody))
				percent += 0.05;
			if (hasPerk(PerkLib.MaraesGiftStud))
				percent += 0.15;
			if (hasPerk(PerkLib.FerasBoonAlpha))
				percent += 0.10;
			if (perkv1(PerkLib.ElvenBounty) > 0)
				percent += 0.05;
			if (hasPerk(PerkLib.FertilityPlus))
				percent += 0.03;
			if (hasPerk(PerkLib.FertilityMinus) && lib100 < 25) //Reduces virility by 3%.
				percent -= 0.03;
			if (hasPerk(PerkLib.PiercedFertite))
				percent += 0.03;
			if (hasPerk(PerkLib.OneTrackMind))
				percent += 0.03;
			if (hasPerk(PerkLib.MagicalVirility))
				percent += 0.05 + (perkv1(PerkLib.MagicalVirility) * 0.01);
			//Messy Orgasms?
			if (hasPerk(PerkLib.MessyOrgasms))
				percent += 0.03;
			//Satyr Sexuality
			if (hasPerk(PerkLib.SatyrSexuality))
				percent += 0.10;
			//Fertite ring bonus!
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				percent += (jewelryEffectMagnitude / 100);
			if (hasPerk(PerkLib.AscensionVirility))
				percent += perkv1(PerkLib.AscensionVirility) * 0.05;				
			if (percent > 1)
				percent = 1;
			if (percent < 0)
				percent = 0;

			return percent;
		}
		
		//Calculate cum return
		public function cumQ():Number
		{
			if (!hasCock())
				return 0;
			var quantity:Number = 0;
			//Base value is ballsize*ballQ*cumefficiency by a factor of 2.
			//Other things that affect it: 
			//lust - 50% = normal output.  0 = half output. 100 = +50% output.
			//trace("CUM ESTIMATE: " + int(1.25*2*cumMultiplier*2*(lust + 50)/10 * (hoursSinceCum+10)/24)/10 + "(no balls), " + int(ballSize*balls*cumMultiplier*2*(lust + 50)/10 * (hoursSinceCum+10)/24)/10 + "(withballs)");
			var lustCoefficient:Number = (lust + 50) / 10;
			//If realistic mode is enabled, limits cum to capacity.
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				lustCoefficient = (lust + 50) / 5;
				if (hasPerk(PerkLib.PilgrimsBounty)) lustCoefficient = 30;
				var percent:Number = 0;
				percent = lustCoefficient + (hoursSinceCum + 10);
				if (percent > 100)
					percent = 100;
				if (quantity > cumCapacity()) 
					quantity = cumCapacity();
				return (percent / 100) * cumCapacity();
			}
			//Pilgrim's bounty maxes lust coefficient
			if (hasPerk(PerkLib.PilgrimsBounty))
				lustCoefficient = 150 / 10;
			if (balls == 0)
				quantity = int(1.25 * 2 * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			else
				quantity = int(ballSize * balls * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			if (hasPerk(PerkLib.BroBody))
				quantity *= 1.3;
			if (hasPerk(PerkLib.FertilityPlus))
				quantity *= 1.5;
			if (hasPerk(PerkLib.FertilityMinus) && lib100 < 25)
				quantity *= 0.7;
			if (hasPerk(PerkLib.MessyOrgasms))
				quantity *= 1.5;
			if (hasPerk(PerkLib.OneTrackMind))
				quantity *= 1.1;
			if (hasPerk(PerkLib.MaraesGiftStud))
				quantity += 350;
			if (hasPerk(PerkLib.FerasBoonAlpha))
				quantity += 200;
			if (hasPerk(PerkLib.MagicalVirility))
				quantity += 200 + (perkv1(PerkLib.MagicalVirility) * 100);
			if (hasPerk(PerkLib.FerasBoonSeeder))
				quantity += 1000;
			//if (hasPerk("Elven Bounty") >= 0) quantity += 250;;
			quantity += perkv1(PerkLib.ElvenBounty);
			if (hasPerk(PerkLib.BroBody))
				quantity += 200;
			if (hasPerk(PerkLib.SatyrSexuality))
				quantity += 50;
			quantity += statusEffectv1(StatusEffects.Rut);
			quantity *= (1 + (2 * perkv1(PerkLib.PiercedFertite)) / 100);
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				quantity *= (1 + (jewelryEffectMagnitude / 100));
			//trace("Final Cum Volume: " + int(quantity) + "mLs.");
			//if (quantity < 0) trace("SOMETHING HORRIBLY WRONG WITH CUM CALCULATIONS");
			if (quantity < 2)
				quantity = 2;
			if (quantity > int.MAX_VALUE)
				quantity = int.MAX_VALUE;
			return quantity;
		}
		
		//Limits how much cum you can produce. Can be altered with perks, ball size, and multiplier. Only applies to realistic mode.
		public function cumCapacity():Number 
		{
			if (!hasCock()) return 0;
			var cumCap:Number = 0;
			//Alter capacity by balls.
			if (balls > 0) cumCap += Math.pow(((4 / 3) * Math.PI * (ballSize / 2)), 3) * balls// * cumMultiplier
			else cumCap +=  Math.pow(((4 / 3) * Math.PI * 1), 3) * 2// * cumMultiplier
			//Alter capacity by perks.
			if (hasPerk(PerkLib.BroBody)) cumCap *= 1.3;
			if (hasPerk(PerkLib.FertilityPlus)) cumCap *= 1.5;
			if (hasPerk(PerkLib.FertilityMinus) && lib100 < 25) cumCap *= 0.7;
			if (hasPerk(PerkLib.MessyOrgasms)) cumCap *= 1.5;
			if (hasPerk(PerkLib.OneTrackMind)) cumCap *= 1.1;
			if (hasPerk(PerkLib.MaraesGiftStud)) cumCap += 350;
			if (hasPerk(PerkLib.FerasBoonAlpha)) cumCap += 200;
			if (hasPerk(PerkLib.MagicalVirility)) cumCap += 200;
			if (hasPerk(PerkLib.FerasBoonSeeder)) cumCap += 1000;
			cumCap += perkv1(PerkLib.ElvenBounty);
			if (hasPerk(PerkLib.BroBody)) cumCap += 200;
			cumCap += statusEffectv1(StatusEffects.Rut);
			cumCap *= (1 + (2 * perkv1(PerkLib.PiercedFertite)) / 100);
			//Alter capacity by accessories.
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY) cumCap *= (1 + (jewelryEffectMagnitude / 100));
				
			cumCap *= cumMultiplier
			cumCap == Math.round(cumCap);
			if (cumCap > int.MAX_VALUE) 
				cumCap = int.MAX_VALUE;
			return cumCap;
		}
		
		public function countCocksOfType(type:CockTypesEnum):int {
			if (cocks.length == 0) return 0;
			var counter:int = 0;
			for (var x:int = 0; x < cocks.length; x++) {
				if (cocks[x].cockType == type) counter++;
			}
			return counter;
		}
		
		// Note: DogCocks/FoxCocks are functionally identical. They actually change back and forth depending on some
		// of the PC's attributes, and this is recaluculated every hour spent at camp.
		// As such, delineating between the two is kind of silly.
		public function dogCocks():int { //How many dogCocks
			if (cocks.length == 0) return 0;
			return countCocksOfType(CockTypesEnum.DOG) + countCocksOfType(CockTypesEnum.FOX);
		}
		
		public function wolfCocks():int {
			if (cocks.length == 0) return 0;
			return countCocksOfType(CockTypesEnum.WOLF);
		}
		
		public function findFirstCockType(ctype:CockTypesEnum):Number
		{
			var index:Number = 0;
			//if (cocks[index].cockType == ctype)
			//	return index;
			for (index = 0; index < cocks.length; index++) {
				if (cocks[index].cockType == ctype)
					return index;
			}
			//trace("Creature.findFirstCockType ERROR - searched for cocktype: " + ctype + " and could not find it.");
			return 0;
		}
		
		/*public function findFirstCockType(type:Number = 0):Number
		{
			var index:Number = 0;
			if (cocks[index].cockType == type)
				return index;
			while (index < cocks.length)
			{
				index++;
				if (cocks[index].cockType == type)
					return index;
			}
			//trace("Creature.findFirstCockType ERROR - searched for cocktype: " + type + " and could not find it.");
			return 0;
		}*/
		
		//Change first normal cock to horsecock!
		//Return number of affected cock, otherwise -1
		public function addHorseCock():Number
		{
			var counter:Number = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Human - > horse
				if (cocks[counter].cockType == CockTypesEnum.HUMAN)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Dog - > horse
				if (cocks[counter].cockType == CockTypesEnum.DOG)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Wolf - > horse
				if (cocks[counter].cockType == CockTypesEnum.WOLF)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Tentacle - > horse
				if (cocks[counter].cockType == CockTypesEnum.TENTACLE)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Demon -> horse
				if (cocks[counter].cockType == CockTypesEnum.DEMON)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Catch-all
				if (cocks[counter].cockType.Index > 4)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
			}
			return -1;
		}
		
		//TODO Seriously wtf. 1500+ calls to cockTotal, 340+ call to totalCocks. I'm scared to touch either.
		//How many cocks?
		public function cockTotal():Number
		{
			return (cocks.length);
		}
		
		//Alternate
		public function totalCocks():Number
		{
			return (cocks.length);
		}
		
		//BOolean alternate
		public function hasCock():Boolean
		{
			return cocks.length >= 1;

		}
		
		public function hasSockRoom():Boolean
		{
			var index:int = cocks.length;
			while (index > 0)
			{
				index--;
				if (cocks[index].sock == "")
					return true;
			}
			return false
		}
		
		public function hasSock(arg:String = ""):Boolean
		{
			var index:int = cocks.length;
			
			while (index > 0)
			{
				index--;
				if (cocks[index].sock != "")
				{
				if (arg == "" || cocks[index].sock == arg)
					return true;
				}
			}
			return false
		}
		public function countCockSocks(type:String):int
		{
			var count:int = 0;
			
			for (var i:Number = 0; i < cocks.length; i++) {
				if (cocks[i].sock == type) {
					count++
				}
			}
			//trace("countCockSocks found " + count + " " + type);
			return count;
		}
		
		public function canAutoFellate():Boolean
		{
			if (!hasCock())
				return false;
			return (cocks[0].cockLength >= 20);
		}

		public function copySkinToUnderBody(p:Object = null):void
		{
			underBody.skin.setProps(skin);
			if (p != null) underBody.skin.setProps(p);
		}

		//PC can fly?
		public function canFly():Boolean
		{
			//web also makes false!
			if (hasStatusEffect(StatusEffects.Web))
				return false;
			return BodyPartLists.CAN_FLY_WINGS.indexOf(wings.type) !== -1;
		}

		public function canUseStare():Boolean
		{
			return [Eyes.BASILISK, Eyes.COCKATRICE].indexOf(eyes.type) != -1;
		}

		public function isHoofed():Boolean
		{
			return [
				LowerBody.HOOFED,
				LowerBody.CLOVEN_HOOFED,
			].indexOf(lowerBody.type) != -1;
		}

		public function isCentaur():Boolean
		{
			return isTaur() && isHoofed();
		}

		public function isBimbo():Boolean
		{
			for each (var perk:PerkType in PerkLists.BIMBO)
				if (hasPerk(perk)) return true;

			return false;
		}

		//check for vagoo
		public function hasVagina():Boolean
		{
			return vaginas.length > 0;

		}
		
		public function hasVirginVagina():Boolean
		{
			if (vaginas.length > 0)
				return vaginas[0].virgin;
			return false;
		}

		//GENDER IDENTITIES
		public function genderText(male:String = "man", female:String = "woman", futa:String = "herm", eunuch:String = "eunuch"):String
		{
			if (vaginas.length > 0) {
				if (cocks.length > 0) return futa;
				return female;
			}
			else if (cocks.length > 0) {
				return male;
			}
			return eunuch;
		}

		public function manWoman(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "Futa";
					else
						return "futa";
				}
				else
				{
					if (caps)
						return "Man";
					else
						return "man";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "Woman";
					else
						return "woman";
				}
				else
				{
					if (caps)
						return "Eunuch";
					else
						return "eunuch";
				}
			}
		}
		
		public function mfn(male:String, female:String, neuter:String):String
		{
			if (gender == 0)
				return neuter;
			else
				return mf(male, female);
		}
		
		//Rewritten!
		public function mf(male:String, female:String):String
		{
			if (hasCock() && hasVagina()) // herm
				return (biggestTitSize() >= 2 || biggestTitSize() == 1 && femininity >= 50 || femininity >= 75) ? female : male;

			if (hasCock()) // male
				return (biggestTitSize() >= 1 && femininity > 55 || femininity >= 75) ? female : male;

			if (hasVagina()) // pure female
				return (biggestTitSize() > 1 || femininity >= 45) ? female : male;

			// genderless
			return (biggestTitSize() >= 3 || femininity >= 75) ? female : male;
		}
		
		public function maleFemaleHerm(caps:Boolean = false):String
		{
			switch (gender) {
				case Gender.NONE:   return caps ? mf("Genderless", "Fem-genderless") : mf("genderless", "fem-genderless");
				case Gender.MALE:   return caps ? mf("Male", biggestTitSize() > BreastCup.A ? "Shemale" : "Femboy")             : mf("male", biggestTitSize() > BreastCup.A ? "shemale" : "femboy");
				case Gender.FEMALE: return caps ? mf("Cuntboy", "Female")            : mf("cuntboy", "female");
				case Gender.HERM:   return caps ? mf("Maleherm", "Hermaphrodite")    : mf("maleherm", "hermaphrodite");
				default: return "<b>Gender error!</b>";
			}
		}
		
		/**
		 * Checks if the creature is technically male: has cock but not vagina.
		 */
		public function isMale():Boolean
		{
			return gender == Gender.MALE;
		}
		
		/**
		 * Checks if the creature is technically female: has vagina but not cock.
		 */
		public function isFemale():Boolean
		{
			return gender == Gender.FEMALE;
		}
		
		/**
		 * Checks if the creature is technically herm: has both cock and vagina.
		 */
		public function isHerm():Boolean
		{
			return gender == Gender.HERM;
		}
		
		/**
		 * Checks if the creature is technically genderless: has neither cock nor vagina.
		 */
		public function isGenderless():Boolean
		{
			return gender == Gender.NONE;
		}

		/**
		 * Checks if the creature is technically male or herm: has at least a cock.
		 */
		public function isMaleOrHerm():Boolean
		{
			return (gender & Gender.MALE) != 0;
		}

		/**
		 * Checks if the creature is technically female or herm: has at least a vagina.
		 */
		public function isFemaleOrHerm():Boolean
		{
			return (gender & Gender.FEMALE) != 0;
		}
		
		//Create a cock. Default type is HUMAN
		public function createCock(clength:Number = 5.5, cthickness:Number = 1,ctype:CockTypesEnum=null):Boolean
		{
			if (ctype == null) ctype = CockTypesEnum.HUMAN;
			if (cocks.length >= 10)
				return false;
			var newCock:Cock = new Cock(clength, cthickness,ctype);
			//var newCock:cockClass = new cockClass();
			cocks.push(newCock);
			cocks[cocks.length-1].cockThickness = cthickness;
			cocks[cocks.length-1].cockLength = clength;
			return true;
		}
		
		//create vagoo
		public function createVagina(virgin:Boolean = true, vaginalWetness:Number = 1, vaginalLooseness:Number = 0):Boolean
		{
			if (vaginas.length >= 2)
				return false;
			var newVagina:VaginaClass = new VaginaClass(vaginalWetness,vaginalLooseness,virgin);
			vaginas.push(newVagina);
			return true;
		}
		
		//create a row of breasts
		public function createBreastRow(size:Number=0,nipplesPerBreast:Number=1):Boolean
		{
			if (breastRows.length >= 10)
				return false;
			var newBreastRow:BreastRowClass = new BreastRowClass();
			newBreastRow.breastRating = size;
			newBreastRow.nipplesPerBreast = nipplesPerBreast;
			breastRows.push(newBreastRow);
			return true;
		}
		
		/**
		 * Remove cocks from the creature. 
		 * @param	arraySpot position of the cock in the array
		 * @param	totalRemoved the number of cocks to remove, 0 means no cocks removed
		 */
		public function removeCock(arraySpot:int, totalRemoved:int):void
		{
			//Various Errors preventing action
			if (arraySpot < 0 || totalRemoved <= 0)
			{
				//trace("ERROR: removeCock called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (cocks.length == 0)
			{
				//trace("ERROR: removeCock called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > cocks.length - 1)
				{
					//trace("ERROR: removeCock failed - array location is beyond the bounds of the array.");
				}
				else
				{
					try
					{
						var cock:Cock = cocks[arraySpot];
						if (cock.sock == "viridian")
						{
							removePerk(PerkLib.LustyRegeneration);
						}
						else if (cock.sock == "cockring")
						{
							var numRings:int = 0;
							for (var i:int = 0; i < cocks.length; i++)
							{
								if (cocks[i].sock == "cockring") numRings++;
							}
							
							if (numRings == 0) removePerk(PerkLib.PentUp);
							else setPerkValue(PerkLib.PentUp, 1, 5 + (numRings * 5));
						}
						cocks.splice(arraySpot, totalRemoved);
					}
					catch (e:Error)
					{
						CoC_Settings.error("Argument error in Creature[" + this._short + "]: " + e.message);
					}
					//trace("Attempted to remove " + totalRemoved + " cocks.");
				}
			}
		}
		
		//REmove vaginas
		public function removeVagina(arraySpot:int = 0, totalRemoved:int = 1):void
		{
			//Various Errors preventing action
			if (arraySpot < -1 || totalRemoved <= 0)
			{
				//trace("ERROR: removeVagina called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (vaginas.length == 0)
			{
				//trace("ERROR: removeVagina called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > vaginas.length - 1)
				{
					//trace("ERROR: removeVagina failed - array location is beyond the bounds of the array.");
				}
				else
				{
					vaginas.splice(arraySpot, totalRemoved);
					//trace("Attempted to remove " + totalRemoved + " vaginas.");
				}
			}
		}
		
		//Remove a breast row
		public function removeBreastRow(arraySpot:int, totalRemoved:int):void
		{
			//Various Errors preventing action
			if (arraySpot < -1 || totalRemoved <= 0)
			{
				//trace("ERROR: removeBreastRow called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (breastRows.length == 0)
			{
				//trace("ERROR: removeBreastRow called but cocks do not exist.");
			}
			else if (breastRows.length == 1 || breastRows.length - totalRemoved < 1)
			{
				//trace("ERROR: Removing the current breast row would break the Creature classes assumptions about breastRow contents.");
			}
			else
			{
				if (arraySpot > breastRows.length - 1)
				{
					//trace("ERROR: removeBreastRow failed - array location is beyond the bounds of the array.");
				}
				else
				{
					breastRows.splice(arraySpot, totalRemoved);
					//trace("Attempted to remove " + totalRemoved + " breastRows.");
				}
			}
		}
		
		/**
		 * Removes all gender releated parts: cocks, vaginas, breasts and balls.
		 */
		public function clearGender(): void {
			LOGGER.info("Clearing gender...");
			
			LOGGER.debug("Removing balls");
			balls = 0;
			
			while (hasCock()) {
				LOGGER.debug("Removing cock {0}", cocks[0]);
				removeCock(0, 1);
			}
			
			while (hasVagina()) {
				LOGGER.debug("Removing vagina {0}", vaginas[0]);
				removeVagina(0, 1);
			}
			
			// hasBreasts can currently not be used, as creatures must have at least one breast row
			while (breastRows.length > 1) {
				LOGGER.debug("Removing breast {0}", breastRows[0]);
				removeBreastRow(0, 1);
			}
			
			if (hasBreasts()) {
				LOGGER.debug("Setting breast row {0}, size to flat (size 0)", breastRows[0]);
				breastRows[0].breastRating = 0;
			}
		}
		
		// This is placeholder shit whilst I work out a good way of BURNING ENUM TO THE FUCKING GROUND
		// and replacing it with something that will slot in and work with minimal changes and not be
		// A FUCKING SHITSTAIN when it comes to intelligent de/serialization.
		public function fixFuckingCockTypesEnum():void
		{
			if (this.cocks.length > 0)
			{
				for (var i:int = 0; i < this.cocks.length; i++)
				{
					this.cocks[i].cockType = CockTypesEnum.ParseConstantByIndex(this.cocks[i].cockType.Index);
				}
			}
		}

		public function buttChangeNoDisplay(cArea:Number):Boolean {
			LOGGER.debug("Attempting anal stretch for {0} with anal capacity of {1} vs a cock area of {2}", this, analCapacity(), cArea);
			var stretched:Boolean = false;
			//cArea > capacity = autostreeeeetch half the time.
			if (cArea >= analCapacity() && rng.random(2) === 0) {
				ass.analLooseness++;
				stretched = true;
				//Reset butt stretchin recovery time
				if (hasStatusEffect(StatusEffects.ButtStretched)) {
					changeStatusValue(StatusEffects.ButtStretched,1,0);
				}
			}
			//If within top 10% of capacity, 25% stretch
			if (cArea < analCapacity() && cArea >= .9*analCapacity() && rng.random(4) === 0) {
				ass.analLooseness++;
				stretched = true;
			}
			//if within 75th to 90th percentile, 10% stretch
			if (cArea < .9 * analCapacity() && cArea >= .75 * analCapacity() && rng.random(10) === 0) {
				ass.analLooseness++;
				stretched = true;
			}
			//Anti-virgin
			if (ass.analLooseness === 0) {
				ass.analLooseness++;
				stretched = true;
			}
			
			if (ass.analLooseness > 5) {
				ass.analLooseness = 5;
			}
			//Delay un-stretching
			if (cArea >= .5 * analCapacity()) {
				//Butt Stretched used to determine how long since last enlargement
				if (!hasStatusEffect(StatusEffects.ButtStretched)) {
					createStatusEffect(StatusEffects.ButtStretched,0,0,0,0);
				}
				//Reset the timer on it to 0 when restretched.
				else {
					changeStatusValue(StatusEffects.ButtStretched,1,0);
				}
			}
			
			if (stretched) {
				LOGGER.debug("Butt Stretched to {0}", ass.analLooseness);
			}
			
			return stretched;
		}

		public function cuntChangeNoDisplay(cArea : Number) : Boolean {
			if (vaginas.length == 0) return false;
			var stretched : Boolean = vaginas[0].stretch(cArea, vaginalCapacityBonus(), hasPerk(PerkLib.FerasBoonMilkingTwat));
			
			// Delay stretch recovery
			if (cArea >= .5 * vaginalCapacity()) {
				vaginas[0].resetRecoveryProgress();
			}
			
			return stretched;
		}
		
		public function get inHeat():Boolean {
			return hasStatusEffect(StatusEffects.Heat);
		}
		
		public function get inRut():Boolean {
			return hasStatusEffect(StatusEffects.Rut);
		}

		public function bonusFertility():Number
		{
			var counter:Number = 0;
			if (inHeat)
				counter += statusEffectv1(StatusEffects.Heat);
			if (hasPerk(PerkLib.FertilityPlus))
				counter += 15;
			if (hasPerk(PerkLib.FertilityMinus) && lib100 < 25)
				counter -= 15;
			if (hasPerk(PerkLib.MaraesGiftFertility))
				counter += 50;
			if (hasPerk(PerkLib.FerasBoonBreedingBitch))
				counter += 30;
			if (hasPerk(PerkLib.MagicalFertility))
				counter += 10 + (perkv1(PerkLib.MagicalFertility) * 5);
			counter += perkv2(PerkLib.ElvenBounty);
			counter += perkv1(PerkLib.PiercedFertite);
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				counter += jewelryEffectMagnitude;
			counter += perkv1(PerkLib.AscensionFertility) * 5;
			return counter;
		}

		public function totalFertility():Number
		{
			return (bonusFertility() + fertility);
		}

		public function hasBeak():Boolean
		{
			return [Face.BEAK, Face.COCKATRICE].indexOf(face.type) != -1;
		}

		public function hasClaws():Boolean
		{
			return arms.claws.type !== Claws.NORMAL;
		}

		public function hasGills():Boolean
		{
			return gills.type != Gills.NONE;
		}

		public function hasTail():Boolean
		{
			return tail.type !== Tail.NONE;
		}

		public function hasFeathers():Boolean
		{
			return skin.hasFeathers();
		}

		public function hasScales():Boolean
		{
			return [Skin.LIZARD_SCALES, Skin.DRAGON_SCALES, Skin.FISH_SCALES].indexOf(skin.type) != -1;
		}

		public function hasReptileScales():Boolean
		{
			return [Skin.LIZARD_SCALES, Skin.DRAGON_SCALES].indexOf(skin.type) != -1;
		}

		public function hasDragonScales():Boolean
		{
			return skin.type == Skin.DRAGON_SCALES;
		}

		public function hasLizardScales():Boolean
		{
			return skin.type == Skin.LIZARD_SCALES;
		}

		public function hasNonLizardScales():Boolean
		{
			return hasScales() && !hasLizardScales();
		}

		public function hasFur():Boolean
		{
			return skin.hasFur();
		}
		public function hasWool():Boolean
		{
			return skin.hasWool();
		}
		public function isFurry():Boolean
		{
			return skin.isFurry();
		}

		public function isFluffy():Boolean
		{
			return skin.isFluffy();
		}

		public function isFurryOrScaley():Boolean
		{
			return isFurry() || hasScales();
		}

		public function hasGooSkin():Boolean
		{
			return skin.type == Skin.GOO;
		}

		public function hasPlainSkin():Boolean
		{
			return skin.type == Skin.PLAIN;
		}

		public function get hairOrFurColors():String
		{
			if (!isFluffy())
				return hair.color;

			if (!underBody.skin.isFluffy() || ["no", skin.furColor].indexOf(underBody.skin.furColor) != -1)
				return skin.furColor;

			// Uses formatStringArray in case we add more skin layers
			// If more layers are added, we'd probably need some remove duplicates function
			return formatStringArray([
				skin.furColor,
				underBody.skin.furColor,
			]);
		}

		public function isBiped():Boolean
		{
			return lowerBody.legCount == 2;
		}

		public function isNaga():Boolean
		{
			return lowerBody.type == LowerBody.NAGA;
		}

		public function isTaur():Boolean
		{
			return lowerBody.legCount > 2 && !isDrider(); // driders have genitals on their human part, inlike usual taurs... this is actually bad way to check, but too many places to fix just now
		}

		public function isDrider():Boolean
		{
			return lowerBody.type == LowerBody.DRIDER;
		}

		public function hasSpiderEyes():Boolean
		{
			return eyes.type == Eyes.SPIDER && eyes.count == 4;
		}

		public function isGoo():Boolean
		{
			return lowerBody.type == LowerBody.GOO;
		}

		public function legs():String
		{
			var select:Number = 0;

			if (isDrider())
				return num2Text(lowerBody.legCount)+" spider legs";
			if (isTaur())
				return num2Text(lowerBody.legCount)+" legs";
			if (lowerBody.type == LowerBody.HUMAN)
				return "legs";
			if (lowerBody.type == LowerBody.HOOFED)
				return "legs";
			if (lowerBody.type == LowerBody.DOG)
				return "legs";
			if (lowerBody.type == LowerBody.NAGA)
				return "snake-like coils";
			if (lowerBody.type == LowerBody.GOO)
				return "mounds of goo";
			if (lowerBody.type == LowerBody.PONY)
				return "cute pony-legs";
			if (lowerBody.type == LowerBody.BUNNY) {
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "fuzzy, bunny legs";
				else if (select == 1)
					return "fur-covered legs";
				else if (select == 2)
					return "furry legs";
				else
					return "legs";
			}
			if (lowerBody.type == LowerBody.HARPY) {
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "bird-like legs";
				else if (select == 1)
					return "feathered legs";
				else
					return "legs";
			}
			if (lowerBody.type == LowerBody.FOX) {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "fox-like legs";
				else if (select == 1)
					return "legs";
				else if (select == 2)
					return "legs";
				else
					return "vulpine legs";
			}
			if (lowerBody.type == LowerBody.RACCOON) {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "raccoon-like legs";
				else
					return "legs";
			}
			if (lowerBody.type == LowerBody.CLOVEN_HOOFED) {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "pig-like legs";
				else if (select == 1)
					return "legs";
				else if (select == 2)
					return "legs";
				else
					return "swine legs";
			}
			return "legs";
		}

		public function skinDescript(...args):String { return skin.description.apply(null, args); }

		public function skinFurScales():String { return skin.skinFurScales(); }

		// <mod name="Predator arms" author="Stadler76">
		public function clawsDescript():String
		{
			var toneText:String = arms.claws.tone == "" ? " " : (", " + arms.claws.tone + " ");

			switch (arms.claws.type) {
				case Claws.NORMAL: return "fingernails";
				case Claws.DRAGON: return "powerful, thick curved" + toneText + "claws";
				case Claws.IMP:    return "long" + toneText + "claws";
				case Claws.CAT:    return "long, thin curved" + toneText + "claws";
				case Claws.LIZARD:
				case Claws.DOG:
				case Claws.FOX:    return "short curved" + toneText + "claws";
				default: // Since mander and cockatrice arms are hardcoded and the others are NYI, we're done here for now
			}
			return "fingernails";
		}
		// </mod>

		public function leg():String
		{
			var select:Number = 0;

			if (lowerBody.type == LowerBody.HUMAN)
				return "leg";
			if (lowerBody.type == LowerBody.HOOFED)
				return "leg";
			if (lowerBody.type == LowerBody.DOG)
				return "leg";
			if (lowerBody.type == LowerBody.NAGA)
				return "snake-tail";
			if (lowerBody.type == LowerBody.HOOFED && isTaur())
				return "equine leg";
			if (lowerBody.type == LowerBody.GOO)
				return "mound of goo";
			if (lowerBody.type == LowerBody.PONY)
				return "cartoonish pony-leg";
			if (lowerBody.type == LowerBody.BUNNY) {
				select = Math.random() * (5);
				if (select == 0)
					return "fuzzy, bunny leg";
				else if (select == 1)
					return "fur-covered leg";
				else if (select == 2)
					return "furry leg";
				else
					return "leg";
			}
			if (lowerBody.type == LowerBody.HARPY) {
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "bird-like leg";
				else if (select == 1)
					return "feathered leg";
				else
					return "leg";
			}
			if (lowerBody.type == LowerBody.FOX) {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "fox-like leg";
				else if (select == 1)
					return "leg";
				else if (select == 2)
					return "leg";
				else
					return "vulpine leg";
			}
			if (lowerBody.type == LowerBody.RACCOON) {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "raccoon-like leg";
				else
					return "leg";
			}
			return "leg";
		}

		public function feet():String
		{
			var select:Number = 0;
			if (lowerBody.type == LowerBody.HUMAN)
				return "feet";
			if (lowerBody.type == LowerBody.HOOFED)
				return "hooves";
			if (lowerBody.type == LowerBody.DOG)
				return "paws";
			if (lowerBody.type == LowerBody.NAGA)
				return "coils";
			if (lowerBody.type == LowerBody.DEMONIC_HIGH_HEELS)
				return "demonic high-heels";
			if (lowerBody.type == LowerBody.DEMONIC_CLAWS)
				return "demonic foot-claws";
			if (lowerBody.type == LowerBody.GOO)
				return "slimey cillia";
			if (lowerBody.type == LowerBody.PONY)
				return "flat pony-feet";
			if (lowerBody.type == LowerBody.BUNNY) {
				select = rand(5);
				if (select == 0)
					return "large bunny feet";
				else if (select == 1)
					return "rabbit feet";
				else if (select == 2)
					return "large feet";
				else
					return "feet";
			}
			if (lowerBody.type == LowerBody.HARPY) {
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "taloned feet";
				else
					return "feet";
			}
			if (lowerBody.type == LowerBody.KANGAROO)
				return "foot-paws";
			if (lowerBody.type == LowerBody.FOX) {
				select = rand(4);
				if (select == 0)
					return "paws";
				else if (select == 1)
					return "soft, padded paws";
				else if (select == 2)
					return "fox-like feet";
				else
					return "paws";
			}
			if (lowerBody.type == LowerBody.RACCOON) {
				select = Math.floor(Math.random() * (3));
				if (select == 0)
					return "raccoon-like feet";
				else if (select == 1)
					return "long-toed paws";
				else if (select == 2)
					return "feet";
				else
					return "paws";
			}
			return "feet";
		}

		public function foot():String
		{
			var select:Number = 0;
			if (lowerBody.type == LowerBody.HUMAN)
				return "foot";
			if (lowerBody.type == LowerBody.HOOFED)
				return "hoof";
			if (lowerBody.type == LowerBody.DOG)
				return "paw";
			if (lowerBody.type == LowerBody.NAGA)
				return "coiled tail";
			if (lowerBody.type == LowerBody.GOO)
				return "slimey undercarriage";
			if (lowerBody.type == LowerBody.PONY)
				return "flat pony-foot";
			if (lowerBody.type == LowerBody.BUNNY) {
				select = Math.random() * (5);
				if (select == 0)
					return "large bunny foot";
				else if (select == 1)
					return "rabbit foot";
				else if (select == 2)
					return "large foot";
				else
					return "foot";
			}
			if (lowerBody.type == LowerBody.HARPY) {
				select = Math.floor(Math.random() * (5));
				if (select == 0)
					return "taloned foot";
				else
					return "foot";
			}
			if (lowerBody.type == LowerBody.FOX) {
				select = Math.floor(Math.random() * (4));
				if (select == 0)
					return "paw";
				else if (select == 1)
					return "soft, padded paw";
				else if (select == 2)
					return "fox-like foot";
				else
					return "paw";
			}
			if (lowerBody.type == LowerBody.KANGAROO)
				return "foot-paw";
			if (lowerBody.type == LowerBody.RACCOON) {
				select = Math.floor(Math.random() * (3));
				if (select == 0)
					return "raccoon-like foot";
				else if (select == 1)
					return "long-toed paw";
				else if (select == 2)
					return "foot";
				else
					return "paw";
			}
			return "foot";
		}

		public function canOvipositSpider():Boolean
		{
			if (eggs() >= 10 && hasPerk(PerkLib.SpiderOvipositor) && isDrider() && tail.type == Tail.SPIDER_ABDOMEN)
				return true;
			return false;
		}

		public function canOvipositBee():Boolean
		{
			if (eggs() >= 10 && hasPerk(PerkLib.BeeOvipositor) && tail.type == Tail.BEE_ABDOMEN)
				return true;
			return false;
		}

		public function hasOvipositor():Boolean
		{
			return hasPerk(PerkLib.SpiderOvipositor) || hasPerk(PerkLib.BeeOvipositor);
		}

		public function canOviposit():Boolean
		{
			if (canOvipositSpider() || canOvipositBee())
				return true;
			return false;
		}

		public function eggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				return perkv1(PerkLib.SpiderOvipositor);
			else
				return perkv1(PerkLib.BeeOvipositor);
		}

		public function addEggs(arg:int = 0):int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor))
				return -1;
			else {
				if (hasPerk(PerkLib.SpiderOvipositor)) {
					addPerkValue(PerkLib.SpiderOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.SpiderOvipositor, 1, 50);
					return perkv1(PerkLib.SpiderOvipositor);
				}
				else {
					addPerkValue(PerkLib.BeeOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.BeeOvipositor, 1, 50);
					return perkv1(PerkLib.BeeOvipositor);
				}
			}
		}

		public function dumpEggs():void
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor))
				return;
			setEggs(0);
			//Sets fertile eggs = regular eggs (which are 0)
			fertilizeEggs();
		}

		public function setEggs(arg:int = 0):int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor))
				return -1;
			else {
				if (hasPerk(PerkLib.SpiderOvipositor)) {
					setPerkValue(PerkLib.SpiderOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.SpiderOvipositor, 1, 50);
					return perkv1(PerkLib.SpiderOvipositor);
				}
				else {
					setPerkValue(PerkLib.BeeOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.BeeOvipositor, 1, 50);
					return perkv1(PerkLib.BeeOvipositor);
				}
			}
		}

		public function fertilizedEggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				return perkv2(PerkLib.SpiderOvipositor);
			else
				return perkv2(PerkLib.BeeOvipositor);
		}

		public function fertilizeEggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				setPerkValue(PerkLib.SpiderOvipositor, 2, eggs());
			else
				setPerkValue(PerkLib.BeeOvipositor, 2, eggs());
			return fertilizedEggs();
		}

		public function breastCup(rowNum:Number):String
		{
			if (rowNum === -1) {
				rowNum = this.breastRows.length === 0 ? 0 : this.breastRows.length - 1;
			}
			
			return Appearance.breastCup(breastRows[rowNum].breastRating);
		}

		public function bRows():Number
		{
			return breastRows.length;
		}

		public function totalBreasts():Number
		{
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while (counter > 0) {
				counter--;
				total += breastRows[counter].breasts;
			}
			return total;
		}

		public function totalNipples():Number
		{
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while (counter > 0) {
				counter--;
				total += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			return total;
		}

		public function smallestTitSize():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating > breastRows[counter].breastRating)
					index = counter;
			}
			return breastRows[index].breastRating;
		}

		public function smallestTitRow():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating > breastRows[counter].breastRating)
					index = counter;
			}
			return index;
		}

		public function biggestTitRow():Number
		{
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating < breastRows[counter].breastRating)
					index = counter;
			}
			return index;
		}

		public function averageBreastSize():Number
		{
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += breastRows[counter].breastRating;
			}
			if (breastRows.length == 0)
				return 0;
			return (average / breastRows.length);
		}

		public function averageCockThickness():Number
		{
			var counter:Number = cocks.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += cocks[counter].cockThickness;
			}
			if (cocks.length == 0)
				return 0;
			return (average / cocks.length);
		}

		public function averageNippleLength():Number
		{
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += (breastRows[counter].breastRating / 10 + .2);
			}
			return (average / breastRows.length);
		}

		public function averageVaginalLooseness():Number
		{
			var counter:Number = vaginas.length;
			var average:Number = 0;
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 2;
			while (counter > 0) {
				counter--;
				average += vaginas[counter].vaginalLooseness;
			}
			return (average / vaginas.length);
		}

		public function averageVaginalWetness():Number
		{
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 2;
			var counter:Number = vaginas.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += vaginas[counter].vaginalWetness;
			}
			return (average / vaginas.length);
		}

		public function averageCockLength():Number
		{
			var counter:Number = cocks.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += cocks[counter].cockLength;
			}
			if (cocks.length == 0)
				return 0;
			return (average / cocks.length);
		}

		public function canTitFuck():Boolean
		{
			if (breastRows.length == 0) return false;
			
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts && breastRows[counter].breastRating > 3)
					index = counter;
			}
			if (breastRows[index].breasts >= 2 && breastRows[index].breastRating > 3)
				return true;
			return false;
		}

		public function mostBreastsPerRow():Number
		{
			if (breastRows.length == 0) return 2;
			
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts)
					index = counter;
			}
			return breastRows[index].breasts;
		}

		public function averageNipplesPerBreast():Number
		{
			var counter:Number = breastRows.length;
			var breasts:Number = 0;
			var nipples:Number = 0;
			while (counter > 0) {
				counter--;
				breasts += breastRows[counter].breasts;
				nipples += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			if (breasts == 0)
				return 0;
			return Math.floor(nipples / breasts);
		}

		public function allBreastsDescript():String
		{
			return Appearance.allBreastsDescript(this);
		}

		//Simplified these cock descriptors and brought them into the creature class
		public function sMultiCockDesc():String {
			return (cocks.length > 1 ? "one of your " : "your ") + cockMultiLDescriptionShort();
		}
		
		public function SMultiCockDesc():String {
			return (cocks.length > 1 ? "One of your " : "Your ") + cockMultiLDescriptionShort();
		}
		
		public function oMultiCockDesc():String {
			return (cocks.length > 1 ? "each of your " : "your ") + cockMultiLDescriptionShort();
		}
		
		public function OMultiCockDesc():String {
			return (cocks.length > 1 ? "Each of your " : "Your ") + cockMultiLDescriptionShort();
		}
		
		private function cockMultiLDescriptionShort():String {
			if (cocks.length < 1) {
				CoC_Settings.error("<b>ERROR: NO WANGS DETECTED for cockMultiLightDesc()</b>");
				return "<b>ERROR: NO WANGS DETECTED for cockMultiLightDesc()</b>";
			}
			if (cocks.length == 1) { //For a songle cock return the default description
				return Appearance.cockDescript(this, 0);
			}
			switch (cocks[0].cockType) { //With multiple cocks only use the descriptions for specific cock types if all cocks are of a single type
				case CockTypesEnum.ANEMONE:
				case CockTypesEnum.WOLF:
				case CockTypesEnum.CAT:
				case CockTypesEnum.DEMON:
				case CockTypesEnum.DISPLACER:
				case CockTypesEnum.DRAGON:
				case CockTypesEnum.HORSE:
				case CockTypesEnum.KANGAROO:
				case CockTypesEnum.LIZARD:
				case CockTypesEnum.PIG:
				case CockTypesEnum.TENTACLE:
				case CockTypesEnum.RED_PANDA:
				case CockTypesEnum.FERRET:
					if (countCocksOfType(cocks[0].cockType) == cocks.length) return Appearance.cockNoun(cocks[0].cockType) + "s";
					break;
				case CockTypesEnum.DOG:
				case CockTypesEnum.FOX:
					if (dogCocks() == cocks.length) return Appearance.cockNoun(CockTypesEnum.DOG) + "s";
					break;
				default:
			}
			return Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
		}
		
		public function hasSheath():Boolean {
			if (cocks.length == 0) return false;
			for (var x:int = 0; x < cocks.length; x++) {
				switch (cocks[x].cockType) {
					case CockTypesEnum.CAT:
					case CockTypesEnum.DISPLACER:
					case CockTypesEnum.DOG:
					case CockTypesEnum.WOLF:
					case CockTypesEnum.FOX:
					case CockTypesEnum.HORSE:
					case CockTypesEnum.KANGAROO:
					case CockTypesEnum.AVIAN:
					case CockTypesEnum.ECHIDNA:
					case CockTypesEnum.RED_PANDA:
					case CockTypesEnum.FERRET:
						return true; //If there's even one cock of any of these types then return true
					default:
				}
			}
			return false;
		}
		
		public function sheathDescript():String {
			if (hasSheath()) return "sheath";
			return "base";
		}
		
		public function cockClit(number:int = 0):String {
			if (hasCock() && number >= 0 && number < cockTotal())
				return cockDescript(number);
			else
				return clitDescript();
		}
		
		public function vaginaDescript(idx:int = 0):String
		{
			return Appearance.vaginaDescript(this, 0);
		}

		public function allVaginaDescript():String {
			if (vaginas.length == 1)
				return vaginaDescript(rand(vaginas.length - 1));
			else
				return vaginaDescript(rand(vaginas.length - 1)) + "s";
		}
		
		public function nippleDescript(rowIdx:int):String
		{
			if (rowIdx === -1) {
				rowIdx = this.breastRows.length - 1;
			}
			
			return Appearance.nippleDescription(this, rowIdx);
		}

		public function chestDesc():String
		{
			if (biggestTitSize() < 1) return "chest";
			return Appearance.biggestBreastSizeDescript(this);
//			return Appearance.chestDesc(this);
		}

		public function allChestDesc():String {
			if (biggestTitSize() < 1) return "chest";
			return allBreastsDescript();
		}
		
		public function biggestBreastSizeDescript():String {
			return Appearance.biggestBreastSizeDescript(this);
		}
		
		public function clitDescript():String {
			return Appearance.clitDescription(this);
		}

		public function cockHead(cockNum:int = 0):String {
			if (cockNum < 0 || cockNum > cocks.length - 1) {
				CoC_Settings.error("");
				return "ERROR";
			}
			switch (cocks[cockNum].cockType) {
				case CockTypesEnum.CAT:
					if (rand(2) == 0) return "point";
					return "narrow tip";
				case CockTypesEnum.DEMON:
					if (rand(2) == 0) return "tainted crown";
					return "nub-ringed tip";
				case CockTypesEnum.DISPLACER:
					switch (rand(5)) {
						case  0: return "star tip";
						case  1: return "blooming cock-head";
						case  2: return "open crown";
						case  3: return "alien tip";
						default: return "bizarre head";
					}
				case CockTypesEnum.DOG:
				case CockTypesEnum.WOLF:
				case CockTypesEnum.FOX:
					if (rand(2) == 0) return "pointed tip";
					return "narrow tip";
				case CockTypesEnum.HORSE:
					if (rand(2) == 0) return "flare";
					return "flat tip";
				case CockTypesEnum.KANGAROO:
					if (rand(2) == 0) return "tip";
					return "point";
				case CockTypesEnum.LIZARD:
					if (rand(2) == 0) return "crown";
					return "head";
				case CockTypesEnum.TENTACLE:
					if (rand(2) == 0) return "mushroom-like tip";
					return "wide plant-like crown";
				case CockTypesEnum.PIG:
					if (rand(2) == 0) return "corkscrew tip";
					return "corkscrew head";
				case CockTypesEnum.RHINO:
					if (rand(2) == 0) return "flared head";
					return "rhinoceros dickhead";
				case CockTypesEnum.ECHIDNA:
					if (rand(2) == 0) return "quad heads";
					return "echidna quad heads";
				default:
			}
			if (rand(2) == 0) return "crown";
			if (rand(2) == 0) return "head";
			return "cock-head";
		}

		//Short cock description. Describes length or girth. Supports multiple cocks.
		public function cockDescriptShort(i_cockIndex:int = 0):String
		{
			// catch calls where we're outside of combat, and eCockDescript could be called.
			if (cocks.length == 0)
				return "<B>ERROR. INVALID CREATURE SPECIFIED to cockDescriptShort</B>";

			var description:String = "";
			var descripted:Boolean = false;
			//Discuss length one in 3 times
			if (rand(3) == 0) {
				if (cocks[i_cockIndex].cockLength >= 30)
					description = "towering ";
				else if (cocks[i_cockIndex].cockLength >= 18)
					description = "enormous ";
				else if (cocks[i_cockIndex].cockLength >= 13)
					description = "massive ";
				else if (cocks[i_cockIndex].cockLength >= 10)
					description = "huge ";
				else if (cocks[i_cockIndex].cockLength >= 7)
					description = "long ";
				else if (cocks[i_cockIndex].cockLength >= 5)
					description = "average ";
				else
					description = "short ";
				descripted = true;
			}
			else if (rand(2) == 0) { //Discuss girth one in 2 times if not already talked about length.
				//narrow, thin, ample, broad, distended, voluminous
				if (cocks[i_cockIndex].cockThickness <= .75) description = "narrow ";
				if (cocks[i_cockIndex].cockThickness > 1 && cocks[i_cockIndex].cockThickness <= 1.4) description = "ample ";
				if (cocks[i_cockIndex].cockThickness > 1.4 && cocks[i_cockIndex].cockThickness <= 2) description = "broad ";
				if (cocks[i_cockIndex].cockThickness > 2 && cocks[i_cockIndex].cockThickness <= 3.5) description = "fat ";
				if (cocks[i_cockIndex].cockThickness > 3.5) description = "distended ";
				descripted = true;
			}
//Seems to work better without this comma:			if (descripted && cocks[i_cockIndex].cockType != CockTypesEnum.HUMAN) description += ", ";
			description += Appearance.cockNoun(cocks[i_cockIndex].cockType);

			return description;
		}

		public function handsDescript(plural:Boolean = true):String
		{
			return Appearance.handsDescript(this, plural);
		}

		public function assholeDescript():String
		{
			return Appearance.assholeDescript(this);
		}
		
		public function assholeOrPussy():String
		{
			return Appearance.assholeOrPussy(this);
		}

		public function multiCockDescriptLight():String
		{
			return Appearance.multiCockDescriptLight(this);
		}

		public function multiCockDescript():String
		{
			return Appearance.multiCockDescript(this);
		}

		public function ballDescript(forcedSize:Boolean = true):String
		{
			return Appearance.ballsDescription(forcedSize, false, this);
		}
		
		public function ballsDescript(forcedSize:Boolean = true):String
		{
			return ballsDescriptLight(forcedSize);
		}
		
		public function ballsDescriptLight(forcedSize:Boolean = true):String
		{
			return Appearance.ballsDescription(forcedSize, true, this);
		}
		
		public function simpleBallsDescript():String
		{
			return Appearance.ballsDescription(false, true, this);
		}
		
		public function sackDescript():String
		{
			return Appearance.sackDescript(this);
		}

		public function breastDescript(rowNum:int):String
		{
			if (rowNum === -1) {
				rowNum = breastRows.length - 1;
			}
			
			//ERROR PREVENTION
			if (breastRows.length - 1 < rowNum) {
				CoC_Settings.error("");
				return "<b>ERROR, breastDescript() working with invalid breastRow</b>";
			}
			
			if (breastRows.length === 0) {
				CoC_Settings.error("");
				return "<b>ERROR, breastDescript() called when no breasts are present.</b>";
			}
			
			return BreastStore.breastDescript(breastRows[rowNum].breastRating, breastRows[rowNum].lactationMultiplier);
		}

		public function hasLongTongue():Boolean
		{
			return BodyPartLists.LONG_TONGUES.indexOf(tongue.type) !== -1;
		}

		private function breastSize(val:Number):String
		{
			return Appearance.breastSize(val);
		}

		public function damageToughnessModifier(displayMode:Boolean = false):Number {
			//Return 0 if Grimdark
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) return 0;
			//Calculate
			var temp:Number = 0;
			if (tou < 25) temp = (tou * 0.4);
			else if (tou < 50) temp = 10 + ((tou-25) * 0.3);
			else if (tou < 75) temp = 17.5 + ((tou-50) * 0.2);
			else if (tou < 100) temp = 22.5 + ((tou-75) * 0.1);
			else temp = 25;
			//displayMode is for stats screen.
			if (displayMode) return temp;
			else return rand(temp);
		}
		
		public function damagePercent(displayMode:Boolean = false, applyModifiers:Boolean = false):Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			//Toughness modifier.
			if (!displayMode) {
				mult -= damageToughnessModifier();
				if (mult < 75) mult = 75;
			}
			//Modify armor rating based on weapons.
			if (applyModifiers) {
				if (game.player.weapon == game.weapons.JRAPIER || game.player.weapon == game.weapons.SPEAR_0 || game.player.weaponName.indexOf("staff") != -1 && game.player.hasPerk(PerkLib.StaffChanneling)) armorMod = 0;
				if (game.player.weapon == game.weapons.KATANA0) armorMod -= 5;
				if (game.player.hasPerk(PerkLib.LungingAttacks)) armorMod /= 2;
				if (armorMod < 0) armorMod = 0;
			}
			mult -= armorMod;
			
			//--PERKS--
			//Take damage you masochist!
			if (hasPerk(PerkLib.Masochist) && lib >= 60) {
				mult *= 0.8;
				if (short == game.player.short && !displayMode) dynStats("lus", 2);
			}
			if (hasPerk(PerkLib.ImmovableObject) && tou >= 75) {
				mult *= 0.9;
			}
			
			//--STATUS AFFECTS--
			//Black cat beer = 25% reduction!
			if (statusEffectv1(StatusEffects.BlackCatBeer) > 0)
				mult *= 0.75;
			// Uma's Massage bonuses
			var effect:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (effect != null && effect.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult *= effect.value2;
			}
			//Round things off.
			mult = Math.round(mult);
			//Caps damage reduction at 80%.
			if (mult < 20) mult = 20;
			return mult;
		}
		
		public function lustPercent():Number {
			var lust:Number = 100;
			var minLustCap:Number = 25;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0 && flags[kFLAGS.NEW_GAME_PLUS_LEVEL] < 3) minLustCap -= flags[kFLAGS.NEW_GAME_PLUS_LEVEL] * 5;
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3) minLustCap -= 15;
			//2.5% lust resistance per level - max 75.
			if (level < 100) {
				if (level <= 11) lust -= (level - 1) * 3;
				else if (level > 11 && level <= 21) lust -= (30 + (level - 11) * 2);
				else if (level > 21 && level <= 31) lust -= (50 + (level - 21) * 1);
				else if (level > 31) lust -= (60 + (level - 31) * 0.2);
			}
			else lust = 25;
			
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//ADDITIVE REDUCTIONS
			//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
			//TOTAL IS LIMITED TO 75%!
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Corrupted Libido reduces lust gain by 10%!
			if (hasPerk(PerkLib.CorruptedLibido)) lust -= 10;
			//Acclimation reduces by 15%
			if (hasPerk(PerkLib.Acclimation)) lust -= 15;
			//Purity blessing reduces lust gain
			if (hasPerk(PerkLib.PurityBlessing)) lust -= 5;
			//Resistance = 10%
			if (hasPerk(PerkLib.Resistance)) lust -= 10;
			if (hasPerk(PerkLib.ChiReflowLust)) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
			
			if (lust < minLustCap) lust = minLustCap;
			if (statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				if (lust >= 80) lust = 100;
				else lust += 20;
			}
			lust += Math.round(perkv1(PerkLib.PentUp)/2);
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//MULTIPLICATIVE REDUCTIONS
			//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
			//DRAWBACKS TO JUSTIFY IT.
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Bimbo body slows lust gains!
			if ((hasStatusEffect(StatusEffects.BimboChampagne) || hasPerk(PerkLib.BimboBody)) && lust > 0) lust *= .75;
			if (hasPerk(PerkLib.BroBody) && lust > 0) lust *= .75;
			if (hasPerk(PerkLib.FutaForm) && lust > 0) lust *= .75;
			//Omnibus' Gift reduces lust gain by 15%
			if (hasPerk(PerkLib.OmnibusGift)) lust *= .85;
			//Luststick reduces lust gain by 10% to match increased min lust
			if (hasPerk(PerkLib.LuststickAdapted)) lust *= 0.9;
			if (hasStatusEffect(StatusEffects.Berzerking)) lust *= .6;
			if (hasPerk(PerkLib.PureAndLoving)) lust *= 0.95;
			//Berserking removes half!
			if (hasStatusEffect(StatusEffects.Lustzerking)) lust += ((100 - lust) / 2);
			//Items
			if (jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (jewelryEffectMagnitude / 100);
			if (armorName == game.armors.DBARMOR.name) lust *= 0.9;
			if (weaponName == game.weapons.HNTCANE.name) lust *= 0.75;
			// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
			// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
			var effect:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (effect != null) {
				if (effect.value1 == UmasShop.MASSAGE_RELIEF || effect.value1 == UmasShop.MASSAGE_LUST) {
					lust *= effect.value2;
				}
			}
			
			lust = Math.round(lust);
			return lust;
		}
		
		/**
		* Look into perks and special effects and @return summery extra chance to avoid attack granted by them.
		* 
		* Is overriden in Player to work with Unhindered.
		*/
		public function getEvasionChance():Number
		{
			var chance:Number = 0;
			if (hasPerk(PerkLib.Evade)) chance += 10;
			if (hasPerk(PerkLib.Flexibility)) chance += 6;
			if (hasPerk(PerkLib.Misdirection) && armorName == "red, high-society bodysuit") chance += 10;
			return chance;
		}
	   
		public const EVASION_SPEED:String = "Speed"; // enum maybe?
		public const EVASION_EVADE:String = "Evade";
		public const EVASION_FLEXIBILITY:String = "Flexibility";
		public const EVASION_MISDIRECTION:String = "Misdirection";
		public const EVASION_UNHINDERED:String = "Unhindered";
		protected var evasionRoll:Number = 0;
	   
		/**
	    * Try to avoid and @return a reason if successfull or null if failed to evade.
		* 
		* If attacker is null then you can specify attack speed for enviromental and non-combat cases. If no speed and attacker specified and then only perks would be accounted.
		* 
		* This does NOT account blind!
		* 
		* Is overriden in Player to work with Unhindered.
	    */
		public function getEvasionReason(useMonster:Boolean = true, attackSpeed:int = int.MIN_VALUE):String
		{
			// speed
			if (useMonster && game.monster != null && attackSpeed == int.MIN_VALUE) attackSpeed = game.monster.spe;
			if (attackSpeed != int.MIN_VALUE && spe - attackSpeed > 0 && int(Math.random() * (((spe - attackSpeed) / 4) + 80)) > 80) return "Speed";
			//note, Player.speedDodge is still used, since this function can't return how close it was

			evasionRoll = rand(100);

			// perks
			if (hasPerk(PerkLib.Evade) && ((evasionRoll = evasionRoll - 10) < 0)) return "Evade";
			if (hasPerk(PerkLib.Flexibility) && ((evasionRoll = evasionRoll - 6) < 0)) return "Flexibility";
			if (hasPerk(PerkLib.Misdirection) && armorName == "red, high-society bodysuit" && ((evasionRoll = evasionRoll - 10) < 0)) return "Misdirection";
			return null;
		}
	   
		public function getEvasionRoll(useMonster:Boolean = true, attackSpeed:int = int.MIN_VALUE):Boolean
		{
			return getEvasionReason(useMonster, attackSpeed) != null;
		}
		
		public function getMaxStats(stats:String):int {
			return 100;
		}

		public function get HP():Number { return this._HP; }
		public function set HP(value:Number):void { this._HP = value; }
		
		public function get lust():Number { return this._lust; }
		public function set lust(value:Number):void { this._lust = value; }
		
		public function get fatigue():Number { return this._fatigue; }
		public function set fatigue(value:Number):void { this._fatigue = value; }
		
		//Minimum Libido, Sensitivty, Lust
		public function minLib():Number {
			return 1;
		}
		public function minSens():Number {
			return 10;
		}
		public function minLust():Number {
			return 0;
		}
		
		//Max HP, Lust, Fatigue
		public function maxHP():Number
		{
			var max:Number = 0;
			max += int(tou * 2 + 50);
			if (findPerk(PerkLib.Tank) >= 0) max += 50;
			if (findPerk(PerkLib.Tank2) >= 0) max += Math.round(tou);
			if (findPerk(PerkLib.Tank3) >= 0) max += level * 5;
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) max += UmasShop.NEEDLEWORK_DEFENSE_EXTRA_HP;
			if (flags[kFLAGS.GRIMDARK_MODE] >= 1)
				max += level * 5;
			else
				max += level * 15;
			if (jewelryEffectId == JewelryLib.MODIFIER_HP) max += jewelryEffectMagnitude;
			max *= 1 + (countCockSocks("green") * 0.02);
			max = Math.round(max);
			if (max < 50) max = 50;
			if (max > 9999) max = 9999;
			return max;
		}
		
		/**
		 * Restore the HP of the creature.
		 * @param amount the amount to heal. If omitted, heal to max HP. Value must not be negative.
		 */
		public function restoreHP(amount:Number = Number.MAX_VALUE): void {
			if (amount < 0) {
				throw new RangeError("Value must not be negative");
			}
			
			HP += amount;
			
			if (HP > maxHP()) {
				HP = maxHP();
			}
		}

		public function maxLust():Number
		{
			var max:Number = 100;
			if (this == game.player && game.player.demonScore() >= 4) max += 20;
			if (findPerk(PerkLib.ImprovedSelfControl) >= 0) max += 20;
			if (findPerk(PerkLib.ImprovedSelfControl2) >= 0) max += 10;
			if (findPerk(PerkLib.ImprovedSelfControl3) >= 0) max += 10;
			if (findPerk(PerkLib.BroBody) >= 0 || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.FutaForm) >= 0) max += 20;
			if (findPerk(PerkLib.OmnibusGift) >= 0) max += 15;
			if (findPerk(PerkLib.AscensionDesires) >= 0) max += perkv1(PerkLib.AscensionDesires) * 5;
			if (max > 999) max = 999;
			return max;
		}
		public function maxFatigue():Number
		{
			var max:Number = 100;
			if (findPerk(PerkLib.ImprovedEndurance) >= 0) max += 20;
			if (findPerk(PerkLib.ImprovedEndurance2) >= 0) max += 10;
			if (findPerk(PerkLib.ImprovedEndurance3) >= 0) max += 10;
			if (findPerk(PerkLib.AscensionEndurance) >= 0) max += perkv1(PerkLib.AscensionEndurance) * 5;
			if (max > 999) max = 999;
			return max;
		}
		
		public function takeDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeLustDamage(lustDmg:Number, display:Boolean = true, applyRes:Boolean = true):Number{
			if (applyRes) lustDmg *= lustPercent()/100;
			lust = boundFloat(minLust(),lust+Math.round(lustDmg),maxLust());
			return (lustDmg > 0 && lustDmg < 1) ? 1 : lustDmg;
		}
		
		public function generateTooltip():String {
			var retv:String = "<b>Corruption:</b>" +  cor + "\n<b>Armor:</b>" + armorDef +"\n";
			if (hasStatusEffect(StatusEffects.IzmaBleed)) retv += "<b>Bleeding:</b> Target is bleeding and takes damage each turn.\n";
			if (hasStatusEffect(StatusEffects.Stunned)) retv += "<b>Stunned</b> Target is stunned, and may not act for " + (statusEffectv1(StatusEffects.Stunned)+1) + " turns.\n";
			//if (hasPerk(PerkLib.Invincible)) retv += "<b>INVINCIBLE:</b> Target is invincible, and will take no damage from any attack.\n";
			//if (hasPerk(PerkLib.BleedImmune)) retv += "<b>Bleed Immune:</b> Target is immune to bleeding effects.\n";
			if (hasStatusEffect(StatusEffects.Blind))  retv += "<b>Blinded:</b> Target is blinded and will miss much more often.\n";
			if (hasStatusEffect(StatusEffects.Fear))  retv += "<b>Frightened </b> Target is frozen by fear, and cannot attack.\n";
			if (hasStatusEffect(StatusEffects.NagaVenom))  retv += "<b>Poisoned(Naga):</b> Target is continuously losing speed and strength.\n";
			if (hasStatusEffect(StatusEffects.Whispered))  retv += "<b>Whispered:</b> Target is addled by dark whisperings, and cannot attack.\n";
			if (hasStatusEffect(StatusEffects.OnFire))  retv += "<b>Burning:</b> Target is burning, and takes damage every turn for " + statusEffectv1(StatusEffects.OnFire) +" turns.\n";
			if (hasStatusEffect(StatusEffects.Shell))  retv += "<b>Shell:</b> Target is protected by a magical shell for " + statusEffectv1(StatusEffects.Shell) +" turns, and will absorb some magical attacks.\n";
			//if (hasStatusEffect(StatusEffects.GuardAB))  retv += "<b>Guarded:</b> Target is guarded, and cannot be attacked directly.\n";
			//if(hasPerk(PerkLib.PoisonImmune)) retv += "<b>Poison Immune:</b> Target is immune to poison effects.\n";
			return retv;
		}
		
		/**
		 *Get the remaining fatigue of the Creature.
		 *@return maximum amount of fatigue that still can be used
		 */
		public function fatigueLeft():Number
		{
			return maxFatigue() - fatigue;
		}

		public function spellMod():Number {
			var mod:Number = 1;
			if (hasPerk(PerkLib.Archmage) && inte >= 75) mod += .5;
			if (hasPerk(PerkLib.Channeling) && inte >= 60) mod += .5;
			if (hasPerk(PerkLib.Mage) && inte >= 50) mod += .5;
			if (hasPerk(PerkLib.Spellpower) && inte >= 50) mod += .5;
			if (hasPerk(PerkLib.WizardsFocus)) {
				mod += perkv1(PerkLib.WizardsFocus);
			}
			if (hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
			if (jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (jewelryEffectMagnitude / 100);
			if (countCockSocks("blue") > 0) mod += (countCockSocks("blue") * .05);
			if (hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (perkv1(PerkLib.AscensionMysticality) * 0.05);
			return mod;
		}
		// returns OLD OP VAL
		public static function applyOperator(old:Number, op:String, val:Number):Number {
			switch(op) {
				case "=":
					return val;
				case "+":
					return old + val;
				case "-":
					return old - val;
				case "*":
					return old * val;
				case "/":
					return old / val;
				default:
					//trace("applyOperator(" + old + ",'" + op + "'," + val + ") unknown op");
					return old;
			}
		}
		/**
		 * Generate increments for stats
		 *
		 * @return Object of (newStat-oldStat) with keys str, tou, spe, inte, lib, sens, lust, cor
		 * and flags: scale, max
		 * */
		public static function parseDynStatsArgs(c:Creature, args:Array):Object {
			// Check num of args, we should have a multiple of 2
			if ((args.length % 2) != 0)
			{
				//trace("dynStats aborted. Keys->Arguments could not be matched");
				return {str:0,tou:0,spe:0,inte:0,wis:0,lib:0,sens:0,lust:0,cor:0,scale:true,max:true};
			}
			var argDefs:Object = { //[value, operator]
				str: [ 0, "+"],
				tou: [ 0, "+"],
				spe: [ 0, "+"],
				int: [ 0, "+"],
				lib: [ 0, "+"],
				sen: [ 0, "+"],
				lus: [ 0, "+"],
				cor: [ 0, "+"],
				scale: [ true, "="],
				max: [ true, "="]
			};
			var aliases:Object = {
				"strength":"str",
				"toughness": "tou",
				"speed": "spe",
				"intellect": "int",
				"inte": "int",
				"libido": "lib",
				"sensitivity": "sen",
				"sens": "sen",
				"lust": "lus",
				"corruption": "cor",
				"sca": "scale",
				"res": "scale",
				"resisted": "scale"
			};
			
			for (var i:int = 0; i < args.length; i += 2)
			{
				if (typeof(args[i]) == "string")
				{
					// Make sure the next arg has the POSSIBILITY of being correct
					if ((typeof(args[i + 1]) != "number") && (typeof(args[i + 1]) != "boolean"))
					{
						//trace("dynStats aborted. Next argument after argName is invalid! arg is type " + typeof(args[i + 1]));
						continue;
					}
					var argOp:String = "";
					// Figure out which array to search
					var argsi:String = (args[i] as String);
					if ("+-*/=".indexOf(argsi.charAt(argsi.length - 1)) != -1) {
						argOp = argsi.charAt(argsi.length - 1);
						argsi = argsi.slice(0, argsi.length - 1);
					}
					if (argsi in aliases) argsi = aliases[argsi];
					
					if (argsi in argDefs) {
						argDefs[argsi][0] = args[i + 1];
						if (argOp) argDefs[argsi][1] = argOp;
					} 
				}
			}
			// Got this far, we have values to statsify
			var newStr:Number = applyOperator(c.str, argDefs.str[1], argDefs.str[0]);
			var newTou:Number = applyOperator(c.tou, argDefs.tou[1], argDefs.tou[0]);
			var newSpe:Number = applyOperator(c.spe, argDefs.spe[1], argDefs.spe[0]);
			var newInte:Number = applyOperator(c.inte, argDefs.int[1], argDefs.int[0]);
			var newLib:Number = applyOperator(c.lib, argDefs.lib[1], argDefs.lib[0]);
			var newSens:Number = applyOperator(c.sens, argDefs.sen[1], argDefs.sen[0]);
			var newLust:Number = applyOperator(c.lust, argDefs.lus[1], argDefs.lus[0]);
			var newCor:Number = applyOperator(c.cor, argDefs.cor[1], argDefs.cor[0]);
			// Because lots of checks and mods are made in the stats(), calculate deltas and pass them. However, this means that the '=' operator could be resisted
			// In future (as I believe) stats() should be replaced with dynStats(), and checks and mods should be made here
			return {
				str     : newStr - c.str,
				tou     : newTou - c.tou,
				spe     : newSpe - c.spe,
				inte    : newInte - c.inte,
				lib     : newLib - c.lib,
				sens    : newSens - c.sens,
				lust    : newLust - c.lust,
				cor     : newCor - c.cor,
				scale   : argDefs.scale[0],
				max     : argDefs.max[0]
			};
		}
	}
}
