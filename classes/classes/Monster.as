package classes
{
	import classes.BodyParts.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.ArmorLib;
	import classes.Items.ConsumableLib;
	import classes.Items.JewelryLib;
	import classes.Items.UseableLib;
	import classes.Items.WeaponLib;
	import classes.Items.ShieldLib;
	import classes.Items.UndergarmentLib;
	import classes.Scenes.Dungeons.Factory.SecretarialSuccubus;
	import classes.Scenes.NPCs.Kiha;
	import classes.Scenes.Quests.UrtaQuest.MilkySuccubus;
	import classes.StatusEffects.Combat.BasiliskSlowDebuff;
	import classes.internals.ChainedDrop;
	import classes.internals.RandomDrop;
	import classes.internals.Utils;
	import classes.internals.WeightedDrop;

	import flash.utils.getQualifiedClassName;

	/**
	 * ...
	 * @author Yoffy, Fake-Name, aimozg
	 */
	public class Monster extends Creature
	{

		protected final function get player():Player
		{
			return game.player;
		}
		protected final function outputText(text:String):void{
			game.outputText(text);
		}
		protected final function combatRoundOver():void{
			game.combat.combatRoundOver();
		}
		/*protected final function combat.cleanupAfterCombat():void
		{
			game.combat.cleanupAfterCombat();
		}*/
		protected static function showStatDown(a:String):void{
			kGAMECLASS.mainView.statsView.showStatDown(a);
		}
		protected final function statScreenRefresh():void {
			kGAMECLASS.output.statScreenRefresh();
		}
		protected final function doNext(eventNo:Function):void { //Now typesafe
			kGAMECLASS.output.doNext(eventNo);
		}
		protected final function combatMiss():Boolean {
			return game.combat.combatMiss();
		}
		protected final function combatParry():Boolean {
			return game.combat.combatParry();
		}
		protected final function combatBlock(doFatigue:Boolean = false):Boolean {
			return game.combat.combatBlock(doFatigue);
		}
		protected function get consumables():ConsumableLib{
			return game.consumables;
		}
		protected function get useables():UseableLib{
			return game.useables;
		}
		protected function get weapons():WeaponLib{
			return game.weapons;
		}
		protected function get shields():ShieldLib{
			return game.shields;
		}
		protected function get armors():ArmorLib{
			return game.armors;
		}
		protected function get jewelries():JewelryLib{
			return game.jewelries;
		}
		protected function get undergarments():UndergarmentLib{
			return game.undergarments;
		}

		protected function get images():ImageManager
		{
			return kGAMECLASS.images;
		}

		protected function set images(val:ImageManager):void
		{
			kGAMECLASS.images = val;
		}
		//For enemies
		public var bonusHP:Number = 0;
		public var bonusLust:Number = 0;
		private var _long:String = "<b>You have encountered an uninitialized  Please report this as a bug</b>.";
		public function get long():String
		{
			return _long;
		}
		public function set long(value:String):void
		{
			initsCalled.long = true;
			_long = value;
		}


		//Is a creature a 'plural' encounter - mob, etc.
		public var plural:Boolean = false;
		public var imageName:String = "";

		//Lust vulnerability
		public var lustVuln:Number = 1;

		public static const TEMPERMENT_AVOID_GRAPPLES:int = 0;
		public static const TEMPERMENT_LUSTY_GRAPPLES:int = 1;
		public static const TEMPERMENT_RANDOM_GRAPPLES:int = 2;
		public static const TEMPERMENT_LOVE_GRAPPLES:int = 3;
		/**
		 * temperment - used for determining grapple behaviors
		 * 0 - avoid grapples/break grapple
		 * 1 - lust determines > 50 grapple
		 * 2 - random
		 * 3 - love grapples
		*/
		public var temperment:Number = TEMPERMENT_AVOID_GRAPPLES;

		//Used for special attacks.
		public var special1:Function = null;
		public var special2:Function = null;
		public var special3:Function = null;

		//he
		public var pronoun1:String = "";
		public function get Pronoun1():String{
			if (pronoun1=="") return "";
			return pronoun1.substr(0,1).toUpperCase()+pronoun1.substr(1);
		}
		//him
		public var pronoun2:String = "";
		public function get Pronoun2():String{
			if (pronoun2=="") return "";
			return pronoun2.substr(0,1).toUpperCase()+pronoun2.substr(1);
		}
		//3: Possessive his
		public var pronoun3:String = "";
		public function get Pronoun3():String{
			if (pronoun3=="") return "";
			return pronoun3.substr(0,1).toUpperCase()+pronoun3.substr(1);
		}

		private var _drop:RandomDrop = new ChainedDrop();
		public function get drop():RandomDrop { return _drop; }
		public function set drop(value:RandomDrop):void
		{
			_drop = value;
			initedDrop = true;
		}
		public override function maxHP():Number
		{
			//Base HP
			var temp:Number = 50 + this.bonusHP;
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) {
				temp = (15 * level) + this.bonusHP;
			}
			temp += (this.tou * 2);
			//Apply perks
			if (findPerk(PerkLib.Tank) >= 0) temp += 50;
			if (findPerk(PerkLib.Tank2) >= 0) temp += this.tou;
			//Apply NG+, NG++, NG+++, etc.
			if (short === "doppleganger" || short === "pod" || short === "sand trap" || short === "sand tarp") {
				temp += 200 * player.newGamePlusMod();
			}
			else if (short === "Lethice") {
				temp += 1200 * player.newGamePlusMod();
			}
			else if (short === "Marae") {
				temp += 2500 * player.newGamePlusMod();
			}
			else {
				temp += 1000 * player.newGamePlusMod();
			}
			//Apply difficulty
			if (flags[kFLAGS.GAME_DIFFICULTY] <= 0) temp *= 1.0;
			else if (flags[kFLAGS.GAME_DIFFICULTY] === 1) temp *= 1.25;
			else if (flags[kFLAGS.GAME_DIFFICULTY] === 2) temp *= 1.5;
			else temp *= 2.0;
			temp = Math.round(temp);
			return temp;
		}

		override public function maxLust():Number {
			//Base Lust
			var temp:Number = 100 + this.bonusLust;
			if (findPerk(PerkLib.ImprovedSelfControl) >= 0) temp += 20;
			return temp;
		}
		public function addHP(hp:Number):void {
			this.HP += hp;
			if (this.HP<0) this.HP = 0;
			else if (this.HP > maxHP()) this.HP = maxHP();
		}

		/**
		 * @return damage not reduced by player stats
		 */
		public function eBaseDamage():Number {
			return str + weaponAttack;
		}

		/**
		 * @return randomized damage reduced by player stats
		 */
		public function calcDamage():int{
			return player.reduceDamage(eBaseDamage());
		}

		public function totalXP(playerLevel:Number=-1):Number
		{
			var multiplier:Number = 1;
			multiplier += game.player.perkv1(PerkLib.AscensionWisdom) * 0.1;
			if (playerLevel === -1) playerLevel = game.player.level;
			//
			// 1) Nerf xp gains by 20% per level after first two level difference
			// 2) No bonuses for underlevel!
			// 3) Super high level folks (over 10 levels) only get 1 xp!
			var difference:Number = playerLevel - this.level;
			if (difference <= 2) difference = 0;
			else difference -= 2;
			if (difference > 4) difference = 4;
			difference = (5 - difference) * 20.0 / 100.0;
			if (playerLevel - this.level > 10) return 1;
			return Math.round(this.additionalXP + (this.baseXP() + this.bonusXP()) * difference * multiplier);
		}
		protected function baseXP():Number
		{
			return[200, 10, 20, 30, 40, 50, 55, 60, 66, 75,//0-9
				83, 85, 92, 100, 107, 115, 118, 121, 128, 135,//10-19
				145][Math.round(level)] || 200;
		}
		protected function bonusXP():Number
		{
			return rand([200,10,20,30,40,50,55,58,66,75,
					83,85,85,86,92,94,96,98,99,101,
					107][Math.round(this.level)] || 130);
		}

		public function Monster()
		{
			// trace("Generic Monster Constructor!");

			//// INSTRUCTIONS
			//// Copy-paste remaining code to the new monster constructor
			//// Uncomment and replace placeholder values with your own
			//// See existing monsters for examples

			// super(mainClassPtr);

			//// INIITIALIZERS
			//// If you want to skip something that is REQUIRED, you shoud set corresponding
			//// this.initedXXX property to true, e.g. this.initedGenitals = true;

			//// 1. Names and plural/singular
			///*REQUIRED*/ this.a = "a";
			///*REQUIRED*/ this.short = "short";
			///*OPTIONAL*/ // this.imageName = "imageName"; // default ""
			///*REQUIRED*/ this.long = "long";
			///*OPTIONAL*/ //this.plural = true|false; // default false

			//// 2. Gender, genitals, and pronouns (also see "note for 2." below)
			//// 2.1. Male
			///*REQUIRED*/ this.createCock(length,thickness,type); // defaults 5.5,1,human; could be called multiple times
			///*OPTIONAL*/ //this.balls = numberOfBalls; // default 0
			///*OPTIONAL*/ //this.ballSize = ; // default 0. should be set if balls>0
			///*OPTIONAL*/ //this.cumMultiplier = ; // default 1
			///*OPTIONAL*/ //this.hoursSinceCum = ; // default 0
			//// 2.2. Female
			///*REQUIRED*/ this.createVagina(virgin=true|false,VaginaClass.WETNESS_,VaginaClass.LOOSENESS_); // default true,normal,tight
			///*OPTIONAL*/ //this.createStatusEffect(StatusEffects.BonusVCapacity, bonus, 0, 0, 0);
			//// 2.3. Hermaphrodite
			//// Just create cocks and vaginas. Last call determines pronouns.
			//// 2.4. Genderless
			///*REQUIRED*/ initGenderless(); // this functions removes genitals!

			//// Note for 2.: during initialization pronouns are set in:
			//// * createCock: he/him/his
			//// * createVagina: she/her/her
			//// * initGenderless: it/it/its
			//// If plural=true, they are replaced with: they/them/their
			//// If you want to customize pronouns:
			///*OPTIONAL*/ //this.pronoun1 = "he";
			///*OPTIONAL*/ //this.pronoun2 = "him";
			///*OPTIONAL*/ //this.pronoun3 = "his";
			//// Another note for 2.: gender is automatically calculated in createCock,
			//// createVagina, initGenderless. If you want to change it, set this.gender
			//// after these method calls.

			//// 3. Breasts
			///*REQUIRED*/ this.createBreastRow(size,nipplesPerBreast); // default 0,1
			//// Repeat for multiple breast rows
			//// You can call just `this.createBreastRow();` for flat breasts
			//// Note useful method: this.createBreastRow(Appearance.breastCupInverse("C")); // "C" -> 3

			//// 4. Ass
			///*OPTIONAL*/ //this.ass.analLooseness = AssClass.LOOSENESS_; // default TIGHT
			///*OPTIONAL*/ //this.ass.analWetness = AssClass.WETNESS_; // default DRY
			///*OPTIONAL*/ //this.createStatusEffect(StatusEffects.BonusACapacity, bonus, 0, 0, 0);
			//// 5. Body
			///*REQUIRED*/ this.tallness = ;
			///*OPTIONAL*/ //this.hips.rating = Hips.RATING_; // default boyish
			///*OPTIONAL*/ //this.butt.rating = Butt.RATING_; // default buttless
			///*OPTIONAL*/ //this.lowerBodyPart.type = LOWER_BODY_; //default human
			///*OPTIONAL*/ //this.arms.type = Arms.; // default human

			//// 6. Skin
			///*OPTIONAL*/ //this.skin.tone = "skinTone"; // default "albino"
			///*OPTIONAL*/ //this.skin.type = Skin.; // default PLAIN
			///*OPTIONAL*/ //this.skin.desc = "skinDesc"; // default "skin" if this.skin.type is not set, else Appearance.DEFAULT_SKIN_DESCS[skinType]
			///*OPTIONAL*/ //this.skin.adj = "skinAdj"; // default ""

			//// 7. Hair
			///*OPTIONAL*/ //this.hair.color = ; // default "no"
			///*OPTIONAL*/ //this.hair.length = ; // default 0
			///*OPTIONAL*/ //this.hair.type = Hair.; // default NORMAL

			//// 8. Face
			///*OPTIONAL*/ //this.face.type = Face.; // default HUMAN
			///*OPTIONAL*/ //this.ears.type = Ears.; // default HUMAN
			///*OPTIONAL*/ //this.tongue.type = Tongue.; // default HUMAN
			///*OPTIONAL*/ //this.eyes.type = Eyes.; // default HUMAN

			//// 9. Primary stats.
			///*REQUIRED*/ initStrTouSpeInte(,,,);
			///*REQUIRED*/ initLibSensCor(,,);

			//// 10. Weapon
			///*REQUIRED*/ this.weaponName = "weaponName";
			///*REQUIRED*/ this.weaponVerb = "weaponVerb";
			///*OPTIONAL*/ //this.weaponAttack = ; // default 0
			///*OPTIONAL*/ //this.weaponPerk = "weaponPerk"; // default ""
			///*OPTIONAL*/ //this.weaponValue = ; // default 0

			//// 11. Armor
			///*REQUIRED*/ this.armorName = "armorName";
			///*OPTIONAL*/ //this.armorDef = ; // default 0
			///*OPTIONAL*/ //this.armorPerk = "armorPerk"; // default ""
			///*OPTIONAL*/ //this.armorValue = ; // default 0

			//// 12. Combat
			///*OPTIONAL*/ //this.bonusHP = ; // default 0
			///*OPTIONAL*/ //this.lust = ; // default 0
			///*OPTIONAL*/ //this.lustVuln = ; // default 1
			///*OPTIONAL*/ //this.temperment = TEMPERMENT; // default AVOID_GRAPPLES
			///*OPTIONAL*/ //this.fatigue = ; // default 0

			//// 13. Level
			///*REQUIRED*/ this.level = ;
			///*REQUIRED*/ this.gems = ;
			///*OPTIONAL*/ //this.additionalXP = ; // default 0

			//// 14. Drop
			//// 14.1. No drop
			///*REQUIRED*/ this.drop = NO_DROP;
			//// 14.2. Fixed drop
			///*REQUIRED*/ this.drop = new WeightedDrop(dropItemType);
			//// 14.3. Random weighted drop
			///*REQUIRED*/ this.drop = new WeightedDrop()...
			//// Append with calls like:
			//// .add(itemType,itemWeight)
			//// .addMany(itemWeight,itemType1,itemType2,...)
			//// Example:
			//// this.drop = new WeightedDrop()
			//// 		.add(A,2)
			//// 		.add(B,10)
			//// 		.add(C,1)
			//// 	will drop B 10 times more often than C, and 5 times more often than A.
 			//// 	To be precise, \forall add(A_i,w_i): P(A_i)=w_i/\sum_j w_j
			//// 14.4. Random chained check drop
			///*REQUIRED*/ this.drop = new ChainedDrop(optional defaultDrop)...
			//// Append with calls like:
			//// .add(itemType,chance)
			//// .elseDrop(defaultDropItem)
			////
			//// Example 1:
			//// init14ChainedDrop(A)
			//// 		.add(B,0.01)
			//// 		.add(C,0.5)
			//// 	will FIRST check B vs 0.01 chance,
			//// 	if it fails, C vs 0.5 chance,
			//// 	else A
			////
			//// 	Example 2:
			//// 	init14ChainedDrop()
			//// 		.add(B,0.01)
			//// 		.add(C,0.5)
			//// 		.elseDrop(A)
			//// 	for same result

			//// 15. Special attacks. No need to set them if the monster has custom AI.
			//// Values are either combat event numbers (5000+) or function references
			///*OPTIONAL*/ //this.special1 = ; //default 0
			///*OPTIONAL*/ //this.special2 = ; //default 0
			///*OPTIONAL*/ //this.special3 = ; //default 0

			//// 16. Tail
			///*OPTIONAL*/ //this.tail.type = Tail.; // default NONE
			///*OPTIONAL*/ //this.tail.venom = ; // default 0
			///*OPTIONAL*/ //this.tail.recharge = ; // default 5

			//// 17. Horns
			///*OPTIONAL*/ //this.hornsPart.type = Horns.; // default NONE
			///*OPTIONAL*/ //this.hornsPart.value = numberOfHorns; // default 0

			//// 18. Wings
			///*OPTIONAL*/ //this.wings.type = Wings.; // default NONE
			///*OPTIONAL*/ //this.wingDesc = ; // default Appearance.DEFAULT_WING_DESCS[wingType]

			//// 19. Antennae
			///*OPTIONAL*/ //this.antennaePart.type = Antennae.; // default NONE

			//// REQUIRED !!!
			//// In debug mode will throw an error for uninitialized monster
			//checkMonster();
		}

		private var _checkCalled:Boolean = false;
		public function get checkCalled():Boolean { return _checkCalled; }
		public var checkError:String = "";
		public var initsCalled:Object = {
			a:false,
			short:false,
			long:false,
			genitals:false,
			breasts:false,
			tallness:false,
			str_tou_spe_inte:false,
			lib_sens_cor:false,
			drop:false
		};
		// MONSTER INITIALIZATION HELPER FUNCTIONS
		protected function set initedGenitals(value:Boolean):void{
			initsCalled.genitals = value;
		}
		protected function set initedBreasts(value:Boolean):void{
			initsCalled.breasts = value;
		}
		protected function set initedDrop(value:Boolean):void{
			initsCalled.drop = value;
		}
		protected function set initedStrTouSpeInte(value:Boolean):void{
			initsCalled.str_tou_spe_inte = value;
		}
		protected function set initedLibSensCor(value:Boolean):void{
			initsCalled.lib_sens_cor = value;
		}
		protected const NO_DROP:WeightedDrop = new WeightedDrop();

		public function isFullyInit():Boolean {
			for each (var phase:Object in initsCalled) {
				if (phase is Boolean && phase === false) return false;
			}
			return true;
		}
		public function missingInits():String{
			var result:String = "";
			for (var phase:String in initsCalled){
				if (initsCalled[phase] is Boolean && initsCalled[phase] === false){
					if (result === "") result = phase;
					else result+=", "+phase;
				}
			}
			return result;
		}

		override public function set a(value:String):void {
			initsCalled.a = true;
			super.a = value;
		}

		override public function set short(value:String):void {
			initsCalled.short = true;
			super.short = value;
		}

		override public function createCock(clength:Number = 5.5, cthickness:Number = 1, ctype:CockTypesEnum = null):Boolean
		{
			initedGenitals = true;
			if (!_checkCalled) {
				if (plural) {
					this.pronoun1 = "they";
					this.pronoun2 = "them";
					this.pronoun3 = "their";
				} else {
					this.pronoun1 = "he";
					this.pronoun2 = "him";
					this.pronoun3 = "his";
				}
			}
			var result:Boolean = super.createCock(clength, cthickness, ctype);
			return result;
		}

		override public function createVagina(virgin:Boolean = true, vaginalWetness:Number = 1, vaginalLooseness:Number = 0):Boolean
		{
			initedGenitals = true;
			if (!_checkCalled) {
				if (plural) {
					this.pronoun1 = "they";
					this.pronoun2 = "them";
					this.pronoun3 = "their";
				} else {
					this.pronoun1 = "she";
					this.pronoun2 = "her";
					this.pronoun3 = "her";
				}
			}
			var result:Boolean = super.createVagina(virgin, vaginalWetness, vaginalLooseness);
			return result;
		}

		protected function initGenderless():void
		{
			this.cocks = new Vector.<Cock>();
			this.vaginas = new Vector.<VaginaClass>();
			initedGenitals = true;
			if (plural) {
				this.pronoun1 = "they";
				this.pronoun2 = "them";
				this.pronoun3 = "their";
			} else {
				this.pronoun1 = "it";
				this.pronoun2 = "it";
				this.pronoun3 = "its";
			}
		}

		override public function createBreastRow(size:Number = 0, nipplesPerBreast:Number = 1):Boolean
		{
			initedBreasts = true;
			return super.createBreastRow(size, nipplesPerBreast);
		}

		override public function set tallness(value:Number):void
		{
			initsCalled.tallness = true;
			super.tallness = value;
		}

		protected function initStrTouSpeInte(str:Number, tou:Number, spe:Number, inte:Number):void
		{
			this.str = str;
			this.tou = tou;
			this.spe = spe;
			this.inte = inte;
			initedStrTouSpeInte = true;
		}

		protected function initLibSensCor(lib:Number, sens:Number, cor:Number):void
		{
			this.lib = lib;
			this.sens = sens;
			this.cor = cor;
			initedLibSensCor = true;
		}

		override public function validate():String
		{
			var error:String = "";
			// 1. Required fields must be set
			if (!isFullyInit()) {
				error += "Missing phases: "+missingInits()+". ";
			}
			this.HP = maxHP();
			this.XP = totalXP();
			error += super.validate();
			error += Utils.validateNonNegativeNumberFields(this, "Monster.validate",[
					"lustVuln", "temperment"
			]);
			return error;
		}

		public function checkMonster():Boolean
		{
			_checkCalled = true;
			checkError = validate();
			if (checkError.length>0) CoC_Settings.error("Monster not initialized:"+checkError);
			return checkError.length === 0;
		}

		/**
		 * try to hit, apply damage
		 * @return damage
		 */
		public function eOneAttack():int
		{
			//Determine damage - str modified by enemy toughness!
			var damage:int = calcDamage();
			if (damage > 0) damage = player.takeDamage(damage);
			return damage;
		}

		/**
		 * return true if we land a hit
		 */
		protected function attackSucceeded():Boolean
		{
			var attack:Boolean = true;
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind)) {
				attack &&= handleBlind();
			}
			attack &&= !playerDodged();
			
			return attack;
		}

		public function eAttack():void {
			var attacks:int = statusEffectv1(StatusEffects.Attacks);
			if (attacks === 0) attacks = 1;
			while (attacks>0){
				if (attackSucceeded()){
				    var damage:int = eOneAttack();
					outputAttack(damage);
					postAttack(damage);
					kGAMECLASS.output.statScreenRefresh();
					outputText("\n");
				}
				if (statusEffectv1(StatusEffects.Attacks) >= 0) {
					addStatusValue(StatusEffects.Attacks, 1, -1);
				}
				attacks--;
			}
			removeStatusEffect(StatusEffects.Attacks);
			combatRoundOver(); //The doNext here was not required
		}

		/**
		 * Called no matter of success of the attack
		 * @param damage damage received by player
		 */
		protected function postAttack(damage:int):void
		{
			if (damage > 0) {
				if (lustVuln > 0 && player.armorName === "barely-decent bondage straps") {
					if (!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 5 * lustVuln;
				}
			}
		}

		public function outputAttack(damage:int):void
		{
			if (damage <= 0) {
				//Due to toughness or amor...
				if (rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your " + (player.armor !== ArmorLib.NOTHING ? player.armor.name : player.armorName) + ".");
				else {
					if (plural) outputText("You deflect and block every " + weaponVerb + " " + a + short + " throw at you. ");
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you. ");
				}
			}
			else if (damage < 6) outputText("You are struck a glancing blow by " + a + short + "! ");
			else if (damage < 11) {
				outputText(capitalA + short + " wound");
				if (!plural) outputText("s");
				outputText(" you! ");
			}
			else if (damage < 21) {
				outputText(capitalA + short + " stagger");
				if (!plural) outputText("s");
				outputText(" you with the force of " + pronoun3 + " " + weaponVerb + "! ");
			}
			else if (damage > 20) {
				outputText(capitalA + short + " <b>mutilate");
				if (!plural) outputText("s");
				outputText("</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ");
			}
			if (damage > 0) {
				if (flags[kFLAGS.ENEMY_CRITICAL] > 0) outputText("<b>Critical hit! </b>");
				outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
		}

		/**
		 * @return true if continue with attack
		 */
		protected function handleBlind():Boolean
		{
			if (rand(3) < 2) {
				if (weaponVerb === "tongue-slap") outputText(capitalA + short + " completely misses you with a thrust from "+pronoun3+" tongue!\n");
				else outputText(capitalA + short + " completely misses you with a blind attack!\n");
				return false;
			}
			return true;
		}

		/**
		 * print something about how we miss the player
		 */
		protected function outputPlayerDodged(dodge:int):void
		{
			if (dodge==1) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n");
			else if (dodge==2) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n");
			else {
				outputText("You deftly avoid " + a + short);
				if (plural) outputText("'");
				else outputText("'s");
				outputText(" slow " + weaponVerb + ".\n");
			}
		}

		private function playerDodged():Boolean
		{
			//Determine if dodged!
			var dodge:int = player.speedDodge(this);
			if (dodge>0) {
				outputPlayerDodged(dodge);
				return true;
			}
			var evasionResult:String = player.getEvasionReason(false); // use separate function for speed dodge for expanded dodge description
			//Determine if evaded
			if (evasionResult === EVASION_EVADE) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'");
				if (!plural) outputText("s");
				outputText(" attack.\n");
				return true;
			}
			//("Misdirection"
			if (evasionResult === EVASION_MISDIRECTION) {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' attacks.\n");
				return true;
			}
			//Determine if cat'ed
			if (evasionResult === EVASION_FLEXIBILITY) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "");
				if (plural) outputText("' attacks.\n");
				else outputText("'s attack.\n");
				return true;
			}
			if (evasionResult !== null) { // Failsafe fur unhandled
				outputText("Using your superior combat skills you manage to avoid attack completely.\n");
				return true;
			}
			//Parry with weapon
			if (combatParry()) {
				outputText("You manage to block " + a + short + "");
				if (plural) outputText("' attacks ");
				else outputText("'s attack ");
				outputText("with your " + player.weaponName + ".\n");
				return true;
			}
			//Block with shield
			if (combatBlock(true)) {
				outputText("You block " + a + short + "'s " + weaponVerb + " with your " + player.shieldName + "! ");
				return true;
			}
			return false;
		}

		public function doAI():void
		{
			if (hasStatusEffect(StatusEffects.Stunned)) {
				if (!handleStun()) return;
			}
			if (hasStatusEffect(StatusEffects.Fear)) {
				if (!handleFear()) return;
			}
			//Exgartuan gets to do stuff!
			if (game.player.hasStatusEffect(StatusEffects.Exgartuan) && game.player.statusEffectv2(StatusEffects.Exgartuan) === 0 && rand(3) === 0) {
				if (game.exgartuan.exgartuanCombatUpdate()) game.outputText("\n\n");
			}
			if (hasStatusEffect(StatusEffects.Constricted)) {
				if (!handleConstricted()) return;
			}
			//If grappling... TODO implement grappling
//			if (game.gameState == 2) {
//				game.gameState = 1;
				//temperment - used for determining grapple behaviors
				//0 - avoid grapples/break grapple
				//1 - lust determines > 50 grapple
				//2 - random
				//3 - love grapples
				/*
				 //		if (temperment == 0) eGrappleRetreat();
				 if (temperment == 1) {
				 //			if (lust < 50) eGrappleRetreat();
				 mainClassPtr.doNext(3);
				 return;
				 }
				 mainClassPtr.outputText("Lust Placeholder!!");
				 mainClassPtr.doNext(3);
				 return;*/
//			}
			performCombatAction();
		}

		/**
		 * Called if monster is constricted. Should return true if constriction is ignored and need to proceed with ai
		 */
		protected function handleConstricted():Boolean
		{
			//Enemy struggles -
			game.outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.");
			if (statusEffectv1(StatusEffects.Constricted) <= 0) {
				game.outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.");
				removeStatusEffect(StatusEffects.Constricted);
			}
			addStatusValue(StatusEffects.Constricted, 1, -1);
			combatRoundOver();
			return false;
		}

		/**
		 * Called if monster is under fear. Should return true if fear ignored and need to proceed with ai
		 */
		protected function handleFear():Boolean
		{
			if (statusEffectv1(StatusEffects.Fear) === 0) {
				if (plural) {
					removeStatusEffect(StatusEffects.Fear);
					game.outputText("Your foes shake free of their fear and ready themselves for battle.");
				}
				else {
					removeStatusEffect(StatusEffects.Fear);
					game.outputText("Your foe shakes free of its fear and readies itself for battle.");
				}
			}
			else {
				addStatusValue(StatusEffects.Fear, 1, -1);
				if (plural) game.outputText(capitalA + short + " are too busy shivering with fear to fight.");
				else game.outputText(capitalA + short + " is too busy shivering with fear to fight.");
			}
			combatRoundOver();
			return false;
		}

		/**
		 * Called if monster is stunned. Should return true if stun is ignored and need to proceed with ai.
		 */
		protected function handleStun():Boolean
		{
			if (plural) game.outputText("Your foes are too dazed from your last hit to strike back!");
			else game.outputText("Your foe is too dazed from your last hit to strike back!");
			if (statusEffectv1(StatusEffects.Stunned) <= 0) removeStatusEffect(StatusEffects.Stunned);
			else addStatusValue(StatusEffects.Stunned, 1, -1);
			combatRoundOver();
			return false;
		}

		/**
		 * This method is called after all stun/fear/constricted checks.
		 * Default: Equal chance to do physical or special (if any) attack
		 */
		protected function performCombatAction():void
		{
			var actions:Array = [eAttack,special1,special2,special3].filter(
					function(special:Function, idx:int, array:Array):Boolean {
						return special !== null;
					}
			);
			var rando:int = int(Math.random() * (actions.length));
			var action:Function = actions[rando];
			action();
		}

		/**
		 * All branches of this method and all subsequent scenes should end either with
         * 'cleanupAfterCombat', 'awardPlayer' or 'finishCombat'. The latter also displays
		 * default message like "you defeat %s" or "%s falls and starts masturbating"
		 */
		public function defeated(hpVictory:Boolean):void
		{
			game.combat.finishCombat();
		}

		/**
		 * All branches of this method and all subsequent scenes should end with
         * 'cleanupAfterCombat'.
		 */
		public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (hpVictory){
				player.HP = 1;
				clearOutput();
				outputText("Your wounds are too great to bear, and you fall unconscious.");
			} else {
				clearOutput();
				outputText("Your desire reaches uncontrollable levels, and you end up openly masturbating.\n\nThe lust and pleasure cause you to black out for hours on end.");
				player.lust = 0;
			}
			game.inCombat = false;
			game.combat.clearStatuses();
			var temp:Number = rand(10) + 1;
			if (temp > player.gems) temp = player.gems;
			outputText("\n\nYou'll probably wake up in eight hours or so, missing " + temp + " gems.");
			player.gems -= temp;
			kGAMECLASS.output.doNext(game.camp.returnToCampUseEightHours);
		}

		/**
		 * Function(hpVictory) to call INSTEAD of default defeated(). Call it or finishCombat() manually
		 */
		public var onDefeated:Function = null;
		/**
		 * Function(hpVictory,pcCameWorms) to call INSTEAD of default won(). Call it or finishCombat() manually
		 */
		public var onWon:Function = null;
		/**
		 * Function() to call INSTEAD of common run attempt. Call runAway(false) to perform default run attempt
		 */
		public var onPcRunAttempt:Function = null;

		/**
		 * Final method to handle hooks before calling overriden method
		 */
		public final function defeated_(hpVictory:Boolean):void
		{
			if (onDefeated !== null) onDefeated(hpVictory);
			else defeated(hpVictory);
		}

		/**
		 * Final method to handle hooks before calling overriden method
		 */
		public final function won_(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (onWon !== null) onWon(hpVictory,pcCameWorms);
			else won(hpVictory,pcCameWorms);
		}

		/**
		 * Display tease reaction message. Then call applyTease() to increase lust.
		 * @param lustDelta value to be added to lust (already modified by lustVuln etc)
		 */
		public function teased(lustDelta:Number):void
		{
			outputDefaultTeaseReaction(lustDelta);
			if (lustDelta > 0) {
				//Imp mob uber interrupt!
			  	if (hasStatusEffect(StatusEffects.ImpUber)) { // TODO move to proper class
					outputText("\nThe imps in the back stumble over their spell, their loincloths tenting obviously as your display interrupts their casting.  One of them spontaneously orgasms, having managed to have his spell backfire.  He falls over, weakly twitching as a growing puddle of whiteness surrounds his defeated form.");
					//(-5% of max enemy HP)
					HP -= bonusHP * .05;
					lust -= 15;
					removeStatusEffect(StatusEffects.ImpUber);
					createStatusEffect(StatusEffects.ImpSkip,0,0,0,0);
				}
			}
			applyTease(lustDelta);
		}

		protected function outputDefaultTeaseReaction(lustDelta:Number):void
		{
			if (plural) {
				if (lustDelta === 0) outputText("\n\n" + capitalA + short + " seem unimpressed.");
				if (lustDelta > 0 && lustDelta < 4) outputText("\n" + capitalA + short + " look intrigued by what " + pronoun1 + " see.");
				if (lustDelta >= 4 && lustDelta < 10) outputText("\n" + capitalA + short + " definitely seem to be enjoying the show.");
				if (lustDelta >= 10 && lustDelta < 15) outputText("\n" + capitalA + short + " openly stroke " + pronoun2 + "selves as " + pronoun1 + " watch you.");
				if (lustDelta >= 15 && lustDelta < 20) outputText("\n" + capitalA + short + " flush hotly with desire, " + pronoun3 + " eyes filled with longing.");
				if (lustDelta >= 20) outputText("\n" + capitalA + short + " lick " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " bodies.");
			}
			else {
				if (lustDelta === 0) outputText("\n" + capitalA + short + " seems unimpressed.");
				if (lustDelta > 0 && lustDelta < 4) {
					if (plural) outputText("\n" + capitalA + short + " looks intrigued by what " + pronoun1 + " see.");
					else outputText("\n" + capitalA + short + " looks intrigued by what " + pronoun1 + " sees.");
				}
				if (lustDelta >= 4 && lustDelta < 10) outputText("\n" + capitalA + short + " definitely seems to be enjoying the show.");
				if (lustDelta >= 10 && lustDelta < 15) {
					if (plural) outputText("\n" + capitalA + short + " openly strokes " + pronoun2 + "selves as " + pronoun1 + " watch you.");
					else outputText("\n" + capitalA + short + " openly strokes " + pronoun2 + "self as " + pronoun1 + " watches you.");
				}
				if (lustDelta >= 15 && lustDelta < 20) {
					if (plural) outputText("\n" + capitalA + short + " flush hotly with desire, " + pronoun3 + " eyes filling with longing.");
					else outputText("\n" + capitalA + short + " flushes hotly with desire, " + pronoun3 + " eyes filled with longing.");
				}
				if (lustDelta >= 20) {
					if (plural) outputText("\n" + capitalA + short + " licks " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " own bodies.");
					else outputText("\n" + capitalA + short + " licks " + pronoun3 + " lips in anticipation, " + pronoun3 + " hands idly stroking " + pronoun3 + " own body.");
				}
			}
		}

		protected function applyTease(lustDelta:Number):void{
			lust += lustDelta;
			lustDelta = Math.round(lustDelta * 10)/10;
			outputText(" <b>(<font color=\"#ff00ff\">" + lustDelta + "</font>)</b>");
		}

		public function generateDebugDescription():String{
			var result:String;
			var be:String =plural?"are":"is";
			var have:String = plural ? "have" : "has";
			var Heis:String = Pronoun1+" "+be+" ";
			var Hehas:String = Pronoun1 + " " + have + " ";
			result = "You are inspecting "+a+short+" (imageName='"+imageName+"', class='"+getQualifiedClassName(this)+"'). You are fighting "+pronoun2+".\n\n";
			result += Heis+(Appearance.DEFAULT_GENDER_NAMES[gender]||("gender#"+gender))+
					" with "+numberOfThings(cocks.length,"cock") +
					", "+numberOfThings(vaginas.length,"vagina")+
					" and "+numberOfThings(breastRows.length,"breast row")+".\n\n";
			// APPEARANCE
			result +=Heis+Appearance.inchesAndFeetsAndInches(tallness)+" tall with "+
					Appearance.describeByScale(hips.rating,Appearance.DEFAULT_HIP_RATING_SCALES,"thinner than","wider than")+" hips and "+
					Appearance.describeByScale(butt.rating,Appearance.DEFAULT_BUTT_RATING_SCALES,"thinner than","wider than")+" butt.\n";
			result +=Pronoun3+" lower body is "+(Appearance.DEFAULT_LOWER_BODY_NAMES[lowerBody.type]||("lowerBody#"+lowerBody.type));
			result += ", "+pronoun3+" arms are "+(Appearance.DEFAULT_ARM_NAMES[arms.type]||("armType#"+arms.type));
			result += ", "+pronoun1+" "+have+" "+skin.tone+" "+skin.adj+" "+skin.desc+" (type "+(Appearance.DEFAULT_SKIN_NAMES[skin.type]||("skinType#"+skin.type))+").\n";
			result += Hehas;
			if (hair.length>0){
				result += hair.color+" "+Appearance.inchesAndFeetsAndInches(hair.length)+" long "+(Appearance.DEFAULT_HAIR_NAMES[hair.type]||("hair.type#"+hair.type))+" hair.\n";
			} else {
				result += "no hair.\n";
			}
			result += Hehas;
			if (beard.length>0){
				result += hair.color+" "+Appearance.inchesAndFeetsAndInches(beard.length)+" long "+(Appearance.DEFAULT_BEARD_NAMES[beard.style]||("beardType#"+beard.style))+".\n";
			} else {
				result += "no beard.\n";
			}
			result += Hehas
					+(Appearance.DEFAULT_FACE_NAMES[face.type]||("face.type#"+face.type))+" face, "
					+(Appearance.DEFAULT_EARS_NAMES[ears.type]||("ears.type#"+ears.type))+" ears, "
					+(Appearance.DEFAULT_TONGUE_NAMES[tongue.type]||("tongueType#"+tongue.type))+" tongue and "
					+(Appearance.DEFAULT_EYES_NAMES[eyes.type]||("eyes.type#"+eyes.type))+" eyes.\n";
			result += Hehas;
			if (tail.type === Tail.NONE) result += "no tail, ";
			else result+=(Appearance.DEFAULT_TAIL_NAMES[tail.type]||("tailType#"+tail.type))+" tail with venom="+tail.venom+" and recharge="+tail.recharge+", ";
			if (horns.type === Horns.NONE) result += "no horns, ";
			else result += horns.value+" "+(Appearance.DEFAULT_HORNS_NAMES[horns.type]||("hornsPart.type#"+horns.type))+" horns, ";
			if (wings.type === Wings.NONE) result += "no wings, ";
			else result += Appearance.DEFAULT_WING_DESCS[wings.type]+" wings (type "+(Appearance.DEFAULT_WING_NAMES[wings.type]||("wingType#"+wings.type))+"), ";
			if (antennae.type === Antennae.NONE) result += "no antennae.\n\n";
			else result += (Appearance.DEFAULT_ANTENNAE_NAMES[antennae.type]||("antennaeType#"+antennae.type))+" antennae.\n\n";

			// GENITALS AND BREASTS
			for (var i:int = 0; i<cocks.length; i++){
				var cock:Cock = (cocks[i] as Cock);
				result += Pronoun3+(i>0?(" #"+(i+1)):"")+" "+cock.cockType.toString().toLowerCase()+" cock is ";
				result += Appearance.inchesAndFeetsAndInches(cock.cockLength)+" long and "+cock.cockThickness+"\" thick";
				if (cock.isPierced) result += ", pierced with " + cock.pLongDesc;
				if (cock.knotMultiplier !== 1) result += ", with knot of size " + cock.knotMultiplier;
				result+=".\n";
			}
			if (balls > 0 || ballSize > 0) result += Hehas + numberOfThings(balls, "ball") + " of size " + ballSize+".\n";
			if (cumMultiplier !== 1 || cocks.length > 0) result += Pronoun1 + " " + have+" cum multiplier " + cumMultiplier + ". ";
			if (hoursSinceCum > 0 || cocks.length > 0) result += "It were " + hoursSinceCum + " hours since " + pronoun1 + " came.\n\n";
			for (i = 0; i < vaginas.length; i++) {	
				var vagina:VaginaClass = (vaginas[i] as VaginaClass);
				result += Pronoun3+ (i>0?(" #"+(i+1)):"")+" "+(Appearance.DEFAULT_VAGINA_TYPE_NAMES[vagina.type]||("vaginaType#"+vagina.type))+(vagina.virgin?" ":" non-")+"virgin vagina is ";
				result += Appearance.describeByScale(vagina.vaginalLooseness,Appearance.DEFAULT_VAGINA_LOOSENESS_SCALES,"tighter than","looser than");
				result += ", "+Appearance.describeByScale(vagina.vaginalWetness,Appearance.DEFAULT_VAGINA_WETNESS_SCALES,"drier than","wetter than");
				if (vagina.labiaPierced) result += ". Labia are pierced with "+vagina.labiaPLong;
				if (vagina.clitPierced) result += ". Clit is pierced with "+vagina.clitPLong;
				if (statusEffectv1(StatusEffects.BonusVCapacity)>0){
					result+="; vaginal capacity is increased by "+statusEffectv1(StatusEffects.BonusVCapacity);
				}
				result+=".\n";
			}
			if (breastRows.length > 0) {	
				var nipple:String = nippleLength+"\" ";
				if (nipplesPierced) nipple+="pierced by "+nipplesPLong;
				for (i = 0; i < breastRows.length; i++) {
					var row:BreastRowClass = (breastRows[i] as BreastRowClass);
					result += Pronoun3+(i>0?(" #"+(i+1)):"") + " breast row has " + row.breasts;
					result += " " + row.breastRating.toFixed(2) + "-size (" + Appearance.breastCup(row.breastRating) + ") breasts with ";
					result += numberOfThings(row.nipplesPerBreast, nipple+(row.fuckable ? "fuckable nipple" : "unfuckable nipple")) + " on each.\n";
				}
			}
			result += Pronoun3+" ass is "+Appearance.describeByScale(ass.analLooseness,Appearance.DEFAULT_ANAL_LOOSENESS_SCALES,"tighter than","looser than")+", "+Appearance.describeByScale(ass.analWetness,Appearance.DEFAULT_ANAL_WETNESS_SCALES,"drier than","wetter than");
			if (statusEffectv1(StatusEffects.BonusACapacity)>0){
				result += "; anal capacity is increased by "+statusEffectv1(StatusEffects.BonusACapacity);
			}
			result +=".\n\n";

			// COMBAT AND OTHER STATS
			result += Hehas + "str=" + str + ", tou=" + tou + ", spe=" + spe+", inte=" + inte+", lib=" + lib + ", sens=" + sens + ", cor=" + cor + ".\n";
			result += Pronoun1 + " can " + weaponVerb + " you with  " + weaponPerk + " " + weaponName+" (attack " + weaponAttack + ", value " + weaponValue+").\n";
			result += Pronoun1 + " is guarded with " + armorPerk + " " + armorName+" (defense " + armorDef + ", value " + armorValue+").\n";
			result += Hehas + HP + "/" + maxHP() + " HP, " + lust + "/" + maxLust() + " lust, " + fatigue + "/100 fatigue. " + Pronoun3 + " bonus HP=" + bonusHP + ", and lust vulnerability=" + lustVuln + ".\n";
			result += Heis + "level " + level + " and " + have+" " + gems + " gems. You will be awarded " + XP + " XP.\n";
			
			var numSpec:int = (special1 !== null ? 1 : 0) + (special2 !== null ? 1 : 0) + (special3 !== null ? 1 : 0);
			if (numSpec > 0) {
				result += Hehas + numSpec + " special attack" + (numSpec > 1 ? "s" : "") + ".\n";
			}
			else {
				result += Hehas + "no special attacks.\n";
			}

			return result;
		}

		protected function clearOutput():void
		{
			game.clearOutput();
		}

		public function dropLoot():ItemType
		{
			return _drop.roll() as ItemType;
		}

		public function combatRoundUpdate():void
		{
			var store:Number = 0;
			if (hasStatusEffect(StatusEffects.MilkyUrta)) {
				game.urtaQuest.milkyUrtaTic();
			}
			//Countdown
			var tcd:StatusEffectClass = statusEffectByType(StatusEffects.TentacleCoolDown);
			if (tcd!=null) {
				tcd.value1-=1;
				if (tcd.value1 <= 0) {
					removeStatusEffect(StatusEffects.TentacleCoolDown);
				}
			}
			if (hasStatusEffect(StatusEffects.CoonWhip)) {
				if (statusEffectv2(StatusEffects.CoonWhip) <= 0) {
					armorDef += statusEffectv1(StatusEffects.CoonWhip);
					outputText("<b>Tail whip wears off!</b>\n\n");
					removeStatusEffect(StatusEffects.CoonWhip);
				}
				else {
					addStatusValue(StatusEffects.CoonWhip,2,-1);
					outputText("<b>Tail whip is currently reducing your foe");
					if (plural) outputText("s'");
					else outputText("'s");
					outputText(" armor by " + statusEffectv1(StatusEffects.CoonWhip) + ".</b>\n\n")
				}
			}
			if (hasStatusEffect(StatusEffects.Blind)) {
				addStatusValue(StatusEffects.Blind,1,-1);
				if (statusEffectv1(StatusEffects.Blind) <= 0) {
					outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " no longer blind!</b>\n\n");
					removeStatusEffect(StatusEffects.Blind);
				}
				else outputText("<b>" + capitalA + short + (plural ? " are" : " is") + " currently blind!</b>\n\n");
			}
			if (hasStatusEffect(StatusEffects.Earthshield)) {
				outputText("<b>" + capitalA + short + " is protected by a shield of rocks!</b>\n\n");
			}
			if (hasStatusEffect(StatusEffects.Sandstorm)) {
				//Blinded:
				if (player.hasStatusEffect(StatusEffects.Blind)) {
					outputText("<b>You blink the sand from your eyes, but you're sure that more will get you if you don't end it soon!</b>\n\n");
					player.removeStatusEffect(StatusEffects.Blind);
				}
				else {
					if (statusEffectv1(StatusEffects.Sandstorm) === 0 || statusEffectv1(StatusEffects.Sandstorm) % 4 === 0) {
						player.createStatusEffect(StatusEffects.Blind,0,0,0,0);
						outputText("<b>The sand is in your eyes!  You're blinded this turn!</b>\n\n");
					}
					else {
						outputText("<b>The grainy mess cuts at any exposed flesh and gets into every crack and crevice of your armor. ");
						var temp:Number = player.takeDamage(1 + rand(2), true);
						outputText("</b>\n\n");
					}
				}
				addStatusValue(StatusEffects.Sandstorm,1,1);
			}
			if (hasStatusEffect(StatusEffects.Stunned)) {
				outputText("<b>" + capitalA + short + " is still stunned!</b>\n\n");
			}
			if (hasStatusEffect(StatusEffects.Shell)) {
				if (statusEffectv1(StatusEffects.Shell) >= 0) {
					outputText("<b>A wall of many hues shimmers around " + a + short + ".</b>\n\n");
					addStatusValue(StatusEffects.Shell,1,-1);
				}
				else {
					outputText("<b>The magical barrier " + a + short + " erected fades away to nothing at last.</b>\n\n");
					removeStatusEffect(StatusEffects.Shell);
				}
			}
			if (hasStatusEffect(StatusEffects.IzmaBleed)) {
				//Countdown to heal
				addStatusValue(StatusEffects.IzmaBleed,1,-1);
				//Heal wounds
				if (statusEffectv1(StatusEffects.IzmaBleed) <= 0) {
					outputText("The wounds you left on " + a + short + " stop bleeding so profusely.\n\n");
					removeStatusEffect(StatusEffects.IzmaBleed);
				}
				//Deal damage if still wounded.
				else {
					store = maxHP() * (3 + rand(4)) / 100;
					store = game.combat.doDamage(store);
					if (plural) outputText(capitalA + short + " bleed profusely from the jagged wounds your weapon left behind. <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
					else outputText(capitalA + short + " bleeds profusely from the jagged wounds your weapon left behind. <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
				}
			}
			if (hasStatusEffect(StatusEffects.BasiliskCompulsion) && spe > 1) {
				var oldSpeed:Number = spe;
				var speedDiff:Number = 0;
				var bse:BasiliskSlowDebuff = createOrFindStatusEffect(StatusEffects.BasiliskSlow) as BasiliskSlowDebuff;
				bse.applyEffect(statusEffectv1(StatusEffects.BasiliskCompulsion));
				speedDiff = Math.round(oldSpeed - spe);
				if (plural) {
					outputText(capitalA + short + "  still feel the spell of those grey eyes, making " + pronoun3 + " movements slow and difficult,"
					          +" the remembered words tempting " + pronoun2 + " to look into your eyes again. "
					          + Pronoun1 + " need to finish this fight as fast as " + pronoun3 + "  heavy limbs will allow."
					          +" <b>(<font color=\"#800000\">" + Math.round(speedDiff) + "</font>)</b>\n\n");
				} else {
					outputText(capitalA + short + "  still feels the spell of those grey eyes, making " + pronoun3 + " movements slow and difficult,"
					          +" the remembered words tempting " + pronoun2 + " to look into your eyes again. "
					          + Pronoun1 + " needs to finish this fight as fast as " + pronoun3 + "  heavy limbs will allow."
					          +" <b>(<font color=\"#800000\">" + Math.round(speedDiff) + "</font>)</b>\n\n");

				}
			}
			if (hasStatusEffect(StatusEffects.OnFire)) {
				//Countdown to heal
				addStatusValue(StatusEffects.OnFire,1,-1);
				//Heal fire
				if (statusEffectv1(StatusEffects.OnFire) <= 0) {
					outputText("The flames engulfing " + a + short + " finally fades.\n\n");
					removeStatusEffect(StatusEffects.OnFire);
				}
				//Deal damage if still on fire.
				else {
					store = maxHP() * (4 + rand(5)) / 100;
					store = game.combat.doDamage(store);
					if (plural) outputText(capitalA + short + " continue to burn from the flames engulfing " + pronoun2 + ". <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
					else outputText(capitalA + short + " continues to burn from the flames engulfing " + pronoun2 + ". <b>(<font color=\"#800000\">" + store + "</font>)</b>\n\n");
				}
			}
			if (hasStatusEffect(StatusEffects.Timer)) {
				if (statusEffectv1(StatusEffects.Timer) <= 0)
					removeStatusEffect(StatusEffects.Timer);
				addStatusValue(StatusEffects.Timer,1,-1);
			}
			if (hasStatusEffect(StatusEffects.LustStick)) {
				//LoT Effect Messages:
				switch(statusEffectv1(StatusEffects.LustStick)) {
					//First:
					case 1:
						if (plural) outputText("One of " + a + short + " pants and crosses " + mf("his","her") + " eyes for a moment.  " + mf("His","Her") + " dick flexes and bulges, twitching as " + mf("he","she") + " loses himself in a lipstick-fueled fantasy.  When " + mf("he","she") + " recovers, you lick your lips and watch " + mf("his","her") + " blush spread.\n\n");
						else outputText(capitalA + short + " pants and crosses " + pronoun3 + " eyes for a moment.  " + mf("His","Her") + " dick flexes and bulges, twitching as " + pronoun1 + " loses " + mf("himself", "herself") + " in a lipstick-fueled fantasy.  When " + pronoun1 + " recovers, you lick your lips and watch " + mf("his","her") + " blush spread.\n\n");
						break;
					//Second:
					case 2:
						if (plural) outputText(capitalA + short + " moan out loud, " + pronoun3 + " dicks leaking and dribbling while " + pronoun1 + " struggle not to touch " + pronoun2 + ".\n\n");
						else outputText(capitalA + short + " moans out loud, " + pronoun3 + " dick leaking and dribbling while " + pronoun1 + " struggles not to touch it.\n\n");
						break;
					//Third:
					case 3:
						if (plural) outputText(capitalA + short + " pump " + pronoun3 + " hips futilely, air-humping non-existent partners.  Clearly your lipstick is getting to " + pronoun2 + ".\n\n");
						else outputText(capitalA + short + " pumps " + pronoun3 + " hips futilely, air-humping a non-existent partner.  Clearly your lipstick is getting to " + pronoun2 + ".\n\n");
						break;
					//Fourth:
					case 4:
						if (plural) outputText(capitalA + short + " close " + pronoun3 + " eyes and grunt, " + pronoun3 + " cocks twitching, bouncing, and leaking pre-cum.\n\n");
						else outputText(capitalA + short + " closes " + pronoun2 + " eyes and grunts, " + pronoun3 + " cock twitching, bouncing, and leaking pre-cum.\n\n");
						break;
					//Fifth and repeat:
					default:
						if (plural) outputText("Drops of pre-cum roll steadily out of their dicks.  It's a marvel " + pronoun1 + " haven't given in to " + pronoun3 + " lusts yet.\n\n");
						else outputText("Drops of pre-cum roll steadily out of " + a + short + "'s dick.  It's a marvel " + pronoun1 + " hasn't given in to " + pronoun3 + " lust yet.\n\n");
						break;
				}
				addStatusValue(StatusEffects.LustStick,1,1);
				//Damage = 5 + bonus score minus
				//Reduced by lust vuln of course
				lust += Math.round(lustVuln * (5 + statusEffectv2(StatusEffects.LustStick)));
			}
			if (hasStatusEffect(StatusEffects.PCTailTangle)) {
				//when Entwined
				outputText("You are bound tightly in the kitsune's tails.  <b>The only thing you can do is try to struggle free!</b>\n\n");
				outputText("Stimulated by the coils of fur, you find yourself growing more and more aroused...\n\n");
				game.dynStats("lus", 5+player.sens/10);
			}
			if (hasStatusEffect(StatusEffects.QueenBind)) {
				outputText("You're utterly restrained by the Harpy Queen's magical ropes!\n\n");
				if (flags[kFLAGS.PC_FETISH] >= 2) game.dynStats("lus", 3);
			}
			if (this is SecretarialSuccubus || this is MilkySuccubus) {
				if (player.lust100 < 45) outputText("There is something in the air around your opponent that makes you feel warm.\n\n");
				if (player.lust100 >= 45 && player.lust100 < 70) outputText("You aren't sure why but you have difficulty keeping your eyes off your opponent's lewd form.\n\n");
				if (player.lust100 >= 70 && player.lust100 < 90) outputText("You blush when you catch yourself staring at your foe's rack, watching it wobble with every step she takes.\n\n");
				if (player.lust100 >= 90) outputText("You have trouble keeping your greedy hands away from your groin.  It would be so easy to just lay down and masturbate to the sight of your curvy enemy.  The succubus looks at you with a sexy, knowing expression.\n\n");
				game.dynStats("lus", 1+rand(8));
			}
			//[LUST GAINED PER ROUND] - Omnibus
			if (hasStatusEffect(StatusEffects.LustAura)) {
				if (player.lust100 < 33) outputText("Your groin tingles warmly.  The demon's aura is starting to get to you.\n\n");
		 		if (player.lust100 >= 33 && player.lust100 < 66) outputText("You blush as the demon's aura seeps into you, arousing you more and more.\n\n");
		  		if (player.lust100 >= 66) {
					outputText("You flush bright red with desire as the lust in the air worms its way inside you.  ");
					temp = rand(4);
					if (temp === 0) outputText("You have a hard time not dropping to your knees to service her right now.\n\n");
					if (temp === 2) outputText("The urge to bury your face in her breasts and suckle her pink nipples nearly overwhelms you.\n\n");
					if (temp === 1) outputText("You swoon and lick your lips, tasting the scent of the demon's pussy in the air.\n\n");
					if (temp === 3) outputText("She winks at you and licks her lips, and you can't help but imagine her tongue sliding all over your body.  You regain composure moments before throwing yourself at her.  That was close.\n\n");
				}
				game.dynStats("lus", (3 + int(player.lib/20 + player.cor/30)));
			}
		}
		
		public function handleAwardItemText(itype:ItemType):void
		{ //New Function, override this function in child classes if you want a monster to output special item drop text
			if (itype !== null) outputText("\nThere is " + itype.longName + " on your defeated opponent.  ");
		}

		public function handleAwardText():void
		{ //New Function, override this function in child classes if you want a monster to output special gem and XP text
			//This function doesn’t add the gems or XP to the player, it just provides the output text
			if (this.gems === 1) outputText("\n\nYou snag a single gem and " + this.XP + " XP as you walk away from your victory.");
			else if (this.gems > 1) outputText("\n\nYou grab " + this.gems + " gems and " + this.XP + " XP from your victory.");
			else if (this.gems === 0) outputText("\n\nYou gain " + this.XP + " XP from the battle.");
		}
		
		public function handleCombatLossText(inDungeon:Boolean, gemsLost:int):int
		{ //New Function, override this function in child classes if you want a monster to output special text after the player loses in combat
			//This function doesn’t take the gems away from the player, it just provides the output text
			if (game.prison.inPrison) {
				game.prison.doPrisonEscapeFightLoss();
				return 8;
			}
			if (!inDungeon) {
				if (game.prison.trainingFeed.prisonCaptorFeedingQuestTrainingExists()) {
					if (short === "goblin" || short === "goblin assassin" || short === "goblin warrior" || short === "goblin shaman" || short === "imp" || short === "imp lord" || short === "imp warlord" || short === "imp overlord" || //Generic encounter
						short === "tentacle beast" || (short === "kitsune" && hair.color === "red") || short === "Akbal" || short === "Tamani" || //Forest, deepwoods
						short === "goo-girl" || short === "green slime" || short === "fetish cultist" || short === "fetish zealot" || //Lake
						short === "sandtrap" || short === "sand tarp" || short === "naga" || short === "demons" || short === "Cum Witch" || //Desert
						short === "hellhound" || short === "infested hellhound" || short === "minotaur" || short === "minotaur lord" || short === "minotaur gang" || short === "minotaur tribe" || short === "basilisk" || short === "phoenix" || //Mountain, high mountains
						short === "satyr" || short === "gnoll" || short === "gnoll spear-thrower" || short === "female spider-morph" || short === "male spider-morph" || short === "corrupted drider" || //Plains, swamp, bog
						short === "yeti" || short === "behemoth") { //Glacial rift, volcanic crag
						game.prison.trainingFeed.prisonCaptorFeedingQuestTrainingProgress(1, 1);
					}
				}
				outputText("\n\nYou'll probably come to your senses in eight hours or so");
				if (player.gems > 1)
					outputText(", missing " + gemsLost + " gems.");
				else if (player.gems === 1)
					outputText(", missing your only gem.");
				else outputText(".");
			}
			else {
				outputText("\n\nSomehow you came out of that alive");
				if (player.gems > 1)
					outputText(", but after checking your gem pouch, you realize you're missing " + gemsLost + " gems.");
				else if (player.gems === 1)
					outputText(", but after checking your gem pouch, you realize you're missing your only gem.");
				else outputText(".");
			}
			return 8; //This allows different monsters to delay the player by different amounts of time after a combat loss. Normal loss causes an eight hour blackout
		}

		override public function set HP(value:Number):void {
			super.HP = value;
			game.mainView.monsterStatsView.refreshStats(game);
		}
		override public function set lust(value:Number):void {
			super.lust = value;
			game.mainView.monsterStatsView.refreshStats(game);
		}
		override public function set fatigue(value:Number):void {
			super.fatigue = value;
			game.mainView.monsterStatsView.refreshStats(game);
		}
	}
}
