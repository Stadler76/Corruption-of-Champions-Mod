package classes.Scenes.Places {
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.Armor;
	import classes.Items.Consumable;
	import classes.Scenes.Dungeons.DeepCave.ValaScene;
	import classes.Scenes.Places.TelAdre.*;
	import classes.display.SpriteDb;
	import classes.internals.*;
	import classes.Scenes.PregnancyProgression;

	/**
 * The lovely town of Tel Adre
 * @author:
 */
	public class TelAdre extends BaseContent
	{
		public var auntNancy:AuntNancy = new AuntNancy();
		public var bakeryScene:BakeryScene = new BakeryScene();
		public var brooke:Brooke = new Brooke();
		public var cotton:Cotton;
		public var dominika:Dominika = new Dominika();
		public var edryn:Edryn = new Edryn();
		public var frosty:Frosty = new Frosty();
		public var heckel:Heckel = new Heckel();
		public var ifris:Ifris = new Ifris();
		public var jasun:Jasun = new Jasun();
		public var katherine:Katherine = new Katherine();
		public var katherineEmployment:KatherineEmployment = new KatherineEmployment();
		public var katherineThreesome:KatherineThreesome = new KatherineThreesome();
		public var library:Library = new Library();
		public var loppe:Loppe = new Loppe();
		public var lottie:Lottie = new Lottie();
		public var maddie:Maddie = new Maddie();
		public var niamh:Niamh = new Niamh();
		public var pablo:PabloScene = new PabloScene();
		public var rubi:Rubi = new Rubi();
		public var scylla:Scylla = new Scylla();
		public var sexMachine:SexMachine = new SexMachine();
		public var umasShop:UmasShop = new UmasShop();

		public var vala:ValaScene = new ValaScene();
		
		public function TelAdre(pregnancyProgression:PregnancyProgression)
		{
			this.cotton = new Cotton(pregnancyProgression);
		}

//const YVONNE_FUCK_COUNTER:int = 437;



	public function isDiscovered():Boolean {
		return player.hasStatusEffect(StatusEffects.TelAdre);
	}
	public function isAllowedInto():Boolean {
		return player.statusEffectv1(StatusEffects.TelAdre) >= 1;
	}
	public function setStatus(discovered:Boolean,allowed:Boolean):void {
		if (!discovered) {
			player.removeStatusEffect(StatusEffects.TelAdre);
		} else {
			if (!player.hasStatusEffect(StatusEffects.TelAdre)) {
				player.createStatusEffect(StatusEffects.TelAdre,allowed?1:0,0,0,0);
			} else {
				player.changeStatusValue(StatusEffects.TelAdre,1,allowed?1:0);
			}
		}
	}

public function discoverTelAdre():void {
	clearOutput();
	if (!getGame().telAdre.isDiscovered()) {
		outputText("The merciless desert sands grind uncomfortably under your " + player.feet() + " as you walk the dunes, searching the trackless sands to uncover their mysteries.  All of a sudden, you can see the outline of a small city in the distance, ringed in sandstone walls.  Strangely it wasn't there a few moments before.  It's probably just a mirage brought on by the heat.  Then again, you don't have any specific direction you're heading, what could it hurt to go that way?");
		outputText("\n\nDo you investigate the city in the distance?");
	}
	else {
		outputText("While out prowling the desert dunes you manage to spy the desert city of Tel'Adre again.  You could hike over to it again, but some part of you fears being rejected for being 'impure' once again.  Do you try?");
	}
	doYesNo(encounterTelAdre,camp.returnToCampUseOneHour);
}

//player chose to approach the city in the distance
private function encounterTelAdre():void {
	clearOutput();
	if (!getGame().telAdre.isDiscovered()) {
		outputText("You slog through the shifting sands for a long time, not really seeming to get that close.  Just when you're about to give up, you crest a large dune and come upon the walls of the city you saw before.  It's definitely NOT a mirage.  There are sandstone walls at least fifty feet tall ringing the entire settlement, and the only entrance you can see is a huge gate with thick wooden doors.  The entrance appears to be guarded by a female gray fox who's more busy sipping on something from a bottle than watching the desert.\n\n");
		outputText("As if detecting your thoughts, she drops the bottle and pulls out a halberd much longer than she is tall.\n\n");
		outputText("\"<i>Hold it!</i>\" barks the fox, her dark gray fur bristling in suspicion at your sudden appearance, \"<i>What's your business in the city of Tel'Adre?</i>\"\n\n");
		outputText("You shrug and explain that you know nothing about this town, and just found it while exploring the desert.  The girl stares at you skeptically for a moment and then blows a shrill whistle.  She orders, \"<i>No sudden moves.</i>\"\n\n");
		outputText("Deciding you've nothing to lose by complying, you stand there, awaiting whatever reinforcements this cute vulpine-girl has summoned.  Within the minute, a relatively large-chested centauress emerges from a smaller door cut into the gate, holding a massive bow with an arrow already nocked.\n\n");
		outputText("\"<i>What's the problem, Urta?  A demon make it through the barrier?</i>\" asks the imposing horse-woman.\n\nUrta the fox shakes her head, replying, \"<i>I don't think so, Edryn.  " + player.mf("He's","She's") + " something else.  We should use the crystal and see if " + player.mf("he","she") + "'s fit to be allowed entry to Tel'Adre.</i>\"\n\n");
		outputText("You watch the big centaur cautiously as she pulls out a pendant, and approaches you.  \"<i>Hold still,</i>\" she says, \"<i>this will do you no harm.</i>\"\n\n");
		outputText("She places one hand on your shoulder and holds the crystal in the other.  Her eyes close, but her brow knits as she focuses on something.  ");
		telAdreCrystal();
	}
	else {
		outputText("Once again you find the gray fox, Urta, guarding the gates.  She nods at you and whistles for her companion, Edryn once again.  The centauress advances cautiously, and you submit herself to her inspection as she once again produces her magical amulet.  ");
		telAdreCrystal();
	}
}

//Alignment crystal goooooo
private function telAdreCrystal():void {
	if (!getGame().telAdre.isDiscovered()) setStatus(true,false);
	//-70+ corruption, or possessed by exgartuan
	if (player.hasStatusEffect(StatusEffects.Exgartuan) || !player.isPureEnough(70)) {
		outputText("The crystal pendant begins to vibrate in the air, swirling around and glowing dangerously black.  Edryn snatches her hand back and says, \"<i>I'm sorry, but you're too far gone to step foot into our city.  If by some miracle you can shake the corruption within you, return to us.</i>\"\n\n");
		outputText("You shrug and step back.  You could probably defeat these two, but you know you'd have no hope against however many friends they had beyond the walls.  You turn around and leave, a bit disgruntled at their hospitality.  After walking partway down the dune you spare a glance over your shoulder and discover the city has vanished!  Surprised, you dash back up the dune, flinging sand everywhere, but when you crest the apex, the city is gone.");
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//-50+ corruption or corrupted Jojo
	else if (!player.isPureEnough(50) || flags[kFLAGS.JOJO_STATUS] >= 5) {
		outputText("The crystal pendant shimmers, vibrating in place and glowing a purple hue.  Edryn steps back, watching you warily, \"<i>You've been deeply touched by corruption.  You balance on a razor's edge between falling completely and returning to sanity.  You may enter, but we will watch you closely.</i>\"\n\n");
	}
	//-25+ corruption or corrupted Marae
	else if (!player.isPureEnough(25) || flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
		outputText("The crystal pendant twirls in place, glowing a dull red.  Edryn takes a small step back and murmurs, \"<i>You've seen the darkness of this land first hand, but its hold on you is not deep.  You'll find sanctuary here.  The demons cannot find this place yet, and we promise you safe passage within the walls.</i>\"\n\n");
	}
	//-Low corruption/pure characters
	else {
		outputText("The crystal shines a pale white light.  Edryn steps back and smiles broadly at you and says, \"<i>You've yet to be ruined by the demonic taint that suffuses the land of Mareth.  Come, you may enter our city walls and find safety here, though only so long as the covenant's white magic protects us from the demons' lapdogs.</i>\"\n\n");
	}
	outputText("The vixen Urta gestures towards the smaller door and asks, \"<i>Would you like a tour of Tel'Adre, newcomer?</i>\"\n\n");
	outputText("You remember your etiquette and nod, thankful to have a quick introduction to such a new place.  Urta leaves Edryn to watch the gate and leads you inside.  You do notice her gait is a bit odd, and her fluffy fox-tail seems to be permanently wrapped around her right leg.  The door closes behind you easily as you step into the city of Tel'Adre...");
	doNext(telAdreTour);
}

private function telAdreTour():void {
	setStatus(true,true);
	clearOutput();
	kGAMECLASS.urta.urtaSprite();
	outputText("Urta leads you into the streets of Tel'Adre, giving you a brief run-down of her and her city, \"<i>You see, about two decades back, the demons were chewing their way through every settlement and civilization in Mareth.  The covenant, a group of powerful magic-users, realized direct confrontation was doomed to fail.  They hid us in the desert with their magic, and the demons can't corrupt what they can't find.  So we're safe, for now.</i>\"\n\n");
	outputText("The two of you find yourselves in the center of a busy intersection.  Urta explains that this is the main square of the city, and that, although the city is large, a goodly portion of it remains empty.  Much of the population left to assist other settlements in resisting the demons and was lost.  She brushes a lock of stray hair from her eye and guides you down the road, making sure to point out her favorite pub - \"The Wet Bitch\".  You ");
	if (player.cor < 25) outputText("blush");
	else outputText("chuckle");
	outputText(" at the rather suggestive name as Urta turns around and says, \"<i>With how things are, we've all gotten a lot more comfortable with our sexuality.  I hope it doesn't bother you.</i>\"\n\n");
	outputText("A bit further on, you're shown a piercing parlor, apparently another favorite of Urta's.  A cute human girl with cat-like ears peeks out the front and gives you both a friendly wave.  It's so strange to see so many people together in one place, doing things OTHER than fucking.  The whole thing makes you miss your hometown more than ever.  Tears come to your eyes unbidden, and you wipe them away, glad to at least have this one reminder of normalcy.  Urta politely pretends not to notice, though the tail she keeps wrapped around her leg twitches as she wraps up the tour.\n\n");
	outputText("She gives you a friendly punch on the shoulder and says, \"<i>Okay, gotta go!  Be good and stay out of trouble, alright?</i>\"\n\n");
	outputText("Before you can answer, she's taken off back down the street, probably stopping off at 'The Wet Bitch' for a drink.  Strange, her departure was rather sudden...");
	doNext(telAdreMenu);
}

public function telAdreMenu():void {
	if (flags[kFLAGS.VALENTINES_EVENT_YEAR] < date.fullYear && player.balls > 0 && player.hasCock() && flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 4 && flags[kFLAGS.TIMES_MET_SCYLLA_IN_ADDICTION_GROUP] > 0 && isValentine()) {
		kGAMECLASS.valentines.crazyVDayShenanigansByVenithil();
		return;
	}
	if (!kGAMECLASS.urtaQuest.urtaBusy() && flags[kFLAGS.PC_SEEN_URTA_BADASS_FIGHT] == 0 && rand(15) == 0 && getGame().time.hours > 15) {
		urtaIsABadass();
		return;
	}
	if (!kGAMECLASS.urtaQuest.urtaBusy() && kGAMECLASS.urta.pregnancy.event > 5 && rand(30) == 0) {
		kGAMECLASS.urtaPregs.urtaIsAPregnantCopScene();
	   return;
	}
	switch (flags[kFLAGS.KATHERINE_UNLOCKED]) {
		case -1:
		case  0: //Still potentially recruitable
			if (flags[kFLAGS.KATHERINE_RANDOM_RECRUITMENT_DISABLED] == 0 && player.gems > 34 && rand(25) == 0) {
				if (flags[kFLAGS.KATHERINE_UNLOCKED] == 0)
					katherine.ambushByVagrantKittyKats()
				else katherine.repeatAmbushKatherineRecruitMent();
				return;
			}
			break;
		case  1: //In alley behind Oswald's
		case  2: //You are training her
		case  3: //You and Urta are training her
			break;
		case  4: //Employed
			if (!katherine.isAt(Katherine.KLOC_KATHS_APT) && flags[kFLAGS.KATHERINE_TRAINING] >= 100) {
				katherineEmployment.katherineGetsEmployed();
				return;
			}
			break;
		default: //Has given you a spare key to her apartment
			if (getGame().time.hours < 10 && rand(12) == 0) { //If employed or housed she can sometimes be encountered while on duty
				katherine.katherineOnDuty();
				return;
			}
	}
	if (flags[kFLAGS.ARIAN_PARK] == 0 && rand(10) == 0 && flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] == 0) {
		kGAMECLASS.arianScene.meetArian();
		return;
	}
	//Display Tel'adre menu options//
	//Special Delivery☼☼☼
	//Has a small-ish chance of playing when the PC enters Tel'Adre.
	//Must have Urta's Key.
	//Urta must be pregnant to trigger this scene.
	//Play this scene upon entering Tel'Adre.
	if (kGAMECLASS.urta.pregnancy.event > 2 && rand(4) == 0 && flags[kFLAGS.URTA_PREGNANT_DELIVERY_SCENE] == 0 && player.hasKeyItem("Spare Key to Urta's House") >= 0) {
		kGAMECLASS.urtaPregs.urtaSpecialDeliveries();
		return;
	}
	if (flags[kFLAGS.MADDIE_STATUS] == -1) {
		maddie.runAwayMaddieFollowup();
		return;
	}
	spriteSelect(null);
	outputText(images.showImage("location-teladre"));
	clearOutput();
	outputText("Tel'Adre is a massive city, though most of its inhabitants tend to hang around the front few city blocks.  It seems the fall of Mareth did not leave the city of Tel'Adre totally unscathed.  A massive tower rises up in the center of the city, shimmering oddly.  From what you overhear in the streets, the covenant's magic-users slave away in that tower, working to keep the city veiled from outside dangers.  There does not seem to be a way to get into the unused portions of the city, but you'll keep your eyes open.\n\n");
	outputText("A sign depicting a hermaphroditic centaur covered in piercings hangs in front of one of the sandstone buildings, and bright pink lettering declares it to be the 'Piercing Studio'.  You glance over and see the wooden facade of Urta's favorite bar, 'The Wet Bitch'.  How strange that those would be what she talks about during a tour.  In any event you can also spot some kind of wolf-man banging away on an anvil in a blacksmith's stand, and a foppishly-dressed dog-man with large floppy ears seems to be running some kind of pawnshop in his stand.  Steam boils from the top of a dome-shaped structure near the far end of the street, and simple lettering painted on the dome proclaims it to be a bakery.  Perhaps those shops will be interesting as well.");
	if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && !kGAMECLASS.raphael.RaphaelLikes()) {
		outputText("\n\nYou remember Raphael's offer about the Orphanage, but you might want to see about shaping yourself more to his tastes first.  He is a picky fox, after all, and you doubt he would take well to seeing you in your current state.");
	}
	telAdreMenuShow();
}

public function telAdreMenuShow():void { //Just displays the normal Tel'Adre menu options, no special events, no description. Useful if a special event has already played
	var homes:Boolean = false;
	if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && kGAMECLASS.raphael.RaphaelLikes())
		homes = true;
	else if (player.hasKeyItem("Spare Key to Urta's House") >= 0)
		homes = true;
	else if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 5)
		homes = true;
	else if (flags[kFLAGS.ARIAN_PARK] >= 4 && !kGAMECLASS.arianScene.arianFollower())
		homes = true;
	menu();
	addButton(0, "Shops", armorShops);
	addButton(1, "Bakery", bakeryScene.bakeryuuuuuu);
	addButton(2, "Bar", enterBarTelAdre);
	addButton(3, "Gym", gymDesc);
	if (homes) addButton(4, "Homes", houses);
	if (flags[kFLAGS.ARIAN_PARK] > 0 && flags[kFLAGS.ARIAN_PARK] < 4) addButton(5, "Park", kGAMECLASS.arianScene.visitThePark);
	addButton(6, "Pawn", oswaldPawn);
	addButton(7, "Tower", library.visitZeMagesTower);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
	if (flags[kFLAGS.GRIMDARK_MODE] > 0) addButton(14, "Leave", leaveTelAdreGrimdark);
}

		public function leaveTelAdreGrimdark():void {
			inRoomedDungeonResume = getGame().dungeons.resumeFromFight;
			getGame().dungeons._currentRoom = "desert";
			getGame().dungeons.move(getGame().dungeons._currentRoom);
		}

