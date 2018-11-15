package classes.Scenes.Places.Bazaar 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.PerkLib;

	public class GretasGarments extends BazaarAbstractContent 
	{
		public function GretasGarments() {
			//No parameters here...
		}
		
		private var cockSockDb:Array = [
			["Wool",      "wool",       10, "Just an ordinary woolen cock-sock. All it does is keep your cock nice and warm.",
				"You spy a thick, woolen sock sitting on a counter and take it up to Greta. \"<i>Ah, yes. That's our basic sock. Warm and cozy, great for those chilly nights. That one's a mere 10 gems. A steal, of course.</i>\""],
			["Cockring",  "cockring",  100, "This black latex cock-sock is said to help keep your arousal running.",
				"You pick up one sock, surprised to find how heavy it is. Large metal rings encircle the base of the smooth cock-sock, with one loose ring dangling down, no doubt intending to wrap around the base of your ball sack. \"<i>Oh yes, that's a fun one. Those rings will constantly constrict your manhood, so you'll always be hard and ready to go.</i>\" She giggles and waves a hand, \"<i>That's actually a very popular sock... so many demons come in to get these for their harems. It's 100 gems.</i>\""],
			["Alabaster", "alabaster",  25, "This white cock-sock supposedly would help to improve the cleansing effects.",
				"This white cock-sock supposedly would help to improve the cleansing effects."],
			["Viridian",  "viridian", 1000, "This rich green cock-sock supposedly makes you feel healthier over time.",
				"You pick up one sock and inspect it. The whole thing is a rich, natural green color and completely lace, accentuated with vivid red roses. Just touching it makes you feel healthier and more alive. \"<i>Ahh, that's a fun one right there. It hastens your natural healing. Very useful, and pretty, too, if I say so myself. It's 1,000 gems.</i>\" You pale at the price, but Greta waves a hand, \"<i>Trust me, honey, it's worth it.</i>\""],
			["Scarlet",   "scarlet",   250, "This plush red cock-sock looks smaller. Supposedly would make your endowment grow easier.",
				"You pick up one sock and inspect it. It's an incredible plush red, and made of soft satin and detailed with red lace. It seems smaller than the other socks you've seen, and you can't help but wonder how tight it will feel on your dick. \"<i>Mmm, that one's special. It increases the blood flow to your little dick, enabling it to grow a lot faster. This one goes quick. Everyone wants to be a minotaur! It's 250 gems.</i>\""],
			["Cobalt",    "cobalt",    250, "This soft blue cock-sock looks extremely small. Supposedly this would inhibit your endowment growth.",
				"You pick up one sock and inspect it. It's a cool, soft blue color, made from satin and detailed in light blue lace. It seems extremely small, compared to the other socks in the shop, and you can't help but think it must be extremely uncomfortable to wear. \"<i>Oho, that's a fun one right there. The cute little femboys go crazy for it. As you can see, it's a bit small, and it will actually inhibit your cock from growing too big. It's 250 gems.</i>\""],
			["Purple", "amaranthine", 1000, "This smooth lavish purple cock-sock seems like an oddity with its unusual shape.",
				"You pick up one sock and inspect it. It's a silky smooth lavish purple color, with fine lace depicting some kind of six-legged wolf-like creature. Overall, though, the sock is an odd shape, seemingly intended for someone with a knot AND some kind of equine-like flare. Greta's eyebrows raise as she sees the item you're holding, \"<i>Ohh, that one. That, honey, was an experiment. I took some magic channeled down from the stars themselves and infused it into a new sock, and that was the result. Truth be told, I'm not entirely sure what it does, but I'll sell it to you for 1,000 gems.</i>\""],
			["Gilded",    "gilded",   3000, "An extremely expensive-looking cock-sock with intricate decorations.",
				"You pick up one sock and inspect it, surprised to see how rigid and heavy it is. Unlike the others in the shop, this one seems to be made of a cool golden metallic material. Glittering gems are embedded into the top side, while the bottom is cinched closed with leather cords. \"<i>You've got a good eye,</i>\" Greta says, her eyes twinkling greedily. \"<i>With that bad boy, you can actually convert some of your... sweet cum into even sweeter gems. Of course, with that kind of awesome power, you've got to understand that it'll cost you 3,000 gems.</i>\""],
			["Mtl. Green", "green",    500, "This metallic green cock-sock supposedly looks like it'll bolster your HP from the look of the label.",
				"You pick up one sock and inspect it. It's dark, metallic green in color and interlaced with brighter green highlights. Greta's eyebrows raise as she sees the item you're holding, \"<i>Ohh, that one.  It's one of my newest lineup of cock-socks. If you're unsure of your endurance, this might help as the magic bolsters your overall health capacity. I'll sell it to you for 500 gems.</i>\""],
			["Mtl. Red",  "red",       500, "This metallic red cock-sock supposedly looks like it'll improve your physical prowess from the look of the label.",
				"You pick up one sock and inspect it. It's dark, metallic red in color and interlaced with brighter red highlights. Overall, it looks a bit menacing. Greta's eyebrows raise as she sees the item you're holding, \"<i>Ohh, that one. It's one of my newest lineup of cock-socks. This cock-sock will enhance your power so you can physically beat tougher opponents. I'll sell it to you for 500 gems.</i>\""],
			["Mtl. Blue", "blue",      500, "This metallic blue cock-sock supposedly looks like it'll magnify your spellpower from the look of the label.",
				"You pick up one sock and inspect it. It's dark, metallic blue in color and interlaced with brighter blue highlights that seems to glow in the dark. Greta's eyebrows raise as she sees the item you're holding, \"<i>Ohh, that one.  It's one of my newest lineup of cock-socks. This cock-sock will enhance your spellpower. I'll sell it to you for 500 gems.</i>\""]
		]
		
		//"Greta's Garments" - Interior
		public function gretasGarments():void {
			clearOutput();
			if (flags[kFLAGS.FOUND_SOCKS] == 1 && flags[kFLAGS.SOCK_COUNTER] == 0) {
				outputText("As you enter the store, you're surprised to see that a variety of products line the shelves. Clothing of various materials, sizes and shapes lay folded on shelves and tables around the little shop. A lone, surprisingly anatomically correct mannequin stands by the counter nude except for a thin lacy piece of fabric held taut over its wooden penis.");
				outputText("\n\nThe demoness, Greta, spies you looking at the strange piece of clothing. \"<i>Aha, you're back!</i>\" she says, throwing her arms wide, which has the unintentional but not unappreciated effect of making her enormous boobs jiggle. \"<i>As you can see, I'm back in full production. I finally got that pesky backlog taken care of... although this one shy customer, a quiet browser, if you will, keeps me on my toes with new orders. I swear he and his partner will be the death of me!</i>\"");
				outputText("\n\nThe pink-skinned succubus clicks her tongue disapprovingly for a moment before turning her gaze back to you. \"<i>Anyway, I've now got a full stock of delicious cock-socks for purchase. Please, do look around and let me know if you find anything... suitable,</i>\" she giggles and turns her attention back to knitting.");
				unlockCodexEntry("Succubus", kFLAGS.CODEX_ENTRY_SUCCUBUS);
				menu();
				addButton(0,"Next",gretasGarments);
				flags[kFLAGS.FOUND_SOCKS] = 2;
				return;
			}
			if (flags[kFLAGS.FOUND_SOCKS] < 2) {
				outputText("The interior of Greta's Garments is surprisingly bare. It's literally an empty wagon with a crude bench, a strongbox, a few looms of cloth, and some sewing tools. However, that's not to say that the shop is empty. Reclining behind the counter is a pink-skinned succubus, busy knitting what looks like a sock. Even with her slouching posture, you can see that her breasts are truly tremendous - mountainous mammaries that she actually rests her arms on while she knits. She's completely nude, save for two thin black squares that stretch over her taut nipples (concealing absolutely nothing) and a soaked triangle that's even now threatening to disappear into her gushing crevice forever.");
				outputText("\n\nNoticing your gaze, she sits up a little straighter and swivels on some kind of rotating chair to face you more directly. Her jiggling breasts slowly bounce to a stop on the counter before her as she asks, \"<i>Can I interest you in something, honey?</i>\"");
				unlockCodexEntry("Succubus", kFLAGS.CODEX_ENTRY_SUCCUBUS);
				outputText("\n\nThere doesn't seem to be anything for sale that you can see");
				if (flags[kFLAGS.OWN_MAIDEN_BIKINI] == 0) outputText(", except maybe a super-skimpy chain bikini that's chased with white and gold highlights");
				if (flags[kFLAGS.FOUND_SOCKS] == 0) flags[kFLAGS.FOUND_SOCKS] = 0.5; //For tooltip tracking
			}
			else {
				outputText("The interior of Greta's Garments is surprisingly colorful. Though it started off as an empty wagon filled with loose bolts of cloth and sewing tools, vivid fabrics now cover all the shelves. Curtains hang from the walls in every color of the rainbow, and a single wooden mannequin stands near the counter, its surprisingly anatomically correct cock covered in a thin, lacey cock-sock. Sitting nearby, behind the counter, is a pink-skinned succubus, busy knitting what looks like another such sock. Even with her slouching posture, you can see that her breasts are truly tremendous - mountainous mammaries that she actually rests her arms on while she knits. She's completely nude, save for two thin black squares that stretch over her taut nipples (concealing absolutely nothing) and a soaked triangle that's even now threatening to disappear into her gushing crevice forever.");
				outputText("\n\nNoticing your gaze, she sits up a little straighter and swivels on some kind of rotating chair to face you more directly. Her jiggling breasts slowly bounce to a stop on the counter before her as she asks, \"<i>Can I interest you in something, honey?</i>\"");
				unlockCodexEntry("Succubus", kFLAGS.CODEX_ENTRY_SUCCUBUS);
				outputText("\n\nThere doesn't seem to be anything aside from cock-socks here");
				if (flags[kFLAGS.OWN_MAIDEN_BIKINI] == 0) outputText(", except maybe a super-skimpy chain bikini that's chased with white and gold highlights");
			}
			outputText(".");
			dynStats("lus", 2, "scale", false);
			menu();
			if (flags[kFLAGS.FOUND_SOCKS] < 1) addButton(4, "Low Stock", askGretaAboutInventory).hint("The shop is indeed empty and devoid of any merchandise! Ask the succubus why the shop seems so bare.");
			else {
				if (flags[kFLAGS.FOUND_SOCKS] == 2 && player.cocks.length > 0 && player.hasSockRoom()) addButton(1, "Browse Socks", browseDemSocksSon).hint("Check out the cock-socks currently available in stock.");
				if (player.hasSock()) addButton(2, "Remove Sock", takeOffDatSock).hint("Ask Greta about removing a sock from your cock.");
			}
			if (flags[kFLAGS.OWN_MAIDEN_BIKINI] == 0) addButton(0, "Bikini", askGretaAboutZeBikini).hint("Ask about the unusual chain bikini and see if it's for sale.");
			addButton(14,"Back",bazaar.enterTheBazaarAndMenu);
			
		}
		//Ask About Inventory
		private function askGretaAboutInventory():void {
			clearOutput();
			outputText("Curious about the lack of selection, you broach the topic with the slutty shopkeeper, asking just where the items she has for sale are at.");
			outputText("\n\nThe demoness, who must be Greta, laughs, \"<i>Oh, it's sweet of you to ask, but I just got set up here. You wouldn't know how hard it is not to go around taming every sweet little boner on display out there, but there's something to be said for earning profit with your own sweat, effort, and charm.</i>\" She presses her hands against the sides of her chest and turns her tremendous cleavage into a canyon of mammary delight.");
			outputText("\n\n\"<i>See something you like?</i>\" Greta asks, drawing your dazed eyes back up to her face. \"<i>Well it isn't on the menu today, though you do look like a scrumptious little morsel if I do say so myself. I've got a lot of work to do if I'm going to keep up with all the demand for my products!</i>\"");
			outputText("\n\nYou look around the store and inquire about what products she could possible mean. Greta holds up the sock she was knitting and says, \"<i>These! I can't make them fast enough! Every time I get one done, some cute hermaphrodite or wide-hipped femboy is in here buying it up.</i>\"");
			outputText("\n\nYou ask, \"<i>Socks?</i>\" with confusion showing on your face. What use do herms and girly-boys have for weird socks? This shop seemed like it would specialize in sexy, not everyday garb!");
			outputText("\n\nGreta laughs so hard that her tits quake, scattering her knitting needles away. Her tail deftly catches one that rolls off the crude counter's edge, twirling it about before stuffing it into the tight bob she has atop her head. \"<i>You think this is a sock!? Ahahahahah! No, dear " + player.mf("boy","girl") + ", this isn't an ordinary sock. It's a cock-sock. See the pattern here? And the specially sewn gaps? They let the wearer accentuate every sweet curve and throbbing vein on their erection, all while exposing the most sensitive bits for busy hands and hungry tongues, like mine.</i>\" She lets her tongue slowly extend out from her mouth, inch after inch of the wiggling, slick organ slowly disappearing into the valley between her tits. She slowly retracts it with a giggle.");
			outputText("\n\n\"<i>I've got back-orders on these things for miles, so you'll have to wait for me to get caught up before I consider crafting any for you.</i>\"");
			//[Back]
			if (flags[kFLAGS.FOUND_SOCKS] == 0) flags[kFLAGS.FOUND_SOCKS] = 1;
			if (flags[kFLAGS.SOCK_COUNTER] == 0) flags[kFLAGS.SOCK_COUNTER] = 24;
			menu();
			addButton(4,"Back",gretasGarments);
		}

		//Ask About Bikini:
		private function askGretaAboutZeBikini():void {
			clearOutput();
			outputText("\"<i>Oh, that?</i>\" Greta asks. \"<i>That's an old project of mine. Some slutty bitch that called herself a pure maiden used to wear it, right up until I got her to forsake her vows, grow a dick, and fuck me until she was addicted to the taste of my cunt and the flavor of my milk. From what I heard, she came from a place where similarly attired warriors battled to become Queen of some silly country. Anyway, that gear had some powerful magics on it that pain my kind to handle. I've been trying to corrupt it into something more fun in my spare time, but it just hasn't been going well.</i>\"");
			outputText("\n\nThe succubi sets down a half-sewn sock and grumbles, \"<i>Do you have any idea how hard it is to unweave a ward while simultaneously infusing it with corruption?</i>\"");
			outputText("\n\nYou shrug.");
			outputText("\n\nGreta blows a lock of inky black hair out of her face and muses, \"<i>I guess not, huh? Well, I got about halfway done with it - it won't burn you if you've got a lot of corruption in you, but I can't quite easily handle it yet. From what my pet tells me, it's actually stronger when worn by a virgin, but it may, umm... induce some baser urges thanks to my meddling. I suppose if you want it, you can have it for 500 gems. Rent on this heap is coming up, after all.</i>\"");
			//[Buy It] [Back]
			menu();
			if (player.gems < 500) outputText("\n\n<b>You can't afford it.</b>");
			else addButton(0, "Buy Bikini", buyGretasBikini).hint(armors.LMARMOR.description, armors.LMARMOR.longName);
			addButton(4,"Back",gretasGarments);
		}

		//Buy Bikini
		private function buyGretasBikini():void {
			clearOutput();
			flags[kFLAGS.OWN_MAIDEN_BIKINI] = 1;
			player.gems -= 500;
			statScreenRefresh();
			outputText("Greta's eyes widen in surprise. \"<i>Really?</i>\"");
			outputText("\n\nYou nod and pull out your gems, counting out the exact amount for her. As soon as you finish, Greta pulls you over the counter and kisses you on the lips, her tongue sensually assaulting your surprised palate. Before you can react, she pulls back with a hum of pleasure.");
			outputText("\n\n\"<i>Thanks, sugar! Have fun and be safe, and if you don't want to be safe, come visit me sometime!</i>\"");
			outputText("\n\nYou'll have to keep that in mind... ");
			inventory.takeItem(armors.LMARMOR, camp.returnToCampUseOneHour);
		}

		//Cock-socks Available - First Time
		private function browseDemSocksSon():void {
			clearOutput();
			outputText("What type of cock-sock do you want to look at?");
			//Cock-sock Menu
			menu();
			for (var i:int = 0; i < cockSockDb.length; i++) {
				addButton(i, cockSockDb[i][0], chooseCockSock, cockSockDb[i]).hint(cockSockDb[i][3]);
			}
			addButton(14,"Back", gretasGarments);
		}

		private function chooseCockSock(selection:Array):void {
			clearOutput();
			var price:int = selection[2];
			outputText(selection[4]);
			flags[kFLAGS.SOCK_HOLDING] = selection[1];
			cockSelectionMenu(price);
		}

		private function cockSelectionMenu(price:int):void {
			menu();
			if (player.gems >= price) addButton(0, "Buy", pickACockForSock, price);
			else outputText("\n\n<b>You can't afford that.</b>");
			addButton(4, "Back", browseDemSocksSon);
		}

		private function pickACockForSock(price:int = 0):void {
			//Buy Cock-sock
			clearOutput();
			outputText("You take the cock-sock over to the counter where Greta sits, knitting even more garments and place down the gems required. \"<i>Aha, good choice, honey!</i>\" the succubus says, snatching up the money and stashing it away. \"<i>Now let's get that bad boy fitted on you.</i>\"");
			
			//[If PC only has one cock, jump immediately to Putting It On, else: 
			if (player.cockTotal() == 1) {
				menu();
				addButton(0,"Next",cockSockTarget,0);
			}
			else {
				outputText("\n\nWhich cock would you like to put it on?");
				temp = 0;
				var button:int = 0;
				menu();
				while(button < player.cockTotal()) {
					if (player.cocks[button].sock == "") addButton(button, String(button + 1), cockSockTarget, button, price);
					button++;
				}
			}
		}

		private function cockSockTarget(target:int, price:int = 0):void {
			clearOutput();
			flags[kFLAGS.SOCKS_BOUGHT]++;
			//Putting it On - First Time
			if (flags[kFLAGS.SOCKS_BOUGHT] == 1) {
				outputText("The gravity-defying succubus gestures towards your crotch. \"<i>Well, come on then, let's see the tasty cock getting all dressed up,</i>\" she says, her voice becoming a deep purr. You raise your eyebrow, questioning why she needs to see that.");
				outputText("\n\n\"<i>Oh, don't you know? These aren't your ordinary garments,</i>\" she cackles lightly. \"<i>These are quite special cock-socks. They won't slip or slide. No matter what, they'll remain in place until you want me to take it off.</i>\"");
				outputText("\n\nYou balk a little. These things are going to be permanently attached to you?");
				outputText("\n\nSeeing your reaction, Greta calmly explains, \"<i>Don't worry, it's just a simple little spell. You can still use your dick, cum and all that delicious fun stuff. This spell will just prevent it from slipping off no matter if you're limp or hard, and it will keep the material clean and repaired. Before I learned this spell, you wouldn't <b>believe</b> how many socks I had to wash and stitch back together. I had no time to make new ones!</i>\"");
				outputText("\n\nYou gulp. Do you want this cock-sock attached to your penis semi-permanently?");
			}
			//Putting It On - Additional Times
			else {
				outputText("Greta motions with her hand, a movement that causes her mountainous cleavage to jiggle hypnotically. \"<i>Well, come on then, let's see the tasty cock getting all dressed up,</i>\" she says, her voice becoming a deep purr.");
				outputText("\n\nWell? Do you want this cock-sock attached to your penis semi-permanently?");
			}
			menu();
			addButton(0, "Yes", yesPutDatSockOnMe, target, price);
			addButton(1, "No", noCockSock);
		}

		//Yes
		private function yesPutDatSockOnMe(target:int, price:int = 0):void {
			clearOutput();
			var conflict:Boolean = false;
			
			switch(flags[kFLAGS.SOCK_HOLDING]) {
				case "cockring":
					if (player.findPerk(PerkLib.PentUp) < 0) player.createPerk(PerkLib.PentUp, 10, 0, 0, 0);
					else player.addPerkValue(PerkLib.PentUp, 1, 5);
					break;
				case "viridian":
					if (player.findPerk(PerkLib.LustyRegeneration) < 0) {
						player.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0);
					}
					else {
						conflict = true;
					}
					break;
				case "scarlet":
					if (player.findPerk(PerkLib.PhallicPotential) < 0) {
						player.createPerk(PerkLib.PhallicPotential, 0, 0, 0, 0);
					}
					break;
				case "cobalt":
					if (player.findPerk(PerkLib.PhallicRestraint) < 0) {
						player.createPerk(PerkLib.PhallicRestraint, 0, 0, 0, 0);
					}
					break;
				case "gilded":
					if (player.findPerk(PerkLib.PentUp) < 0) player.createPerk(PerkLib.MidasCock, 5, 0, 0, 0);
					else player.addPerkValue(PerkLib.MidasCock, 1, 5);
					break;
				default:
					//Nothing here...
			}
			player.gems -= price;
			outputText("You nod to the busty succubus and strip off your [armor], revealing your naked body. Greta's eyes light up as she looks over your body with barely-contained lust. Finally her eyes settle onto your " + player.cockDescript(target) + ", and she licks her lips. ");
			if (!conflict) { // There's no conflict. DO IT!!!
				player.cocks[target].sock = flags[kFLAGS.SOCK_HOLDING];
				statScreenRefresh();
				outputText("With one hand she lifts your limp cock up, giving it a pleasant little stroke.");
				outputText("\n\nHer other hand approaches, her thumb, fore- and middle-fingers holding the sock open as she slips it over your " + player.cockHead(target) + ". She pulls it snugly into place and then gives your penis a little kiss. The second her lips make contact with your flesh, a chill runs across your body, followed by a flood of warmth.");
				outputText("\n\nGreta smiles knowingly and returns to her chair behind the counter.");
				//(Cock-sock get! +2 Corruption, +5 Arousal)
				dynStats("lus", 5, "cor", 2);
				menu();
				addButton(0,"Next",gretasGarments);
			}
			else { // Conflict! NOOOOO! Pull up! Pull up!
				outputText("Then she suddenly stops, staring at your groin.\n\n\"<i>Oh, dear...</i>\" she says, \"<i>As much as I would love to take your money honey, I can't be mixing magics like that.</i>\"")
				menu();
				addButton(0,"Next",gretasGarments);
			}
		}

		private function noCockSock():void {
			clearOutput();
			flags[kFLAGS.SOCK_HOLDING] = 0;
			outputText("You shake your head. Greta sighs, \"<i>Figures. Here's your money back, honey. Come back when you change your mind.</i>\"");
			//(Back to menu)
			menu();
			addButton(0,"Next",gretasGarments);
		}

		//Remove Cock-sock
		private function takeOffDatSock():void {
			clearOutput();
			outputText("Which cock-sock would you like to get removed?");
			//(display list of socked cocks)
			temp = 0;
			var button:int = 0;
			menu();
			while(button < player.cockTotal()) {
				if (player.cocks[button].sock != "") addButton(button,String(button+1),removeTargettedSock,button);
				button++;
			}
			addButton(14, "Cancel", gretasGarments);
			
		}

		private function removeTargettedSock(index:int):void {
			clearOutput();
			//Select-A-Cock!
			outputText("You walk up to the counter top. Greta the succubus looks up at you over her latest creation, and you explain you'd like to remove a cocksock.");
			outputText("\n\n\"<i>Ah, all right then,</i>\" she says smoothly, setting aside her knitting needles. \"<i>Making room for a new sock, or just looking to get rid of this one? No matter, it's a simple counterspell.</i>\" Greta stands up from her chair, though she's only on her feet for a moment before she kneels down in front of you, placing one hand under your " + player.cockDescript(index) + ". With her free hand, she runs a little circle around your " + player.cockHead(index) + ", muttering something under her breath.");
			
			outputText("\n\nSuddenly your cock feels white-hot, burning with passionate arousal. It jumps to attention immediately");
			if (player.cockArea(index) >= 100) outputText(", almost knocking Greta over in the process");
			outputText(", the cock-sock suddenly feeling unforgivingly tight. With a light giggle, Greta gives your dick a soft kiss, and the burning arousal seems to dissipate, replaced with a cool, relaxing sensation that spreads throughout your body.");
			outputText("\n\nYour dick rapidly deflates, and as it does so, the sock covering it falls off naturally. The busty succubus gathers up the now-mundane sock and returns to her seat behind the counter.");
			
			var storage:String = player.cocks[index].sock;
			var extra:Boolean = false;
			player.cocks[index].sock = "";
			temp = player.cockTotal();
			while(temp > 0) {
				temp--;
				//If the PC has another cock with the same effect.
				if (player.cocks[temp].sock == storage) {
					extra = true;
				}
			}
			if (extra) {
				if (storage == "cockring") {
					player.setPerkValue(PerkLib.PentUp, 1, 5 + (player.countCockSocks("cockring") * 5));
				}
				if (storage == "gilded") {
					player.setPerkValue(PerkLib.MidasCock, 1, player.countCockSocks("gilded") * 5);
				}
			}
			else {
				if (storage == "gilded") {
					player.removePerk(PerkLib.MidasCock);
				}
				if (storage == "cobalt") {
					player.removePerk(PerkLib.PhallicRestraint);
				}
				if (storage == "scarlet") {
					player.removePerk(PerkLib.PhallicPotential);
				}
				if (storage == "viridian") {
					player.removePerk(PerkLib.LustyRegeneration);
				}
				if (storage == "cockring") {
					player.removePerk(PerkLib.PentUp);
				}
			}	
			outputText("\n\n\"<i>If you need another one, we've got plenty more for sale.</i>\"");
			//(Cock-sock lost! +5 Corruption, -10 Arousal)
			dynStats("lus", -10, "cor", 1);
			menu();
			addButton(0,"Next",gretasGarments);
		}
		
	}

}