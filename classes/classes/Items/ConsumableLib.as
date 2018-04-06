/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.BaseContent;
	import classes.Items.Consumables.*;
	import classes.Player;

	public final class ConsumableLib extends BaseContent {
//		public var consumableItems:Array = [];
		public static const DEFAULT_VALUE:Number = 6;
//		DEMONIC POTIONS
		//Tainted
		public const INCUBID:Consumable = new IncubiDraft(IncubiDraft.TAINTED);
		public const S_DREAM:Consumable = new SuccubisDream();
		public const SDELITE:Consumable = new SuccubisDelight(SuccubisDelight.TAINTED);
		public const SUCMILK:Consumable = new SuccubiMilk(SuccubiMilk.TAINTED);
		//Untainted
		public const P_DRAFT:Consumable = new IncubiDraft(IncubiDraft.PURIFIED);
		public const P_S_MLK:Consumable = new SuccubiMilk(SuccubiMilk.PURIFIED);
		public const PSDELIT:Consumable = new SuccubisDelight(SuccubisDelight.PURIFIED);
//		DYES
		public const AUBURND:HairDye = new HairDye("AuburnD", "Auburn");
		public const BLACK_D:HairDye = new HairDye("Black D", "Black");
		public const BLOND_D:HairDye = new HairDye("Blond D", "Blond");
		public const BLUEDYE:HairDye = new HairDye("BlueDye", "Blue");
		public const BROWN_D:HairDye = new HairDye("Brown D", "Brown");
		public const GRAYDYE:HairDye = new HairDye("GrayDye", "Gray");
		public const GREEN_D:HairDye = new HairDye("Green D", "Green");
		public const ORANGDY:HairDye = new HairDye("OrangDy", "Orange");
		public const PINKDYE:HairDye = new HairDye("PinkDye", "Pink");
		public const PURPDYE:HairDye = new HairDye("PurpDye", "Purple");
		public const RAINDYE:HairDye = new HairDye("RainDye", "Rainbow");
		public const RED_DYE:HairDye = new HairDye("Red Dye", "Red");
		public const RUSSDYE:HairDye = new HairDye("RussetD", "Russet");
		public const YELLODY:HairDye = new HairDye("YelloDy", "Yellow");
		public const WHITEDY:HairDye = new HairDye("WhiteDy", "White");
//		SKIN OILS
		public const DARK_OL:SkinOil = new SkinOil("DarkOil", "Dark");
		public const EBONYOL:SkinOil = new SkinOil("EbonyOl", "Ebony");
		public const FAIR_OL:SkinOil = new SkinOil("FairOil", "Fair");
		public const LIGHTOL:SkinOil = new SkinOil("LightOl", "Light");
		public const MAHOGOL:SkinOil = new SkinOil("MahogOl", "Mahogany");
		public const OLIVEOL:SkinOil = new SkinOil("OliveOl", "Olive");
		public const RUSS_OL:SkinOil = new SkinOil("RussOil", "Russet");
		public const RED__OL:SkinOil = new SkinOil("Red Oil", "Red");
		public const ORANGOL:SkinOil = new SkinOil("OranOil", "Orange");
		public const YELLOOL:SkinOil = new SkinOil("YeloOil", "Yellow");
		public const GREENOL:SkinOil = new SkinOil("GrenOil", "Green");
		public const WHITEOL:SkinOil = new SkinOil("WhitOil", "White");
		public const BLUE_OL:SkinOil = new SkinOil("BlueOil", "Blue");
		public const BLACKOL:SkinOil = new SkinOil("BlakOil", "Black");
		public const PURPLOL:SkinOil = new SkinOil("PurpOil", "Purple");
		public const SILVROL:SkinOil = new SkinOil("SlvrOil", "Silver");
		public const YELGROL:SkinOil = new SkinOil("YlGrOil", "Yellow Green");
		public const SPRGROL:SkinOil = new SkinOil("SpGrOil", "Spring Green");
		public const CYAN_OL:SkinOil = new SkinOil("CyanOil", "Cyan");
		public const OCBLUOL:SkinOil = new SkinOil("OBluOil", "Ocean Blue");
		public const ELVIOOL:SkinOil = new SkinOil("EVioOil", "Electric Violet");
		public const MAGENOL:SkinOil = new SkinOil("MagenOl", "Magenta");
		public const DPPNKOL:SkinOil = new SkinOil("DPnkOil", "Deep Pink");
		public const PINK_OL:SkinOil = new SkinOil("PinkOil", "Pink");
//		BODY LOTIONS
		public const CLEARLN:BodyLotion = new BodyLotion("ClearLn", "Clear", "smooth thick creamy liquid");
		public const ROUGHLN:BodyLotion = new BodyLotion("RoughLn", "Rough", "thick abrasive cream");
		public const SEXY_LN:BodyLotion = new BodyLotion("SexyLtn", "Sexy", "pretty cream like substance");
		public const SMTH_LN:BodyLotion = new BodyLotion("SmthLtn", "Smooth", "smooth thick creamy liquid");
//		EGGS
		//Small
		public const BLACKEG:Consumable = new BlackRubberEgg(BlackRubberEgg.SMALL);
		public const BLUEEGG:Consumable = new BlueEgg(BlueEgg.SMALL);
		public const BROWNEG:Consumable = new BrownEgg(BrownEgg.SMALL);
		public const PINKEGG:Consumable = new PinkEgg(PinkEgg.SMALL);
		public const PURPLEG:Consumable = new PurpleEgg(PurpleEgg.SMALL);
		public const WHITEEG:Consumable = new WhiteEgg(WhiteEgg.SMALL);
		//Large
		public const L_BLKEG:Consumable = new BlackRubberEgg(BlackRubberEgg.LARGE);
		public const L_BLUEG:Consumable = new BlueEgg(BlueEgg.LARGE);
		public const L_BRNEG:Consumable = new BrownEgg(BrownEgg.LARGE);
		public const L_PNKEG:Consumable = new PinkEgg(PinkEgg.LARGE);
		public const L_PRPEG:Consumable = new PurpleEgg(PurpleEgg.LARGE);
		public const L_WHTEG:Consumable = new WhiteEgg(WhiteEgg.LARGE);
		//Others
		public const DRGNEGG:Consumable = new EmberEgg();
		public const NPNKEGG:Consumable = new NeonPinkEgg();
		public const NPEPREG:Consumable = new NeonPinkEgg(true);

//		FOOD & BEVERAGES
		public const BC_BEER:BlackCatBeer = new BlackCatBeer();
		public const BHMTCUM:Consumable = new BehemothCum();
		public const BIMBOCH:BimboChampagne = new BimboChampagne();
		public const C_BREAD:Consumable = new CumBread();
		public const CCUPCAK:Consumable = new GiantChocolateCupcake();
		public const FISHFIL:Consumable = new FishFillet();
		public const FR_BEER:Consumable = new FrothyBeer();
		public const GODMEAD:Consumable = new GodMead();
		public const H_BISCU:Consumable = new HardBiscuits();
		public const IZYMILK:Consumable = new IsabellaMilk();
		public const M__MILK:Consumable = new MarbleMilk();
		public const MINOCUM:Consumable = new MinotaurCum(MinotaurCum.STANDARD);
		public const P_BREAD:Consumable = new PrisonBread();
		public const P_M_CUM:Consumable = new MinotaurCum(MinotaurCum.PURIFIED);
		public const P_WHSKY:PhoukaWhiskey = new PhoukaWhiskey();
		public const PROMEAD:Consumable = new ProMead();
		public const PURPEAC:Consumable = new PurityPeach();
		public const SHEEPMK:Consumable = new SheepMilk();
		public const S_WATER:Consumable = new SpringWater();
		public const TRAILMX:Consumable = new TrailMix();
		public const URTACUM:Consumable = new UrtaCum();
		public const W_PDDNG:Consumable = new WinterPudding();
//		GROWERS/SHRINKERS
		public const REDUCTO:Consumable = new Reducto();
		public const GROPLUS:Consumable = new GroPlus();
//		MAGIC BOOKS
		public const B__BOOK:Consumable = new BlackSpellBook();
		public const W__BOOK:Consumable = new WhiteSpellBook();
//		RARE ITEMS (Permanent effects, gives perks on consumption)
		public const BIMBOLQ:Consumable = new BimboLiqueur();
		public const BROBREW:Consumable = new BroBrew();
		public const HUMMUS2:Consumable = new SuperHummus();
		public const P_PEARL:Consumable = new PurePearl();
//		NON-TRANSFORMATIVE ITEMS
		public const AKBALSL:Consumable = new AkbalSaliva();
		public const C__MINT:Consumable = new Mint();
		public const CERUL_P:Consumable = new CeruleanPotion();
		public const CLOVERS:Consumable = new Clovis();
		public const COAL___:Consumable = new Coal();
		public const DEBIMBO:DeBimbo = new DeBimbo();
		public const EXTSERM:HairExtensionSerum = new HairExtensionSerum();
		public const F_DRAFT:Consumable = new LustDraft(LustDraft.ENHANCED);
		public const H_PILL:Consumable = new HealPill();
		public const HRBCNT:Consumable = new HerbalContraceptive();
		public const ICICLE_:Consumable = new IceShard();
		public const KITGIFT:KitsuneGift = new KitsuneGift();
		public const L_DRAFT:Consumable = new LustDraft(LustDraft.STANDARD);
		public const LACTAID:Consumable = new Lactaid();
		public const LUSTSTK:LustStick = new LustStick();
		public const MILKPTN:Consumable = new MilkPotion();
		public const NUMBOIL:Consumable = new NumbingOil();
		public const NUMBROX:Consumable = new NumbRocks();
		public const OVIELIX:OvipositionElixir = new OvipositionElixir();
		public const OVI_MAX:OvipositionMax = new OvipositionMax();
		public const PEPPWHT:Consumable = new PeppermintWhite();
		public const PPHILTR:Consumable = new PurityPhilter();
		public const PRNPKR :Consumable = new PrincessPucker();
		public const SENSDRF:Consumable = new SensitivityDraft();
		public const SMART_T:Consumable = new ScholarsTea();
		public const VITAL_T:Consumable = new VitalityTincture();
		public const W_STICK:WingStick = new WingStick();
//		TRANSFORMATIVE ITEMS
		public const B_GOSSR:Consumable = new SweetGossamer(SweetGossamer.DRIDER);
		public const BOARTRU:Consumable = new PigTruffle(true);
		public const DRAKHRT:EmberTFs = new EmberTFs(1);
		public const DRYTENT:Consumable = new ShriveledTentacle();
		public const ECHIDCK:Consumable = new EchidnaCake();
		public const ECTOPLS:Consumable = new Ectoplasm();
		public const EMBERBL:EmberTFs = new EmberTFs();
		public const EQUINUM:Consumable = new Equinum();
		public const FOXBERY:Consumable = new FoxBerry(FoxBerry.STANDARD);
		public const FRRTFRT:Consumable = new FerretFruit();
		public const FOXJEWL:Consumable = new FoxJewel(FoxJewel.STANDARD);
		public const GLDRIND:GoldenRind = new GoldenRind();
		public const GLDSEED:Consumable = new GoldenSeed(GoldenSeed.STANDARD);
		public const GOB_ALE:Consumable = new GoblinAle();
		public const HUMMUS_:Consumable = new RegularHummus();
		public const IMPFOOD:Consumable = new ImpFood();
		public const KANGAFT:Consumable = new KangaFruit(KangaFruit.STANDARD);
		public const LABOVA_:LaBova     = new LaBova(LaBova.STANDARD);
		public const MAGSEED:Consumable = new GoldenSeed(GoldenSeed.ENHANCED);
		public const MGHTYVG:Consumable = new KangaFruit(KangaFruit.ENHANCED);
		public const MOUSECO:Consumable = new MouseCocoa();
		public const MINOBLO:Consumable = new MinotaurBlood();
		public const MYSTJWL:Consumable = new FoxJewel(FoxJewel.MYSTIC);
		public const P_LBOVA:Consumable = new LaBova(LaBova.PURIFIED);
		public const PIGTRUF:Consumable = new PigTruffle(false);
		public const PRFRUIT:Consumable = new PurpleFruit();
		public const PROBOVA:Consumable = new LaBova(LaBova.ENHANCED);
		public const RDRROOT:Consumable = new RedRiverRoot();
		public const REPTLUM:Consumable = new Reptilum();
		public const RHINOST:Consumable = new RhinoSteak();
		public const RINGFIG:Consumable = new RingtailFig();
		public const RIZZART:Consumable = new RizzaRoot();
		public const S_GOSSR:Consumable = new SweetGossamer(SweetGossamer.SPIDER);
		public const SALAMFW:Consumable = new Salamanderfirewater();
		public const SATYR_W:Consumable = new SatyrWine();
		public const SHARK_T:Consumable = new SharkTooth(false);  
		public const SNAKOIL:Consumable = new SnakeOil();
		public const TAURICO:Consumable = new Taurinum();
		public const TOTRICE:Consumable = new TonOTrice();
		public const TRAPOIL:Consumable = new TrapOil();
		public const TSCROLL:Consumable = new TatteredScroll();
		public const TSTOOTH:Consumable = new SharkTooth(true);
		public const VIXVIGR:Consumable = new FoxBerry(FoxBerry.ENHANCED);
		public const W_FRUIT:Consumable = new WhiskerFruit();
		public const WETCLTH:Consumable = new WetCloth();
		public const WOLF_PP:Consumable = new WolfPepper();
		public const UBMBOTT:Consumable = new UnlabeledBrownMilkBottle();
		//Bzzzzt! Bee honey ahoy!
		public const BEEHONY:Consumable = new BeeHoney(false, false);
		public const PURHONY:Consumable = new BeeHoney(true, false);
		public const SPHONEY:Consumable = new BeeHoney(false, true);
		//Canine puppers, I mean peppers
		public const CANINEP:Consumable = new CaninePepper(0);
		public const LARGEPP:Consumable = new CaninePepper(1);
		public const DBLPEPP:Consumable = new CaninePepper(2);
		public const BLACKPP:Consumable = new CaninePepper(3);
		public const KNOTTYP:Consumable = new CaninePepper(4);
		public const BULBYPP:Consumable = new CaninePepper(5);

		public const LARGE_EGGS:Array = [L_BLKEG,L_BLUEG,L_BRNEG,L_PNKEG,L_PRPEG,L_WHTEG];
		public const SMALL_EGGS:Array = [BLACKEG,BLUEEGG,BROWNEG,PINKEGG,PURPLEG,WHITEEG];

		public function ConsumableLib() {}
	}
}