private function armorShops():void {
	clearOutput();
	outputText("The shopping district of Tel’adre happens to be contained in a large dead end street, with a large set of doors at the entrance to protect it from thieves at night, you’d assume from a higher elevation it would look like a giant square courtyard. Due to the cities shopping area being condensed into one spot, most if not every visible wall has been converted into a store front, in the center of the area are some small stands, guess not everyone can afford a real store.");
	outputText("\n\nRight off the bat you see the ‘Piercing Studio’, its piercing covered centaur sign is a real eye catcher. You can also spot some kind of wolf-man banging away on an anvil in a blacksmith's stand. As well as other shops lining the walls, perhaps those shops will be interesting as well.");
	menu();
	addButton(0, "Blacksmith", new YvonneArmorShop().enter);
	addButton(1, "Piercing", new YaraPiercingStudio().piercingStudio);
	addButton(2, "Tailor", new VictoriaTailorShop().enter);
	addButton(3, "Weapons", new WeaponShop().enter);
	addButton(4, "Jewelry", new JewelryShop().enter);
	addButton(5, "Clinic", umasShop.enterClinic);
	addButton(6, "Carpenter", new CarpentryShop().enter);
	addButton(14,"Back",telAdreMenu);
}

public function houses():void {
	clearOutput();
	outputText("Whose home will you visit?");
	var orphanage:Function = null;
	if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2) {
		if (kGAMECLASS.raphael.RaphaelLikes())
		{
			orphanage = kGAMECLASS.raphael.orphanageIntro;
		}
		else {
			outputText("\n\nYou remember Raphael's offer about the Orphanage, but you might want to see about shaping yourself more to his tastes first.  He is a picky fox, after all, and you doubt he would take well to seeing you in your current state.");
		}
	}
	menu();
	if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 5) addButton(0, "Kath's Apt", katherine.visitAtHome);
	if (kGAMECLASS.urtaPregs.urtaKids() > 0 && player.hasKeyItem("Spare Key to Urta's House") >= 0)
		addButton(1, "Urta's House", (katherine.isAt(Katherine.KLOC_URTAS_HOME) ? katherine.katherineAtUrtas : kGAMECLASS.urtaPregs.visitTheHouse));
	if (flags[kFLAGS.ARIAN_PARK] >= 4 && !kGAMECLASS.arianScene.arianFollower()) addButton(2,"Arian's",kGAMECLASS.arianScene.visitAriansHouse);
	addButton(3,"Orphanage",orphanage);
	addButton(14,"Back",telAdreMenu);
}



