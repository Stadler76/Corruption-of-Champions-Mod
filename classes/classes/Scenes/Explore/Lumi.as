package classes.Scenes.Explore {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.display.SpriteDb;
	import classes.internals.*;

	public class Lumi extends BaseContent {

	public function Lumi() {}

	public function lumiEncounter():void {
	clearOutput();
	if (flags[kFLAGS.LUMI_MET] == 0) { //1st time lumi meeting
		outputText(images.showImage("event-lumi"));
		//placeholder text for outside the cathedral
		outputText("You spot an anomaly in the barren wastes; a door that seems to be standing out in the middle of nowhere. Somehow, you figure that it must lead to some other part of the world, and the only reason it's here is because you can't get to where the door should be right now.\n\n");
		outputText("Do you open it?");
		doYesNo(lumiLabChoices,camp.returnToCampUseOneHour);
	}
	else {
		//placeholder text for outside the cathedral
		outputText("You spot the door standing in the middle of nowhere again, and you guess that it will lead you back to Lumi's laboratory.  It swings open easily...");
		doNext(lumiLabChoices);
	}	//end of placeholder text
}

public function lumiLabChoices():void {
	spriteSelect(SpriteDb.s_lumi);
	clearOutput();
	if (flags[kFLAGS.LUMI_MET] == 0) { //First time meeting
		flags[kFLAGS.LUMI_MET]++; //set Lumi met flag
		outputText(images.showImage("encounter-lumi"));
		outputText("You open the door and carefully check inside for any enemies that may be trying to ambush you. The room seems to be some kind of alchemical lab, with shelves full of apparatuses all along the walls, a desk on one side of the room, and a long table across the room from you that is full of alchemical experiments in progress, many give off lots of smoke, and others are bottles of bubbling fluids.  A goblin wearing an apron and some kind of headband is sitting on a tall, wheeled stool; she is otherwise nude and seems to be watching at least 3 experiments right now. She suddenly turns around and looks straight in your direction.  It's hard to tell thanks to the dark goggles that hide her eyes from view, but you're fairly certain she's watching you.  After a few seconds she yells \"<i>Cuths-tohmer!</i>\" in a thick lisp. She looks harmless enough, so you step inside while she fiddles with her experiments, reducing the bubbling smoke.  She jumps down from her stool, tears off her apron, bounds over to the desk, and scrambles on top of it.\n\n");
		outputText("She's about 3 feet tall, with yellow-green skin, and wears her orange hair in a long ponytail that reaches to her knees.  Her breasts are about B cup, with average nipples that have been colored orange. All of her nails have been painted orange to match. She doesn't seem to ever stop moving, and while the majority of her face looks cute, it's a little hard to be sure while she's wearing those thick goggles.  The solid black lenses of her goggles make her look quite unsettling, stifling any appeal her form could inspire in you.\n\n");
		outputText("\"<i>Stho, what can Lumi, Gobin Aochomist Extwaordinaire, do fo you today?</i>\" asks the unusual goblin.\n\n");
		outputText("You explain that it's a little hard to understand her.  She sticks her tongue out at you, showing a VERY large stud in the middle of it, instantly explaining her lisp.  Rather than pushing the point, you ask her what she can do for you.  She pulls open a hatch on the top of the desk and pulls out a bottle of something and shakes it, \"<i>Lumi can sell you some of her finely cwafted poetions fo a good pwice, ore, if you've alweady got some nice poetions or reagents, Lumi can make them even bettar. But tha cost a whole lot. If you were one of dee Followers, den maybe Lumi could make a special deal wit you; but the boss don't want me playin wit outsiders. Wat will it be?</i>\"\n\n");
	}
	else { //Repeat Meetings
		outputText(images.showImage("encounter-lumi-repeat"));
		outputText("Once more, you step into Lumi's lab.  She's still working on her experiments. Before you even have a chance to call out to her, she has already pivoted to watch you.  In a flash her apron hits the floor and she is standing on her desk, asking, \"<i>Stho, what can Lumi the Aochomist Extwaordinaire do fo you today?</i>\"");
	}
	menu();
	addButton(0, "Shop", lumiShop);
	addButton(1, "Enhance", lumiEnhance);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
}

public function lumiShop():void { //Set item handling to lumi shop
	spriteSelect(SpriteDb.s_lumi);
	clearOutput();
	outputText("You ask Lumi if you can see her potions.  She smiles at you and pulls out several bottles from her desk and shows them to you.\n\n\"<i>Gawantied qwality, made by Lumi herself,</i>\" she says proudly.\n\n");
	outputText("Lust Draft - 15 gems\nGoblin Ale - 20 gems\nOviposition Elixir - 45 gems\n");
	//The player is given a list of choices, clicking on one gives the description and the price, like Giacomo
	menu();
	if (player.gems >= 15)
		 addButton(0, consumables.L_DRAFT.shortName, lumiLustDraftPitch);
	else addDisabledButton(0, consumables.L_DRAFT.shortName);
	if (player.gems >= 20)
		 addButton(1, consumables.GOB_ALE.shortName, lumiPitchGobboAle);
	else addDisabledButton(1, consumables.GOB_ALE.shortName);
	if (player.gems >= 45)
		 addButton(2, consumables.OVIELIX.shortName, lumiPitchOviElixer);
	else addDisabledButton(2, consumables.OVIELIX.shortName);
	addButton(14, "Back", lumiLabChoices);
}
//Lust Draft
private function lumiLustDraftPitch():void {
	spriteSelect(SpriteDb.s_lumi);
	clearOutput();
	outputText(images.showImage("item-draft-lust"));
	outputText("You point at the bottle filled with bubble-gum pink fluid.\n\n\"<i>De lust dwaft? Always a favowite, with it you nevar have to worwy about not bein weady for sexy time; one of my fiwst creations. 15 gems each.</i>\"\n\n");
	outputText("Will you buy the lust draft?");
	menu();
	addButton(0, "Yes", curry(lumiPurchase, consumables.L_DRAFT, 15));
	addButton(1, "No", lumiShop);
}
//Goblin Ale
private function lumiPitchGobboAle():void {
	spriteSelect(SpriteDb.s_lumi);
	clearOutput();
	outputText(images.showImage("item-gAle"));
	outputText("You point at the flagon. \"<i>Oh? Oh thats Lumi's... actually no, dat tispsy stuff for 20 gems. You'll like if you want to be like Lumi. Do you like it?</i>\"\n\n");
	outputText("Will you buy the goblin ale?");
	menu();
	addButton(0, "Yes", curry(lumiPurchase, consumables.GOB_ALE, 20));
	addButton(1, "No", lumiShop);
}
//Ovi Elixir
private function lumiPitchOviElixer():void {
	spriteSelect(SpriteDb.s_lumi);
	clearOutput();
	outputText(images.showImage("item-oElixir"));
	outputText("You point at the curious hexagonal bottle. \"<i>De Oviposar Elixir? Made baithsed on da giant bee's special stuff dey give deir queen. It will help make de burfing go faster, an if you dwink it while you awen pweggy, iw will give you some eggs to burf later. More dwinks, eqwals more and biggar eggs. Lumi charges 45 gems for each dose.</i>\"\n\n");
	outputText("Will you buy the Ovi Elixir?");
	menu();
	addButton(0, "Yes", curry(lumiPurchase, consumables.OVIELIX, 45));
	addButton(1, "No", lumiShop);
}

private function lumiPurchase(itype:ItemType, cost:int):void { //After choosing, and PC has enough gems
	spriteSelect(SpriteDb.s_lumi);
	clearOutput();
	outputText("You pay Lumi the gems, and she hands you " + itype.longName + " saying, \"<i>Here ya go!</i>\"\n\n");
	player.gems -= cost;
	statScreenRefresh();
	if (flags[kFLAGS.SHIFT_KEY_DOWN] == 1 && itype is Consumable) {
		(itype as Consumable).useItem();
		doNext(lumiLabChoices);
	}
	else inventory.takeItem(itype, lumiLabChoices);
}

public function lumiEnhance():void {
	spriteSelect(SpriteDb.s_lumi);
	clearOutput();
	outputText("\"<i>Yay! Lumi loves to do enhancement, what you want to be bettar?</i>\"");
	menu();
	var btn:int = 0;
	if (player.hasItem(consumables.FOXBERY))
		 addButton(btn++, consumables.FOXBERY.shortName, lumiEnhanceGo, consumables.FOXBERY, undefined, undefined);
	else addDisabledButton(btn++, consumables.FOXBERY.shortName);
	if (player.hasItem(consumables.FOXJEWL))
		 addButton(btn++, consumables.FOXJEWL.shortName, lumiEnhanceGo, consumables.FOXJEWL, undefined, undefined);
	else addDisabledButton(btn++, consumables.FOXJEWL.shortName);
	if (player.hasItem(consumables.GLDSEED))
		 addButton(btn++, consumables.GLDSEED.shortName, lumiEnhanceGo, consumables.GLDSEED, undefined, undefined);
	else addDisabledButton(btn++, consumables.GLDSEED.shortName);
	if (player.hasItem(consumables.KANGAFT))
		 addButton(btn++, consumables.KANGAFT.shortName, lumiEnhanceGo, consumables.KANGAFT, undefined, undefined);
	else addDisabledButton(btn++, consumables.KANGAFT.shortName);
	if (player.hasItem(consumables.L_DRAFT))
		 addButton(btn++, consumables.L_DRAFT.shortName, lumiEnhanceGo, consumables.L_DRAFT, undefined, undefined);
	else addDisabledButton(btn++, consumables.L_DRAFT.shortName);
	if (player.hasItem(consumables.LABOVA_))
		 addButton(btn++, consumables.LABOVA_.shortName, lumiEnhanceGo, consumables.LABOVA_, undefined, undefined);
	else addDisabledButton(btn++, consumables.LABOVA_.shortName);
	if (player.hasItem(consumables.OVIELIX))
		 addButton(btn++, consumables.OVIELIX.shortName, lumiEnhanceGo, consumables.OVIELIX, undefined, undefined);
	else addDisabledButton(btn++, consumables.OVIELIX.shortName);
	if (player.hasItem(consumables.SDELITE))
		 addButton(btn++, consumables.SDELITE.shortName, lumiEnhanceGo, consumables.SDELITE, undefined, undefined);
	else addDisabledButton(btn++, consumables.SDELITE.shortName);
	if (player.hasItem(consumables.PIGTRUF))
		 addButton(btn++, consumables.PIGTRUF.shortName, lumiEnhanceGo, consumables.PIGTRUF, undefined, undefined);
	else addDisabledButton(btn++, consumables.PIGTRUF.shortName);
	if (player.hasItem(consumables.PURHONY))
		 addButton(btn++, consumables.PURHONY.shortName, lumiEnhanceGo, consumables.PURHONY, undefined, undefined);
	else addDisabledButton(btn++, consumables.PURHONY.shortName);
	addButton(14, "Back", lumiLabChoices);
}

private function lumiEnhanceGo(itype:ItemType):void {
	spriteSelect(SpriteDb.s_lumi);
	if (player.gems < 100) { //if player has less than 100 gems
		outputText("\"<i>Do you have 100 gems for de enhancement?</i>\" asks Lumi.\n\nYou shake your head no, and Lumi gives you a disappointed look and says, \"<i>Den Lumi can do no enhancement for you. Anyfing else?</i>\"\n\n");
		doNext(lumiLabChoices); //return to main Lumi menu
		return;
	}
	var nextItem:ItemType = ItemType.NOTHING;
	if 		(itype == consumables.LABOVA_) nextItem = consumables.PROBOVA;
	else if (itype == consumables.KANGAFT) nextItem = consumables.MGHTYVG;
	else if (itype == consumables.SDELITE) nextItem = consumables.S_DREAM;
	else if (itype == consumables.OVIELIX) nextItem = consumables.OVI_MAX;
	else if (itype == consumables.L_DRAFT) nextItem = consumables.F_DRAFT;
	else if (itype == consumables.GLDSEED) nextItem = consumables.MAGSEED;
	else if (itype == consumables.FOXBERY) nextItem = consumables.VIXVIGR;
	else if (itype == consumables.FOXJEWL) nextItem = consumables.MYSTJWL;
	else if (itype == consumables.PIGTRUF) nextItem = consumables.BOARTRU;
	else if (itype == consumables.PURHONY) nextItem = consumables.SPHONEY;
	player.gems -= 100;
	statScreenRefresh();
	player.consumeItem(itype);
	clearOutput();
	outputText("Lumi grabs the item from you and runs over to her table, stopping for only a second to put her apron on.  ");
	//start list of possible enhancement texts
	temp = rand(3);
	if (itype == consumables.GLDSEED) outputText("She fiddles with it, coating it in exotic powders before she tosses the whole mess onto a hotplate.  It explodes, knocking the goblin flat on her ass.  She sits bolt upright and snatches up the now-glowing seed with a gloved hand.\n\n");
	else if (itype == consumables.FOXJEWL) outputText("Lumi stares wide-eyed into the fathoms of its depths.  She remains like that for several moments before you clear your throat, and then hurries off to work.  Flitting back and forth between the various beakers and test tubes that litter the workshop, she mixes chemicals seemingly at random, many of which bubble or explode rather violently.\n\nAfter several minutes of this, she pours all of the reagents into a large beaker over an open flame.  The contents boil up through the neck of the flask and drip slowly down the condenser.  A ponderously large drop of black liquid builds up at the tip of the condenser, wobbling precipitously for a moment before finally falling onto the jewel with a splash.\n\nThe jewel soaks up the black fluid like a sponge, veins of sickening purple spreading across the surface like a spider's web.  A few moments later, the jewel is entirely purple, the mystic flames inside glowing a bright violet.\n\nYou reach out hesitantly and place the mystically enhanced teardrop-shaped jewel into your pouch.\n\n");
	else if (itype == consumables.KANGAFT) outputText("She fiddles with it, coating it in exotic powders before she tosses the whole mess onto a hotplate.  It explodes, knocking the goblin flat on her ass.  She sits bolt upright and snatches up the now-glowing fruit with a gloved hand.\n\n");
	else if (temp == 0) outputText("She starts grabbing things from around the table, seemingly at random, and adds them to " + itype.longName + ".  To your alarm, there is soon a large cloud of smoke coming off it! There is a strong smell to the smoke and it makes it hard to breathe.  Lumi grabs a mask out of a drawer and puts it on, continuing with her work unperturbed.  She suddenly stops and you wonder if she is done, but she takes off her mask and inhales deeply of the smoke, then keels over!  As you go over to help her she suddenly stands up, waves away some of the smoke, and says, \"<i>All dun!</i>\"\n\n");
	else if (temp == 1) outputText("Taking hold of one of the bottles that were sitting where she put the tray, she seems to think for a moment before tossing the bottle into one of the corners of the room.  It shatters just behind the table, and a small puff of smoke goes up into the air.  You're a little nervous about that bottle, but before you have a chance to say anything, two more bottles fly off and join it; this time causing a small explosion. You ask her what she is thinking tossing those aside, and she simply responds, \"<i>Dey were in my way.</i>\"\n\n\"<i>What?!  So you just toss things that explode to the side?</i>\"\n\n<i>\"Don worry, I'll put counter agents in dere at de end of de day.  An I never throw stuff da'll do any damage.  Done!</i>\"\n\n");
	else if (temp == 2) outputText("She adds a few things to the tray before moving down the table.  She adds some reagents to a bubbling chemical reaction, and then adds some more ingredients to that.  You wonder why she just left " + itype.longName + " there to work on something else.  Then Lumi moves back across the table, past where " + itype.longName + " sits, to start adding things to something else.  Before you have a chance to complain, she moves back to " + itype.longName + " and continues.  You decide that it's probably best not to ask about her work ethic and just let her do her thing; she has more experience than you, after all.\n\nPOP! You look over in surprise as the first thing she worked on makes a small explosion.  POW! Now the second experiment has blown up!  You start to move in alarm, wondering if Lumi really knows what she's doing; just before " + itype.longName + " seems to explode with an incredible BOOM.  Lumi stops moving for a moment, looking straight ahead before saying, \"<i>Dat was a gud one, Lumi dun!</i>\"\n\n");
	inventory.takeItem(nextItem, lumiEnhance, lumiLabChoices);
}
}
}