public function oswaldPawn():void {
	spriteSelect(SpriteDb.s_oswald);
	clearOutput();
	if (!player.hasStatusEffect(StatusEffects.Oswald)) {
		outputText("Upon closer inspection, you realize the pawnbroker appears to be some kind of golden retriever.  He doesn't look entirely comfortable and he slouches, but he manages to smile the entire time.  His appearance is otherwise immaculate, including his classy suit-jacket and tie, though he doesn't appear to be wearing any pants.  Surprisingly, his man-bits are retracted.  ");
		if (player.cor < 75) outputText("Who would've thought that seeing someone NOT aroused would ever shock you?");
		else outputText("What a shame, but maybe you can give him a reason to stand up straight?");
		outputText("  His stand is a disheveled mess, in stark contrast to its well-groomed owner.  He doesn't appear to be selling anything at all right now.\n\n");
		outputText("The dog introduces himself as Oswald and gives his pitch, \"<i>Do you have anything you'd be interested in selling?  The name's Oswald, and I'm the best trader in Tel'Adre.</i>\"\n\n");
		outputText("(You can sell an item here, but Oswald will not let you buy them back, so be sure of your sales.)");
		player.createStatusEffect(StatusEffects.Oswald,0,0,0,0);
	}
	else {
		outputText("You see Oswald fiddling with a top hat as you approach his stand again.  He looks up and smiles, padding up to you and rubbing his furry hands together.  He asks, \"<i>Have any merchandise for me " + player.mf("sir","dear") + "?</i>\"\n\n");
	}
	menu();
	addButton(0, "Buy", oswaldBuyMenu);
	addButton(1, "Sell", oswaldPawnMenu);
	switch (flags[kFLAGS.KATHERINE_UNLOCKED]) {
		case 1:
		case 2: addButton(2, "Kath's Alley", katherine.visitKatherine); break;
		case 3: addButton(2, "Safehouse", katherineEmployment.katherineTrainingWithUrta); break;
		case 4: addButton(2, "Kath's Alley", katherineEmployment.postTrainingAlleyDescription); break; //Appears until Kath gives you her housekeys
		default:
	}
	if (player.hasKeyItem("Carrot") < 0 && flags[kFLAGS.NIEVE_STAGE] == 3) {
		outputText("\n\nIn passing, you mention that you're looking for a carrot.\n\nOswald's tophat tips precariously as his ears perk up, and he gladly announces, \"<i>I happen to have come across one recently - something of a rarity in these dark times, you see.  I could let it go for 500 gems, if you're interested.</i>\"");
		if (player.gems < 500)
			outputText("\n\n<b>You can't afford that!</b>");
		else
			addButton(3, "Buy Carrot", buyCarrotFromOswald);
	}
	addButton(4, "Leave", telAdreMenu);
}

private function buyCarrotFromOswald():void {
	player.gems -= 500;
	statScreenRefresh();
	player.createKeyItem("Carrot",0,0,0,0);
	clearOutput();
	outputText("Gems change hands in a flash, and you're now the proud owner of a bright orange carrot!\n\n(<b>Acquired Key Item: Carrot</b>)");
	menu();
	addButton(0,"Next",oswaldPawn);
}

private function oswaldBuyMenu():void {
	clearOutput();
	var buyMod:Number = 2;
	outputText("You ask if Oswald has anything to sell. He nods and says, \"<i>Certainly. If you don't see anything that interests you, come back tomorrow. We get new stocks of merchandise all the time.</i>\"");
	outputText("\n\n<b><u>Oswald's Prices</u></b>");
	outputText("\n" + ItemType.lookupItem(flags[kFLAGS.BENOIT_1]).longName + ": " + Math.round(buyMod * ItemType.lookupItem(flags[kFLAGS.BENOIT_1]).value));
	outputText("\n" + ItemType.lookupItem(flags[kFLAGS.BENOIT_2]).longName + ": " + Math.round(buyMod * ItemType.lookupItem(flags[kFLAGS.BENOIT_2]).value));
	outputText("\n" + ItemType.lookupItem(flags[kFLAGS.BENOIT_3]).longName + ": " + Math.round(buyMod * ItemType.lookupItem(flags[kFLAGS.BENOIT_3]).value));
	menu();
	addButton(0, flags[kFLAGS.BENOIT_1], oswaldTransactBuy, 1);
	addButton(1, flags[kFLAGS.BENOIT_2], oswaldTransactBuy, 2);
	addButton(2, flags[kFLAGS.BENOIT_3], oswaldTransactBuy, 3);
	addButton(4, "Back", oswaldPawn);
}

private function oswaldTransactBuy(slot:int = 1):void {
	clearOutput();
	var itype:ItemType;
	var buyMod:Number = 2;
	if (slot == 1) itype = ItemType.lookupItem(flags[kFLAGS.BENOIT_1]);
	else if (slot == 2) itype = ItemType.lookupItem(flags[kFLAGS.BENOIT_2]);
	else itype = ItemType.lookupItem(flags[kFLAGS.BENOIT_3]);
	if (player.gems < Math.round(buyMod * itype.value)) {
		outputText("You consider making a purchase, but you lack the gems to go through with it.");
		doNext(oswaldBuyMenu);
		return;
	}
	outputText("After examining what you've picked out with his fingers, Oswald hands it over, names the price and accepts your gems with a curt nod.\n\n");
	player.gems -= Math.round(buyMod * itype.value);
	statScreenRefresh();

	if (flags[kFLAGS.SHIFT_KEY_DOWN] == 1 && itype is Consumable) {
		(itype as Consumable).useItem();
		doNext(oswaldBuyMenu);
	} else inventory.takeItem(itype, oswaldBuyMenu);
}

private function oswaldPawnMenu(returnFromSelling:Boolean = false):void { //Moved here from Inventory.as
	clearOutput();
	spriteSelect(SpriteDb.s_oswald);
	outputText("You see Oswald fiddling with a top hat as you approach his stand again.  He looks up and smiles, padding up to you and rubbing his furry hands together.  He asks, \"<i>Have any merchandise for me " + player.mf("sir","dear") + "?</i>\"\n\n");
	outputText("(You can sell an item here, but Oswald will not let you buy them back, so be sure of your sales.  You can shift-click to sell all items in a selected stack.)");
	outputText("\n\n<b><u>Oswald's Estimates</u></b>");
	menu();
	var totalItems:int = 0;
	for (var slot:int = 0; slot < 10; slot++) {
		if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
			outputText("\n" + int(player.itemSlots[slot].itype.value / 2) + " gems for " + player.itemSlots[slot].itype.longName + ".");
			addButton(slot, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), oswaldPawnSell, slot);
			totalItems += player.itemSlots[slot].quantity;
		}
	}
	if (totalItems > 1) addButton(12, "Sell All", oswaldPawnSellAll);
	addButton(14, "Back", oswaldPawn);
}

private function oswaldPawnSell(slot:int):void { //Moved here from Inventory.as
	spriteSelect(SpriteDb.s_oswald);
	var itemValue:int = int(player.itemSlots[slot].itype.value / 2);
	clearOutput();
	if (flags[kFLAGS.SHIFT_KEY_DOWN] == 1) {
		if (itemValue == 0)
			outputText("You hand over " + num2Text(player.itemSlots[slot].quantity) + " " +  player.itemSlots[slot].itype.shortName + " to Oswald.  He shrugs and says, “<i>Well ok, it isn't worth anything, but I'll take it.</i>”");
		else outputText("You hand over " + num2Text(player.itemSlots[slot].quantity) + " " +  player.itemSlots[slot].itype.shortName + " to Oswald.  He nervously pulls out " + num2Text(itemValue * player.itemSlots[slot].quantity)  + " gems and drops them into your waiting hand.");
		while (player.itemSlots[slot].quantity > 0){
			player.itemSlots[slot].removeOneItem();
			player.gems += itemValue;
		}
	}
	else {
		if (itemValue == 0)
			outputText("You hand over " + player.itemSlots[slot].itype.longName + " to Oswald.  He shrugs and says, “<i>Well ok, it isn't worth anything, but I'll take it.</i>”");
		else outputText("You hand over " + player.itemSlots[slot].itype.longName + " to Oswald.  He nervously pulls out " + num2Text(itemValue) + " gems and drops them into your waiting hand.");
		player.itemSlots[slot].removeOneItem();
		player.gems += itemValue;
	}
	statScreenRefresh();
	doNext(createCallBackFunction(oswaldPawnMenu, true));
}

private function oswaldPawnSellAll():void {
	spriteSelect(SpriteDb.s_oswald);
	var itemValue:int = 0;
	clearOutput();
	for (var slot:int = 0; slot < 10; slot++) {
		if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
			itemValue += player.itemSlots[slot].quantity * int(player.itemSlots[slot].itype.value / 2);
			player.itemSlots[slot].quantity = 0;
		}
	}
	outputText("You lay out all the items you're carrying on the counter in front of Oswald.  He examines them all and nods.  Nervously, he pulls out " + num2Text(itemValue) + " gems and drops them into your waiting hand.");
	player.gems += itemValue;
	statScreenRefresh();
	doNext(createCallBackFunction(oswaldPawnMenu, true));
}

private function anotherButton(button:int, nam:String, func:Function, arg:* = -9000):int {
	if (button > 8) return 9;
	addButton(button, nam, func, arg);
	button++;
	return button;
}
private function enterBarTelAdre():void {
	if (isThanksgiving() && flags[kFLAGS.PIG_SLUT_DISABLED] == 0) kGAMECLASS.thanksgiving.pigSlutRoastingGreet();
	else barTelAdre();
}

public function barTelAdre():void {
	// Dominka & Edryn both persist their sprites if you back out of doing anything with them -- I
	// I guess this is good a place as any to catch-all the sprite, because I don't think theres ever a case you get a sprite from just entering the bar?
	spriteSelect( -1);

	hideUpDown();
	var button:int = 0;
	clearOutput();
	if (flags[kFLAGS.LOPPE_DISABLED] == 0 && flags[kFLAGS.LOPPE_MET] == 0 && rand(10) == 0) {
		loppe.loppeFirstMeeting();
		return;
	}
	outputText(images.showImage("location-teladre-thewetbitch"));
	outputText("The interior of The Wet Bitch is far different than the mental picture its name implied.  It looks like a normal tavern, complete with a large central hearth, numerous tables and chairs, and a polished dark wood bar.  The patrons all seem to be dressed and interacting like normal people, that is if normal people were mostly centaurs and dog-morphs of various sub-species.  The atmosphere is warm and friendly, and ");
	if (player.humanScore() <= 3) outputText("despite your altered appearance, ");
	outputText("you hardly get any odd stares.  There are a number of rooms towards the back, as well as a stairway leading up to an upper level.");
	
	scylla.scyllaBarSelectAction(); //Done before anything else so that other NPCs can check scylla.action to see what she's doing
		//Thanks to this function and edryn.edrynHeliaThreesomePossible() the bar menu will always display the same possible options until the game time advances.
		//So it's safe to return to this menu, Helia or Urta can't suddenly disappear or appear just from leaving and re-entering the bar.

	menu();
	//AMILY!
	if (flags[kFLAGS.AMILY_VISITING_URTA] == 1) {
		button = anotherButton(button,"Ask4Amily",kGAMECLASS.followerInteractions.askAboutAmily);
	}
	//DOMINIKA
	if (getGame().time.hours > 17 && getGame().time.hours < 20 && flags[kFLAGS.DOMINIKA_STAGE] != -1) {
		button = anotherButton(button,"Dominika",dominika.fellatrixBarApproach);
	}
	//EDRYN!
	if (edryn.pregnancy.type != PregnancyStore.PREGNANCY_TAOTH) { //Edryn is unavailable while pregnant with Taoth
		if (edryn.edrynBar()) {
			if (edryn.pregnancy.isPregnant) {
				if (flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] == 0) {
					flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] = 1;
					if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] == 0) { //Edryn panic appearance! (First time mom)
						outputText("\n\nEdryn smiles when she sees you and beckons you towards her.  Fear and some kind of frantic need are painted across her face, imploring you to come immediately.  Whatever the problem is, it doesn't look like it can wait.");
						doNext(edryn.findOutEdrynIsPregnant);
						return;
					}
					else { //Edryn re-preggers appearance!
						outputText("\n\nEdryn smiles at you and yells, \"<i>Guess what " + player.short + "?  I'm pregnant again!</i>\"  There are some hoots and catcalls but things quickly die down.  You wonder if her scent will be as potent as before?");
					}
				}
				else { //Mid-pregnancy appearance
					outputText("\n\nEdryn is seated at her usual table, and chowing down with wild abandon.  A stack of plates is piled up next to her.  Clearly she has been doing her best to feed her unborn child.  She notices you and waves, blushing heavily.");
				}
			}
			//Edryn just had a kid and hasn't talked about it!
			else if (flags[kFLAGS.EDRYN_NEEDS_TO_TALK_ABOUT_KID] == 1) {
				outputText("\n\nEdryn the centaur isn't pregnant anymore!  She waves excitedly at you, beckoning you over to see her.  It looks like she's already given birth to your child!");
			}
			//Appearance changes if has had kids
			else if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0) {
				outputText("\n\nEdryn is seated at her usual place, picking at a plate of greens and sipping a mug of the local mead.  She looks bored until she sees you.  Her expression brightens immediately, and Edryn fiddles with her hair and changes her posture slightly.  You aren't sure if she means to, but her cleavage is prominently displayed in an enticing manner.");
			}
			else if (player.statusEffectv1(StatusEffects.Edryn) < 3) {
				outputText("\n\nEdryn, the centauress you met at the gate, is here, sitting down at her table alone and sipping on a glass of wine.  You suppose you could go talk to her a bit.");
			}
			else outputText("\n\nEdryn the centauress is here, sipping wine at a table by herself.  She looks up and spots you, her eyes lighting up with happiness.  She gives you a wink and asks if you'll join her.");
			button = anotherButton(button,"Edryn",edryn.edrynBarTalk);
		}
	}
	if (flags[kFLAGS.KATHERINE_LOCATION] == Katherine.KLOC_BAR) {
		if (flags[kFLAGS.KATHERINE_UNLOCKED] == 4) { 
			katherine.barFirstEncounter();
			return;
		}
		if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 31 && kGAMECLASS.urta.urtaAtBar() && !kGAMECLASS.urta.urtaDrunk() && flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN] == 0) {
			katherine.barKathUrtaLoveAnnounce();
			return;
		}
		katherine.barDescription();
		button = anotherButton(button, "Katherine", katherine.barApproach);
    }
	//trace("HEL FOLLOWER LEVEL: " + flags[kFLAGS.HEL_FOLLOWER_LEVEL] + " HEL FUCKBUDDY: " + flags[kFLAGS.HEL_FUCKBUDDY] + " HARPY QUEEN DEFEATED: " + flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED]);
	//trace("REDUCED ENCOUNTER RATE (DISPLINED): " + flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE]);
	//HELIA
//	if (player.gender > 0 && getGame().time.hours >= 14 && rand(2) == 0 && getGame().time.hours < 20 && (flags[kFLAGS.HEL_FUCKBUDDY] != 0 || kGAMECLASS.helFollower.followerHel()) && !(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1 && flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED]== 0)) {
	if (edryn.edrynHeliaThreesomePossible()) {
		edryn.helAppearance();
		button = anotherButton(button,"Helia",edryn.approachHelAtZeBitch);
	}
	//NANCY
	if (auntNancy.auntNancy(false)) {
		auntNancy.auntNancy(true);
		if (flags[kFLAGS.NANCY_MET] > 0) button = anotherButton(button,"Nancy",auntNancy.interactWithAuntNancy);
		else button = anotherButton(button,"Barkeep",auntNancy.interactWithAuntNancy);
	}
	else outputText("\n\nIt doesn't look like there's a bartender working at the moment.");

	//NIAMH
	if (getGame().time.hours >= 8 && getGame().time.hours <= 16 && flags[kFLAGS.NIAMH_STATUS] == 0) {
		niamh.telAdreNiamh();
		if (flags[kFLAGS.MET_NIAMH] == 0) button = anotherButton(button,"Beer Cat",niamh.approachNiamh);
		else button = anotherButton(button,"Niamh",niamh.approachNiamh);
	}
	//ROGAR #1
	if (flags[kFLAGS.ROGAR_PHASE] == 3 && flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_FUCKED_TODAY] == 0) {
		button = anotherButton(button,"HoodedFig",kGAMECLASS.swamp.rogar.rogarThirdPhase);
		//Wet Bitch screen text when Ro'gar phase = 3:
		outputText("\n\nYou notice a cloaked figure at the bar, though you're quite unable to discern anything else as its back is turned to you.");
	}
	//ROGAR #2
	else if (flags[kFLAGS.ROGAR_PHASE] >= 4 && flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_FUCKED_TODAY] == 0) {
		button = anotherButton(button,"Rogar",kGAMECLASS.swamp.rogar.rogarPhaseFour);
		//Wet Bitch bar text when Ro'gar phase = 4:
		outputText("\n\nRo'gar is here with his back turned to the door, wearing his usual obscuring cloak.");
	}

	switch (scylla.action) { //Scylla - requires dungeon shut down
		case Scylla.SCYLLA_ACTION_FIRST_TALK:
			outputText("\n\nThere is one nun sitting in a corner booth who catches your eye.  She sits straight-backed against the dark, wood chair, her thin waist accentuating the supple curve of her breasts. She's dressed in a black robe that looks a few sizes too small for her hips and wears a black and white cloth over her head.");
			button = anotherButton(button, "Nun", scylla.talkToScylla);
			break;
		case Scylla.SCYLLA_ACTION_ROUND_TWO:
			scylla.scyllaRoundII();
			return;
		case Scylla.SCYLLA_ACTION_ROUND_THREE:
			scylla.scyllaRoundThreeCUM();
			return;
		case Scylla.SCYLLA_ACTION_ROUND_FOUR:
			scylla.scyllaRoundIVGo();
			return;
		case Scylla.SCYLLA_ACTION_MEET_CATS:
			outputText("\n\nIt looks like Scylla is here but getting ready to leave.  You could check and see what the misguided nun is up to.");
			button = anotherButton(button, "Scylla", scylla.Scylla6);
			break;
		case Scylla.SCYLLA_ACTION_ADICTS_ANON:
			outputText("\n\nYou see Scylla's white and black nun's habit poking above the heads of the other patrons.  The tall woman seems unaware of her effect on those around her, but it's clear by the way people are crowding she's acquired a reputation by now.  You're not sure what she's doing, but you could push your way through to find out.");
			button = anotherButton(button, "Scylla", scylla.scyllaAdictsAnonV);
			break;
		case Scylla.SCYLLA_ACTION_FLYING_SOLO:
			outputText("\n\nIt looks like Scylla is milling around here this morning, praying as she keeps an eye out for someone to 'help'.");
			button = anotherButton(button, "Scylla", scylla.scyllasFlyingSolo);
			break;
		default:
	}
	//Nun cat stuff!
	if (katherine.needIntroductionFromScylla()) {
		katherine.catMorphIntr();
		button = anotherButton(button,"ScyllaCats",katherine.katherineGreeting);
	}
	//URTA
	if (kGAMECLASS.urta.urtaAtBar()) {
		//Scylla & The Furries Foursome
		if (scylla.action == Scylla.SCYLLA_ACTION_FURRY_FOURSOME)
		{
			//trace("SCYLLA ACTION: " + scylla.action);
			outputText("\n\nScylla’s spot in the bar is noticeably empty. She’s usually around at this time of day, isn’t she? Urta grabs your attention with a whistle and points to a back room with an accompanying wink. Oh... that makes sense. Surely the nun won’t mind a little help with her feeding...");
			button = anotherButton(button,"Back Room",scylla.openTheDoorToFoursomeWivScyllaAndFurries);
		}
		//Urta X Scylla threesome
		if (scylla.action == Scylla.SCYLLA_ACTION_FUCKING_URTA) {
			if (flags[kFLAGS.TIMES_CAUGHT_URTA_WITH_SCYLLA] == 0)
				outputText("\n\n<b>Though Urta would normally be here getting sloshed, her usual spot is completely vacant.  You ask around but all you get are shrugs and giggles.  Something isn't quite right here.  You see an empty bottle of one of her favorite brands of whiskey still rolling on her table, so she can't have been gone long.  Maybe she had guard business, or had to head to the back rooms for something?</b>");
			else
				outputText("\n\nUrta's usual place is vacant, though her table still holds a half-drank mug of something potent and alcoholic.  If it's anything like the last time this happened, she's snuck into a back room with Scylla to relieve some pressure.  It might not hurt to join in...");
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 4;
			button = anotherButton(button, "Back Room", kGAMECLASS.urta.scyllaAndUrtaSittingInATree);
		}
		else if (kGAMECLASS.urta.urtaBarDescript()) {
			if (auntNancy.auntNancy(false) && flags[kFLAGS.URTA_INCUBATION_CELEBRATION] == 0 && kGAMECLASS.urta.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
				kGAMECLASS.urtaPregs.urtaIsHappyAboutPregnancyAtTheBar();
				return;
			}
			button = anotherButton(button,"Urta",kGAMECLASS.urta.urtaBarApproach);
		}
	}
	//VALA
	if (vala.purifiedFaerieBitchBar()) button = anotherButton(button,"Vala",vala.chooseValaInBar);

	addButton(14,"Leave",telAdreMenu);
}


private function urtaIsABadass():void {
	flags[kFLAGS.PC_SEEN_URTA_BADASS_FIGHT] = 1;
	clearOutput();
	outputText("There's a commotion in the streets of Tel'Adre.  A dense crowd of onlookers has formed around the center of the street, massed together so tightly that you're unable to see much, aside from the backs the other onlookers' heads.  The sound of blows impacting on flesh can be heard over the crowd's murmuring, alerting you of the fight at the gathering's core.");
	menu();
	addButton(0, "Investigate", watchUrtaBeABadass);
	addButton(1, "Who cares?", telAdreMenu);
}

//[Invetigate]
private function watchUrtaBeABadass():void {
	clearOutput();
	kGAMECLASS.urta.urtaSprite();
	outputText("You shoulder past the bulky centaurs, ignore the rough fur of the nearby wolves and hounds as it brushes against you, and press your way through to the center of the crowd.  Eventually the throng parts, revealing the embattled combatants.  A snarling wolf, nearly eight feet tall, towers over Urta.  The comparatively diminutive fox-woman is girded in light leather armor and dripping with sweat.  The larger wolf-man is staggering about, and his dark brown fur is matted with blood.\n\n");

	outputText("The bigger canid charges, snarling, with his claws extended.  Urta sidesteps and pivots, her momentum carrying her foot around in a vicious kick.  Her foot hits the side of the beast's knee hard enough to buckle it, and the wolf goes down on his knees with an anguished cry.  Urta slips under his arm and twists, turning his slump into a fall.  A cloud of dust rises from the heavy thud of the beast's body as it slams into the cobblestone street.\n\n");

	outputText("Now that it's immobile, you get can get a better look at the defeated combatant, and you're ");
	if (player.hasStatusEffect(StatusEffects.Infested)) outputText("aroused");
	else if (player.cor < 50) outputText("horrified");
	else outputText("confused");
	outputText(" by what you see.  A pair of thick, demonic horns curve back over the beast's head, piercing through the bottoms of its wolf-like ears.  Its entire body is covered in rippling muscle, leaving you in no doubt of its strength.  Even with a broken knee, the wolf-man is clearly aroused: protruding from a bloated sheath, his massive dog-dick is fully erect, solid black in color, with an engorged knot.  Small white worms crawl over the surface of his penis, wriggling out of the tip and crawling down the length, leaving trails of slime behind them.\n\n");

	outputText("Urta kneels down onto the corrupted wolf's throat, cutting off its air as it foams and struggles under her.  With grim determination, she holds the weakening, demonically-tainted wolf underneath her, leaning all of her body-weight into her knee to keep it down.  It struggles for what seems like ages, but eventually the tainted wolf's eyes roll closed.  Urta nods and rises, watching closely as the beast's breathing resumes.\n\n");

	outputText("She barks, \"<i>Get this one outside the walls before he wakes.  I won't have this corrupted filth in our city, and make sure you get the wards updated.  If he manages to find his way back, you sorry excuses for guards will be going out with him.</i>\"\n\n");
	outputText("A few dog-morphs in similar armor to Urta approach and lash ropes around the wolf's legs.  They hand a line to a centaur, and together the party begins dragging the unconscious body away.  With the action over, the crowd begins dispersing.  More than a few males nod to Urta respectfully.  She keeps her expression neutral and excuses herself to resume her rounds, wiping her hands off on her armor-studded skirt as she leaves.");
	doNext(telAdreMenu);
}

public function gymDesc():void {
	//PREGGO ALERT!
	if (flags[kFLAGS.PC_IS_A_GOOD_COTTON_DAD] + flags[kFLAGS.PC_IS_A_DEADBEAT_COTTON_DAD] == 0 && cotton.pregnancy.isPregnant) {
		cotton.cottonPregnantAlert();
		return;
	}
	spriteSelect(null);
	clearOutput();
	outputText("Even though Ingnam, your hometown, was a large, prosperous village, you never saw a gym before coming to Tel'Adre.  The structure itself has numerous architectural differences from the surrounding buildings: short, waist-high walls, an arched ceiling supported by simple columns, and a sand-covered floor.  Perhaps the only 'normal' rooms inside are the changing stands and bathrooms, which ");
	if (player.cor < 35) outputText("thankfully ");
	else if (flags[kFLAGS.PC_FETISH] > 0 || player.cor > 80) outputText("unfortunately ");
	outputText("have full sized walls to protect their users' privacy.  A breeze blows by, revealing that the open-air design provides great ventilation.  You note a wall of weights of different sizes and shapes, perfect for building muscle and bulking up.  There are also jogging tracks and even a full-sized, grass-covered track out back for centaurs to run on.  Though some of the equipment seems a bit esoteric in nature, you're sure you can make use of most of this stuff.\n\n");

	outputText("Though the gym sees heavy use by the city guard and various citizens, it's not too busy at present.");
	//(Add possible character descripts here)
	//(An extraordinarily well-muscled centaur male is by the weights, lifting some huge dumbbells and sweating like crazy.  In true centaur fashion, he's not wearing any clothes, but then again, male centaurs don't have much that regular clothes would hide.)
	//(There's a lizan girl jogging laps on one of the tracks.  She's quite thin, but her muscles have a lean definition to them.  She's wearing a one-piece, spandex leotard that hugs her tight ass and pert, b-cup breasts nicely.)
	outputText("  There's a centauress in a tank-top just inside the doorway with huge, rounded melons and perky nipples, but she merely coughs to get you to look up and says, \"<i>");
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("10 gems an hour to use the facilities here, or 500 for a life-time membership.</i>\"  She has her hands on her hips, and it looks you'll have to pay ten gems to actually get to use any of this stuff.");
	else outputText("Oh, welcome back " + player.short + ".  Have a nice workout!</i>\"");

	if (player.gems < 10 && flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		outputText("\n\n<b>You reach into your pockets for the fee and come up empty.  It looks like you don't have enough money to use the equipment or meet anyone.  Damn!</b>");
		//(back to tel'adre streets)
		doNext(telAdreMenu);
		return;
	}
	lottie.lottieAppearance();
	if (flags[kFLAGS.LOPPE_MET] > 0 && flags[kFLAGS.LOPPE_DISABLED] == 0) {
		outputText("\n\nYou spot Loppe the laquine wandering around, towel slung over her shoulder.  When she sees you, she smiles and waves to you and you wave back.");
	}
	if (getGame().time.hours > 9 && getGame().time.hours <= 15) heckel.heckelAppearance();
	gymMenu();
}

private function gymMenu():void {
	menu();
	//Core gym interactions
	addButton(0, "ChangeRoom", jasun.changingRoom);
	addButton(1, "Jog", goJogging);
	addButton(2, "LiftWeights", weightLifting);
	//addButton(3, "Go Swimming", goSwimming);
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0 && player.gems >= 500)
		addButton(4, "Life Member", buyGymLifeTimeMembership).hint("Buy lifetime membership for 500 gems? It could save you gems in the long run.", "Lifetime Membership");
	else if (flags[kFLAGS.LIFETIME_GYM_MEMBER] > 0)
		addButtonDisabled(4, "Life Member", "You already have the lifetime membership. So go ahead and use the facilities.", "Lifetime Membership");
	else
		addButtonDisabled(4, "Life Member", "You cannot afford to purchase the lifetime membership for the gym. You need 500 gems.", "Lifetime Membership");
	//NPCs
	if (flags[kFLAGS.PC_IS_A_DEADBEAT_COTTON_DAD] == 0 && cotton.cottonsIntro()) addButton(5, flags[kFLAGS.COTTON_MET_FUCKED] > 0 ? "Cotton" : "Horsegirl", cotton.cottonGreeting);
	if (getGame().time.hours > 9 && getGame().time.hours <= 15) addButton(6, flags[kFLAGS.MET_HECKEL] > 0 ? "Heckel" : "Hyena", heckel.greetHeckel);
	if (ifris.ifrisIntro()) addButton(7, flags[kFLAGS.MET_IFRIS] > 0 ? "Ifris" : "Demon-Girl", ifris.approachIfris);
	addButton(8, flags[kFLAGS.LOTTIE_ENCOUNTER_COUNTER] > 0 ? "Lottie" : "Pig-Girl", lottie.lottieAppearance(false));
	if (flags[kFLAGS.LOPPE_MET] > 0 && flags[kFLAGS.LOPPE_DISABLED] == 0) addButton(9, "Loppe", loppe.loppeGenericMeetings);
	if (pablo.pabloIntro() && flags[kFLAGS.PABLO_FREAKED_OUT_OVER_WORMS] != 1) addButton(10, flags[kFLAGS.PABLO_MET] > 0 ? "Pablo" : "Imp?", pablo.approachPablo);
	addButton(14, "Leave", telAdreMenu);
}

private function buyGymLifeTimeMembership():void {
	clearOutput();
	//[Buy LifeTime Membership]
	if (silly()) outputText("You tell \"<i>Shut up and take my gems!</i>\" as you pull out your gem-pouch. \n\n"); //Shut up and take my gems!
	outputText("You fish into your pouches and pull out 500 gems, dumping them into the centaur's hands.  Her eyes widen as she turns and trots towards a counter in the back.  She leans over as she counts, giving you a generous view down her low-cut top at the cleavage she barely bothers to conceal.");
	if (player.hasCock()) {
		outputText("  It brings a flush to your face that has nothing to do with exercise.  Maybe you'll be able to con her into some alone time later?");
		dynStats("lus", (10+player.lib/10));
	}
	flags[kFLAGS.LIFETIME_GYM_MEMBER] = 1;
	player.gems -= 500;
	statScreenRefresh();
	//[Bring up gym menu]
	gymMenu();
}

private function weightLifting():void {
	clearOutput();
	//Too tired?  Fuck off.
	if (player.fatigue > player.maxFatigue() - 25) {
		outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ");
		if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("It'd be better to save your money and come back after you've rested.");
		doNext(telAdreMenu);
		return;
	}
	//Deduct gems if not a full member.
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		player.gems -= 10;
		statScreenRefresh();
	}
	//[Lift Weights] +25 fatigue!
	player.changeFatigue(25);
	//TEXTS!
	outputText("You walk up to the weights and begin your workout.  ");
	//(< 25 str)
	if (player.str100 < 25) outputText("You have to start out on the smaller weights to the left side of the rack due to your strength, but even so, you manage to work up a good burn and a modest sweat.");
	//(< 40 str)
	else if (player.str100 < 40) outputText("You heft a few of the weights and select some of the ones just to the left of the middle.  It doesn't take you long to work up a sweat, but you push on through a variety of exercises that leave your body feeling sore and exhausted.");
	//(< 60 str)
	else if (player.str100 < 60) outputText("You smile when you grip a few of the heavier weights on the rack and start to do some lifts.  With a start, you realize you're probably stronger now than Ingnam's master blacksmith, Ben.  Wow!  This realization fuels you to push yourself even harder, and you spend nearly an hour doing various strength-building exercises with the weights.");
	//(<80 str)
	else if (player.str100 < 80) outputText("You confidently grab the heaviest dumbbells in the place and heft them.  It doesn't take long for you to work up a lather of sweat and feel the burn thrumming through your slowly tiring form.  The workout takes about an hour, but you feel you made some good progress today.");
	//(<90)
	else if (player.str100 < 90) outputText("You grab the heaviest weights they have and launch into an exercise routine that leaves you panting from exertion.  Setting the weights aside, you flex and marvel at yourself – you could probably arm wrestle a minotaur or two and come out victorious!");
	//(else)
	else outputText("This place barely has anything left to challenge you, but you take the heaviest weights you can get your mitts on and get to it.  By the time an hour has passed, you've worked up a good sweat, but without heavier weights you probably won't get any stronger.");
	//Stat changes HERE!
	if (player.str100 < 90) dynStats("str", .5);
	if (player.tou100 < 40) dynStats("tou", .3);
	//Body changes here
	//Muscleness boost!
	outputText(player.modTone(85,5+rand(5)));
	promptShowers();
}

private function goJogging():void {
	clearOutput();
	//Too tired?  Fuck off.
	if (player.fatigue > player.maxFatigue() - 30) {
		outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ");
		if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("It'd be better to save your money and come back after you've rested.");
		doNext(telAdreMenu);
		return;
	}
	//Deduct gems if not a full member.
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		player.gems -= 10;
		statScreenRefresh();
	}
	//[Jogging] +30 fatigue!
	player.changeFatigue(30);
	//Text!
	outputText("You hit the jogging track, ");
	//(<25 tou)
	if (player.tou100 < 25) outputText("but you get so winded you have to stop after a few minutes.  Determined to improve, you force yourself to stay at a fast walk until you can run again.");
	//(<40 tou)
	else if (player.tou100 < 40) outputText("but your performance isn't that great.  You nearly stop jogging a few times but manage to push through until you're completely exhausted.");
	//(<60 tou)
	else if (player.tou100 < 60) outputText("and you do quite well.  You jog around for nearly an hour, working up a healthy lather of sweat.  Even your " + player.legs() + " tingle and burn with exhaustion.");
	//(<80 tou)
	else if (player.tou100 < 80) outputText("and it doesn't faze you in the slightest.  You run lap after lap at a decent clip, working yourself until you're soaked with sweat and fairly tired.");
	//(<90 tou)
	else if (player.tou100 < 90) outputText("and you have a terrific time.  You can keep yourself just below your sprinting speed for the entire time, though you work up a huge amount of sweat in the process.");
	//else)
	else outputText("and it barely challenges you.  You run at a sprint half the time and still don't feel like you're improving in the slightest.  Still, you do manage to burn a lot of calories.");
	//Stat changes HERE!
	if (player.spe100 < 40) dynStats("spe", .3);
	if (player.tou100 < 90) dynStats("tou", .5);

	//If butt is over 15 guaranteed reduction
	if (player.butt.rating >= 15) {
		outputText("\n\nAll that running must have done some good, because your " + player.buttDescript() + " feels a little less bouncy.");
		player.butt.rating--;
	}
	else {
		if (player.butt.rating >= 10 && rand(3) == 0) {
			outputText("\n\nThe jogging really helped trim up your " + player.buttDescript() + ".");
			player.butt.rating--;
		}
		else if (player.butt.rating >= 5 && rand(3) == 0) {
			outputText("\n\nYour " + player.buttDescript() + " seems to have gotten a little bit more compact from the work out.");
			player.butt.rating--;
		}
		else if (player.butt.rating > 1 && rand(4) == 0) {
			outputText("\n\nYour " + player.buttDescript() + " seems to have gotten a little bit more compact from the work out.");
			player.butt.rating--;
		}
	}//If hips is over 15 guaranteed reduction
	if (player.hips.rating >= 15) {
		outputText("\n\nIt feels like your " + player.hipDescript() + " have shed some pounds and narrowed.");
		player.hips.rating--;
	}
	else {
		if (player.hips.rating >= 10 && rand(3) == 0) {
			outputText("\n\nIt feels like your " + player.hipDescript() + " have shed some pounds and narrowed.");
			player.hips.rating--;
		}
		else if (player.hips.rating >= 5 && rand(3) == 0) {
			outputText("\n\nIt feels like your " + player.hipDescript() + " have shed some pounds and narrowed.");
			player.hips.rating--;
		}
		else if (player.hips.rating > 1 && rand(4) == 0) {
			outputText("\n\nIt feels like your " + player.hipDescript() + " have shed some pounds and narrowed.");
			player.hips.rating--;
		}
	}

	//Thickness decrease!
	outputText(player.modThickness(1,5+rand(2)));
	//Muscleness boost!
	outputText(player.modTone(100,2+rand(4)));
	promptShowers();
}

private function promptShowers():void {
	outputText("\n\nDo you want to hit the showers before you head back to camp?");
	if (flags[kFLAGS.BROOKE_MET] == 1) {
		menu();
		if (flags[kFLAGS.DISABLED_SEX_MACHINE] == 0) {
			addButton(0,"\"Showers\"",sexMachine.exploreShowers);
			addButton(1,"Showers",brooke.repeatChooseShower);
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}
		else {
			doYesNo(brooke.repeatChooseShower,camp.returnToCampUseOneHour);
		}
	}
	else doYesNo(sexMachine.exploreShowers,camp.returnToCampUseOneHour);
}

}
}
