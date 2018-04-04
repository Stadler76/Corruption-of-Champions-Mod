package classes 
{
	import classes.*; 
	import classes.BodyParts.*;
	import classes.GlobalFlags.*;
	
	public class PlayerAppearance extends BaseContent
	{
		public function PlayerAppearance() {}

		protected function footInchOrMetres(...args):String { return Measurements.footInchOrMetres.apply(null, args); }
		protected function numInchesOrCentimetres(inches:Number):String { return Measurements.numInchesOrCentimetres(inches); }
		protected function inchesOrCentimetres(...args):String { return Measurements.inchesOrCentimetres.apply(null, args); }
		protected function shortSuffix(...args):String { return Measurements.shortSuffix.apply(null, args); }

		public function appearance():void {
			if (CoC_Settings.charviewEnabled) mainViewManager.showPlayerDoll(debug);
			funcs = new Array();
			args = new Array();
			//Temp vars
			var temp:Number = 0;
			var rando:Number = 0;
			//Determine race type:
			var race:String = "human";
			race = player.race;
			//Discuss race
			output.clear().header("Appearance");
			if (race != player.startingRace)	output.text("You began your journey as a " + player.startingRace + ", but gave that up as you explored the dangers of this realm.  ");
			//Height and race.
			output.text("You are a [tallness] tall [malefemaleherm] [race], with [bodytype].");
			
			outputText("  <b>You are currently " + (player.armorDescript() != "gear" ? "wearing your " + player.armorDescript() : "naked") + " and using your " + player.weaponName + " as a weapon.</b>");
			if (player.featheryHairPinEquipped()) {
				// This may be relocated into a method later. Probably something, like player.headAccessory()
				// Note, that earrings count as piercings, meaning, that head accessories and earrings are to be handled seperately
				var hairPinText:String = "";
				hairPinText += "  <b>You have a hair-pin with a single red feather plume";
				if (player.hair.length > 0)
					hairPinText += " in your [hair].</b>";
				else
					hairPinText += " on your head.</b>";
				outputText(hairPinText);
			}
			if (player.jewelryName != "nothing") 
				outputText("  <b>Girding one of your fingers is " + player.jewelryName + ".</b>");
			//Face
			if (player.face.type == Face.HUMAN || player.face.type == Face.SHARK_TEETH || player.face.type == Face.BUNNY || player.face.type == Face.SPIDER_FANGS || player.face.type == Face.FERRET_MASK) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  Your face is human in shape and structure, with [skin].");
				if (player.hasFur()) 
					outputText("  Under your [skinFurScales] you have a human-shaped head with [skin.noadj].");
				if (player.hasScales()) 
					outputText("  Your face is fairly human in shape, but is covered in [skin].");
				if (player.face.type == Face.SHARK_TEETH) 
					outputText("  A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance.");
				else if (player.face.type == Face.BUNNY) 
					outputText("  The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness.");
				else if (player.face.type == Face.SPIDER_FANGS) 
					outputText("  A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom.");
				else if (player.face.type == Face.FERRET_MASK)
					outputText("  The [skinFurScales] around your eyes is significantly darker than the rest of your face, giving you a cute little ferret mask.");
			}
			else if (player.face.type == Face.FERRET)
			{
				if (player.hasPlainSkin())
					outputText("  Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers."
					          +"  The only oddity is your lack of fur, leaving only [skin] visible on your ferret-like face.");
				else
					outputText("  Your face has mustelid muzzle, with a ferret-like visage and a cute pink nose. It’s covered by a layer of soft,"
					          +" [furColor] colored fur, with patches of white on your muzzle and cheeks."
					          +" A noticeable mask of [furColor] fur is shaped around your eyes.");
			}
			else if (player.face.type == Face.RACCOON_MASK) 
			{
				//appearance for skinheads
				if (!player.isFurryOrScaley()) 
				{
					outputText("  Your face is human in shape and structure, with [skin]");
					if ((player.skin.tone == "ebony" || player.skin.tone == "black") && (player.hasPlainSkin() || player.hasGooSkin())) 
						outputText(", though with your dusky hue, the black raccoon mask you sport isn't properly visible.");
					else outputText(", though it is decorated with a sly-looking raccoon mask over your eyes.");
				}
				//appearance furscales
				else 
				{
					//(black/midnight furscales)
					if (((player.skin.furColor == "black" || player.skin.furColor == "midnight") && player.isFurryOrScaley())) 
						outputText("  Under your [skinFurScales] hides a black raccoon mask, barely visible due to your inky hue, and");
					else outputText("  Your [skinFurScales] are decorated with a sly-looking raccoon mask, and under them");
					outputText(" you have a human-shaped head with [skin.noadj].");
				}
			}
			else if (player.face.type == Face.RACCOON) 
			{
				outputText("  You have a triangular raccoon face, replete with sensitive whiskers and a little black nose; a mask shades the space around your eyes, set apart from your [skinFurScales] by a band of white.");
				//(if skin)
				if (player.hasPlainSkin()) 
					outputText("  It looks a bit strange with only the skin and no fur.");
				else if (player.hasReptileScales()) 
					outputText("  The presence of said scales gives your visage an eerie look, more reptile than mammal.");
			}
			else if (player.face.type == Face.FOX) 
			{
				outputText("  You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.");
				if (player.hasPlainSkin()) 
					outputText("  Oddly enough, there's no fur on your animalistic muzzle, just [skinFurScales]."); 
				else if (player.hasFur())
					if (player.hasDifferentUnderBody())
						outputText("  Your muzzle is decorated with [skinFurScales] on your upper jaw and head and with [underBody.skinFurScales] on your lower jaw.");
					else
						outputText("  A coat of [skinFurScales] decorates your muzzle.");
				else if (player.hasScales()) 
					outputText("  Strangely, [skinFurScales] adorn every inch of your animalistic visage.");
			}
			else if (player.face.type == Face.BUCKTEETH) 
			{
				//appearance
				outputText("  Your face is generally human in shape and structure, with [skin]"
				          + (player.hasFur() ? " under your [skinFurScales]" : "") + " and mousey buckteeth.");
			}
			else if (player.face.type == Face.MOUSE) 
			{
				//appearance
				outputText("  You have a snubby, tapered mouse's face, with whiskers, a little pink nose, and [skin]"
				          + (player.hasFur() ? " under your [skinFurScales]" : "") + ".  Two large incisors complete it.");
			}
			//Naga
			if (player.face.type == Face.SNAKE_FANGS) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a fairly normal face, with [skin].  The only oddity is your pair of dripping fangs which often hang over your lower lip.");
				if (player.hasFur()) 
					outputText("  Under your [skinFurScales] you have a human-shaped head with [skin.noadj].  In addition, a pair of fangs hang over your lower lip, dripping with venom.");
				if (player.hasScales()) 
					outputText("  Your face is fairly human in shape, but is covered in [skinFurScales].  In addition, a pair of fangs hang over your lower lip, dripping with venom.");
			}
			//horse-face
			if (player.face.type == Face.HORSE) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  Your face is equine in shape and structure.  The odd visage is hairless and covered with [skinFurScales].");
				if (player.hasFur()) 
					outputText("  Your face is almost entirely equine in appearance, even having [skinFurScales].  Underneath the fur, you believe you have [skin.noadj].");
				if (player.hasScales()) 
					outputText("  You have the face and head structure of a horse, overlaid with glittering [skinFurScales].");
			}
			//wolf-face
			if (player.face.type == Face.WOLF) 
			{
				outputText("  You have an angular wolf's face complete with a muzzle and black nose");
				if (!player.hasFur())
					outputText(", though devoid of any fur.");
				else
					outputText(".");
			}
			//dog-face
			if (player.face.type == Face.DOG) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a dog-like face, complete with a wet nose.  The odd visage is hairless and covered with [skinFurScales].");
				if (player.hasFur()) 
					outputText("  You have a dog's face, complete with wet nose and panting tongue.  You've got [skinFurScales], hiding your [skin.noadj] underneath your furry visage.");
				if (player.hasScales()) 
					outputText("  You have the facial structure of a dog, wet nose and all, but overlaid with glittering [skinFurScales].");
			}
			//cat-face
			if (player.face.type == Face.CAT) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a cat-like face, complete with a cute, moist nose and whiskers.  The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face.");
				if (player.hasFur())
					if (player.hasDifferentUnderBody())
						outputText("  You have a cat-like face, complete with moist nose and whiskers.  You have [skinFurScales] on your upper jaw and head, while your lower jaw is decorated by [underBody.skinFurScales], hiding your [skin.noadj] underneath.");
					else
						outputText("  You have a cat-like face, complete with moist nose and whiskers.  Your [skinDesc] is [furColor], hiding your [skin.noadj] underneath.");
				if (player.hasScales()) 
					outputText("  Your facial structure blends humanoid features with those of a cat.  A moist nose and whiskers are included, but overlaid with glittering [skinFurScales].");
				if (player.eyes.type != Eyes.BLACK_EYES_SAND_TRAP)
				{
					outputText("  Of course, no feline face would be complete without vertically slit eyes");
					outputText(!player.hasReptileEyes() ? "." : ", although they come with a second set of eyelids, which is somewhat unusual for a cats face.");
				}
			}
			//Minotaaaauuuur-face
			if (player.face.type == Face.COW_MINOTAUR) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Despite your lack of fur elsewhere, your visage does have a short layer of [furColor] fuzz.");
				if (player.hasFur()) 
					outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Your [skinFurScales] thickens noticeably on your head, looking shaggy and more than a little monstrous once laid over your visage.");
				if (player.hasScales()) 
					outputText("  Your face resembles a minotaur's, though strangely it is covered in shimmering scales, right up to the flat cow-like nose that protrudes from your face.");
			}
			//Lizard-face
			if (player.face.type == Face.LIZARD) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage.  The reptilian visage does look a little odd with just [skin].");
				if (player.hasFur()) 
					outputText("  You have a face resembling that of a lizard.  Between the toothy maw, pointed snout, and the layer of [skinFurScales] covering your face, you have quite the fearsome visage.");
				if (player.hasScales()) {
					outputText("  Your face is that of a lizard, complete with a toothy maw and pointed snout.");
					if (!player.hasReptileUnderBody())
						outputText("  Reflective [skinFurScales] complete the look, making you look quite fearsome.");
					else
						outputText("  Reflective [skinFurScales] on your upper jaw and head and [underBody.skinFurScales] on your lower jaw complete the look, making you look quite fearsome.");
				}
			}
			if (player.face.type == Face.DRAGON) 
			{
				outputText("  Your face is a narrow, reptilian muzzle.  It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw.  It gives you a regal but fierce visage.  Opening your mouth reveals several rows of dagger-like sharp teeth.  The fearsome visage is decorated by [skinFurScales]");
				outputText(player.hasReptileUnderBody() ? " on your upper jaw and head and [underBody.skinFurScales] on your lower jaw." : ".");
			}
			if (player.face.type == Face.KANGAROO) 
			{
				outputText("  Your face is ");
				if (player.hasPlainSkin()) 
					outputText("bald");
				else outputText("covered with [skinFurScales]");
				outputText(" and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.");
			}
			//<mod>
			if (player.face.type == Face.PIG)
			{
				outputText("  Your face is like that of a pig, with [skinTone] skin, complete with a snout that is always wiggling.");
			}
			if (player.face.type == Face.BOAR)
			{
				outputText("  Your face is like that of a boar, ");
				if (player.hasFur()) 
					outputText("with [skinTone] skin underneath your [furColor] fur"); 
				outputText(", complete with tusks and a snout that is always wiggling.");
			}
			if (player.face.type == Face.RHINO)
			{
				outputText("  Your face is like that of a rhino");
				if (player.hasPlainSkin())
					outputText(", with [skin], complete with a long muzzle and a horn on your nose.");
				else
					outputText(" with a long muzzle and a horn on your nose.  Oddly, your face is also covered in [skinFurScales].");
			}
			if (player.face.type == Face.ECHIDNA)
			{
				outputText("  Your odd visage consists of a long, thin echidna snout.");
				if (player.hasPlainSkin())
					outputText("  The [skin] that is revealed by your lack of fur looks quite unusual.");
				else if (player.hasFur())
					outputText("  It's covered in [skinFurScales].");
				else if (player.hasScales())
					outputText("  It's covered in [skinFurScales], making your face even more unusual.");
			}
			if (player.face.type == Face.DEER)
			{
				outputText("  Your face is like that of a deer, with a nose at the end of your muzzle.");
				if (player.hasPlainSkin())
					outputText("  The [skin] that is revealed by your lack of fur looks quite unusual.");
				else if (player.hasFur())
					if (player.hasDifferentUnderBody())
						outputText("  It's covered in [skinFurScales] on your upper jaw and head and [underBody.skinFurScales]"
						          +" on your lower jaw that covers your [skin.noadj] underneath.");
					else
						outputText("  It's covered in [skinFurScales] that covers your [skin.noadj] underneath.");
				else if (player.hasScales())
					outputText("  It's covered in [skinFurScales], making your face looks more unusual.");
			}
			if (player.face.type == Face.COCKATRICE)
			{
				if (player.underBody.skin.type == Skin.FEATHERED)
					outputText("  You have a cockatrice’s face, complete with [furColor] feathered skin and a muzzle like beak.");
				else
					outputText("  You have a cockatrice’s face, complete with [skinFurScales] and a muzzle like beak.");
			}
			if (player.face.type == Face.RED_PANDA)
			{
				outputText("  Your face has a distinctive animalistic muzzle, proper from a red-panda, complete with a cute pink nose."
				          +" A coat of soft, [if (hasFur)[furColor]|russet-red] colored fur covers your head, with patches of white on your muzzle,"
				          +" cheeks and eyebrows.");
			}
			//</mod>
			//M/F stuff!
			outputText("  It has " + player.faceDesc() + ".");
			//Eyes
			if (player.eyes.type == Eyes.SPIDER) 
				outputText(" Your eyes are normal, save for their black irises, making them ominous and hypnotizing.");
			else if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) 
				outputText("  Your eyes are solid spheres of inky, alien darkness.");
			else if (player.eyes.type == Eyes.WOLF) 
				outputText("  Your amber eyes are circled by darkness to help keep the sun from obscuring your view and have a second eyelid to keep them wet. You're rather near-sighted, but your peripherals are great!");
			else if (player.eyes.type == Eyes.COCKATRICE)
				outputText("  You have electric blue eyes spiderwebbed with lightning like streaks that signal their power and slit reptilian pupils."
				          +" When excited your pupils dilate into wide circles.");
			else if (player.face.type != Face.CAT && player.hasReptileEyes())
			{
				outputText("  Your eyes are");
				switch (player.eyes.type)
				{
					case Eyes.DRAGON: outputText(" prideful, fierce dragon eyes with vertically slitted pupils and burning orange irises. They glitter even in the darkness and they"); break;
					case Eyes.LIZARD: outputText(" those of a lizard with vertically slitted pupils and green-yellowish irises. They"); break;
					case Eyes.BASILISK: outputText(" basilisk eyes, grey reptilian pools with vertically slitted pupils. They"); break;
					default: //Move along
				}
				outputText(" come with the typical second set of eyelids, allowing you to blink twice as much as others.");
				if (player.eyes.type == Eyes.BASILISK)
					outputText(" Others seem compelled to look into them.");
			}
			if (player.eyes.count > 2)
				outputText(" In addition to your primary two eyes, you have [extraEyesShort] positioned on your forehead.");

			//Hair
			//Hair
			//if bald
			if (player.hair.length == 0) 
			{
				if (player.hasFur()) 
					outputText("  You have no hair, only a thin layer of fur atop of your head.  ");
				else if (player.hasWool()) 
					outputText("  You have no hair, only a thin layer of wool atop of your head.  ");
				else outputText("  You are totally bald, showing only shiny [skinTone] [skinDesc] where your hair should be.");
				switch (player.ears.type) {
					case Ears.HORSE:     outputText("  A pair of horse-like ears rise up from the top of your head."); break;
					case Ears.SHEEP:     outputText("  Two tear drop shaped ears peek out from the sides of your head, their fluffy texture and lazy positioning giving you a cute and sleepy air."); break;
					case Ears.FERRET:    outputText("  Big, [furColor] furred, ferret ears lie atop your head, doing a good job detecting nearby sounds."); break;
					case Ears.DOG:       outputText("  A pair of dog ears protrude from your skull, flopping down adorably."); break;
					case Ears.COW:       outputText("  A pair of round, floppy cow ears protrude from the sides of your skull."); break;
					case Ears.ELFIN:     outputText("  A pair of large pointy ears stick out from your skull."); break;
					case Ears.CAT:       outputText("  A pair of cute, fuzzy cat ears have sprouted from the top of your head."); break;
					case Ears.LIZARD:    outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears."); break;
					case Ears.BUNNY:     outputText("  A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk."); break;
					case Ears.FOX:       outputText("  A pair of large, adept fox ears sit high on your head, always listening."); break;
					case Ears.DRAGON:    outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them."); break;
					case Ears.RACCOON:   outputText("  A pair of vaguely egg-shaped, furry raccoon ears adorns your head."); break;
					case Ears.MOUSE:     outputText("  A pair of large, dish-shaped mouse ears tops your head."); break;
					//<mod>
					case Ears.PIG:       outputText("  A pair of pointy, floppy pig ears have sprouted from the top of your head."); break;
					case Ears.RHINO:     outputText("  A pair of open tubular rhino ears protrude from your head."); break;
					case Ears.ECHIDNA:   outputText("  A pair of small rounded openings appear on your head that are your ears."); break;
					case Ears.DEER:      outputText("  A pair of deer-like ears rise up from the top of your head."); break;
					case Ears.WOLF:      outputText("  A pair of wolf ears stick out from your head, attuned to every sound around you."); break;
					case Ears.RED_PANDA: outputText("  Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings."); break;
					//</mod>
					default:
				}
				if (player.antennae.type == Antennae.BEE) 
					outputText("  Floppy antennae also appear on your skull, bouncing and swaying in the breeze.");
				else if (player.antennae.type == Antennae.COCKATRICE)
					outputText("  Two long antennae like feathers sit on your hairline, curling over the shape of your head.");
			}
			//not bald
			else 
			{
				switch (player.ears.type) {
					case Ears.HUMAN:     outputText("  Your [hair] looks good on you, accentuating your features well."); break;
					case Ears.FERRET:    outputText("  Big, [furColor] furred, ferret ears lie atop your head, doing a good job detecting nearby sounds."); break;
					case Ears.SHEEP:     outputText("  Two tear drop shaped ears part your [hair] and peek out from the sides of your head, their fluffy texture and lazy positioning giving you a cute and sleepy air."); break;
					case Ears.HORSE:     outputText("  The [hair] on your head parts around a pair of very horse-like ears that grow up from your head."); break;
					case Ears.DOG:       outputText("  The [hair] on your head is overlapped by a pair of pointed dog ears."); break;
					case Ears.COW:       outputText("  The [hair] on your head is parted by a pair of rounded cow ears that stick out sideways."); break;
					case Ears.ELFIN:     outputText("  The [hair] on your head is parted by a pair of cute pointed ears, bigger than your old human ones."); break;
					case Ears.CAT:       outputText("  The [hair] on your head is parted by a pair of cute, fuzzy cat ears, sprouting from atop your head and pivoting towards any sudden noises."); break;
					case Ears.LIZARD:    outputText("  The [hair] atop your head makes it nigh-impossible to notice the two small rounded openings that are your ears."); break;
					case Ears.BUNNY:     outputText("  A pair of floppy rabbit ears stick up out of your [hair], bouncing around as you walk."); break;
					case Ears.KANGAROO:  outputText("  The [hair] atop your head is parted by a pair of long, furred kangaroo ears that stick out at an angle."); break;
					case Ears.FOX:       outputText("  The [hair] atop your head is parted by a pair of large, adept fox ears that always seem to be listening."); break;
					case Ears.DRAGON:    outputText("  The [hair] atop your head is parted by a pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them."); break;
					case Ears.RACCOON:   outputText("  The [hair] on your head parts around a pair of egg-shaped, furry raccoon ears."); break;
					case Ears.MOUSE:     outputText("  The [hair] atop your head is funneled between and around a pair of large, dish-shaped mouse ears that stick up prominently."); break;
					//<mod> Mod-added ears
					case Ears.PIG:       outputText("  The [hair] on your head is parted by a pair of pointy, floppy pig ears. They often flick about when you’re not thinking about it."); break;
					case Ears.RHINO:     outputText("  The [hair] on your head is parted by a pair of tubular rhino ears."); break;
					case Ears.ECHIDNA:   outputText("  Your [hair] makes it near-impossible to see the small, rounded openings that are your ears."); break;
					case Ears.DEER:      outputText("  The [hair] on your head parts around a pair of deer-like ears that grow up from your head."); break;
					case Ears.WOLF:      outputText("  A pair of wolf ears stick out from your head, parting your [hair] and remaining alert to your surroundings."); break;
					case Ears.RED_PANDA: outputText("  Big, white furred, red-panda ears lie atop your head that part your [hair], keeping you well aware to your surroundings."); break;
					//</mod>
					default:
				}
				if (player.gills.type == Gills.FISH) 
				{
					output.text("  A set of fish like gills reside on your neck, several small slits that can close flat against your skin."
					           +" They allow you to stay in the water for quite a long time.");
				}
				// Gills.ANEMONE are handled below
				if (player.antennae.type == Antennae.BEE) 
				{
					if (player.ears.type == Ears.BUNNY) 
						outputText("  Limp antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
					else outputText("  Floppy antennae also grow from just behind your hairline, bouncing and swaying in the breeze.");
				}
				else if (player.antennae.type == Antennae.COCKATRICE)
				{
					outputText("  Two long antennae like feathers sit on your hairline, curling over the shape of your head.");
				}

			}
			if (player.ears.type == Ears.COCKATRICE) {
				outputText("  From the sides of your head protrude a quartet of feathers, the longest being vertical while the 3 shorter ones come"
				          +" out at a 1 o'clock, 2 o'clock and 3 o'clock angle. Behind them hides the avian hole that is your ear.");
			}
			
			//Beards!
			if (player.beard.length > 0) {
				outputText("  You have a " + player.beardDescript() + " ");
				if (player.beard.style != Beard.GOATEE) {
					outputText("covering your ");
					if (rand(2) == 0) outputText("jaw");
					else outputText("chin and cheeks")
				}
				else {
					outputText("protruding from your chin");
				}
				outputText(".");
			}
			
			//Tongue
			if (player.tongue.type == Tongue.SNAKE) 
				outputText("  A snake-like tongue occasionally flits between your lips, tasting the air.");
			else if (player.tongue.type == Tongue.DEMONIC) 
				outputText("  A slowly undulating tongue occasionally slips from between your lips.  It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal.");
			else if (player.tongue.type == Tongue.DRACONIC) 
				outputText("  Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet.  It has sufficient manual dexterity that you can use it almost like a third arm.");
			else if (player.tongue.type == Tongue.ECHIDNA)
				outputText("  A thin echidna tongue, at least a foot long, occasionally flits out from between your lips.");
			else if (player.tongue.type == Tongue.LIZARD)
				outputText("  Your mouth contains a thick, fleshy lizard tongue, bringing to mind the tongue of large predatory reptiles."
				          +" It can reach up to one foot, its forked tips tasting the air as they flick at the end of each movement.");
			//Horns
			if (player.horns.type == Horns.IMP) {
				outputText(" A set of pointed imp horns rest atop your head.");
			}
			//Demonic horns
			if (player.horns.type == Horns.DEMON) 
			{
				if (player.horns.value == 2) 
					outputText("  A small pair of pointed horns has broken through the [skinDesc] on your forehead, proclaiming some demonic taint to any who see them.");
				if (player.horns.value == 4) 
					outputText("  A quartet of prominent horns has broken through your [skinDesc].  The back pair are longer, and curve back along your head.  The front pair protrude forward demonically.");
				if (player.horns.value == 6) 
					outputText("  Six horns have sprouted through your [skinDesc], the back two pairs curve backwards over your head and down towards your neck, while the front two horns stand almost "+numInchesOrCentimetres(8)+" long upwards and a little forward.");
				if (player.horns.value >= 8) 
					outputText("  A large number of thick demonic horns sprout through your [skinDesc], each pair sprouting behind the ones before.  The front jut forwards nearly "+numInchesOrCentimetres(10)+" while the rest curve back over your head, some of the points ending just below your ears.  You estimate you have a total of " + num2Text(player.horns.value) + " horns.");	
			}
			//Minotaur horns
			if (player.horns.type == Horns.COW_MINOTAUR) 
			{
				if (player.horns.value < 3) 
					outputText("  Two tiny horn-like nubs protrude from your forehead, resembling the horns of the young livestock kept by your village.");
				if (player.horns.value >= 3 && player.horns.value < 6) 
					outputText("  Two moderately sized horns grow from your forehead, similar in size to those on a young bovine.");
				if (player.horns.value >= 6 && player.horns.value < 12) 
					outputText("  Two large horns sprout from your forehead, curving forwards like those of a bull.");
				if (player.horns.value >= 12 && player.horns.value < 20) 
					outputText("  Two very large and dangerous looking horns sprout from your head, curving forward and over a foot long.  They have dangerous looking points.");
				if (player.horns.value >= 20) 
					outputText("  Two huge horns erupt from your forehead, curving outward at first, then forwards.  The weight of them is heavy, and they end in dangerous looking points.");
			}
			//Lizard horns
			if (player.horns.value > 0 && player.horns.type == Horns.DRACONIC_X2) 
			{
				outputText("  A pair of " + numInchesOrCentimetres(player.horns.value) + " horns grow from the sides of your head, sweeping backwards and adding to your imposing visage.");
			}
			//Super lizard horns
			if (player.horns.type == Horns.DRACONIC_X4_12_INCH_LONG) 
				outputText("  Two pairs of horns, roughly a foot long, sprout from the sides of your head.  They sweep back and give you a fearsome look, almost like the dragons from your village's legends.");
			//Antlers!
			if (player.horns.type == Horns.ANTLERS) 
			{
				if (player.horns.value > 0) 
					outputText("  Two antlers, forking into " + num2Text(player.horns.value) + " points, have sprouted from the top of your head, forming a spiky, regal crown of bone.");
			}
			if (player.horns.type == Horns.SHEEP) {
				if (player.horns.value == 1) 
					outputText("  A pair of small sheep horns sit atop your head. They curl out and upwards in a slight crescent shape.");
				else
					outputText("  A pair of large sheep horns sit atop your head. They curl out and upwards in a crescent shape.");
			}
			if (player.horns.type == Horns.RAM) {
				if (player.horns.value == 1) 
					outputText("  A set of " + player.horns.value + " inch ram horns sit atop your head, curling around in a tight spiral at the side of your head before coming to an upwards hook around your ears.");
				else
					outputText("  A set of large " + player.horns.value + " inch ram horns sit atop your head, curling around in a tight spiral at the side of your head before coming to an upwards hook around your ears.");
			}			

			if (player.horns.type == Horns.GOAT)
			{
				if (player.horns.value == 1) 
					outputText("  A pair of stubby goat horns sprout from the sides of your head.");
				else
					outputText("  A pair of tall-standing goat horns sprout from the sides of your head.  They are curved and patterned with ridges.");
			}
			if (player.horns.type == Horns.RHINO)
			{
				if (player.horns.value >= 2) {
					if (player.face.type == Face.RHINO)
						outputText("  A second horn sprouts from your forehead just above the horn on your nose.");
					else
						outputText("  A single horn sprouts from your forehead.  It is conical and resembles a rhino's horn.");
					outputText("  You estimate it to be about "+numInchesOrCentimetres(7)+" long.");
				}
				else {
					outputText("  A single horn sprouts from your forehead.  It is conical and resembles a rhino's horn.  You estimate it to be about "+numInchesOrCentimetres(6)+" long.");
				}
			}
			if (player.horns.type == Horns.UNICORN)
			{
				outputText("  A single sharp nub of a horn sprouts from the center of your forehead.");
				if (player.horns.value < 12)
					outputText("  You estimate it to be about "+numInchesOrCentimetres(6)+" long.");
				else
					outputText("  It has developed its own cute little spiral. You estimate it to be about "+numInchesOrCentimetres(12)+" long, "+numInchesOrCentimetres(2)+" thick and very sturdy. A very useful natural weapon.");
			}
			// neckLen
			if (player.neck.type == Neck.DRACONIC)
			{
				// length description
				if (player.hasDragonNeck())
					outputText("  Your neck starts at the backside of your head and is about two and a half feet long, roughly six inches longer, than your arm length.");
				else {
					var lengthText:String = "";
					if (player.neck.len < 8) lengthText = "a few inches longer";
					else if (player.neck.len < 13) lengthText = "somewhat longer";
					else if (player.neck.len < 18) lengthText = "very long";
					else lengthText = "extremely long";
					outputText("  Where normal humans have a short neck, yours is " + lengthText + ", measuring " + player.neck.len + " inches.");
				}

				// bending your neck
				if (player.hasDragonNeck())
					outputText("  You manage to bend it in every direction you want and can easily take a look at your back.");
				else {
					if (player.neck.len < 10) outputText("  You can bend it a bit more than others with some effort.");
					else if (player.neck.len < 16) outputText("  You can bend it more than others with low effort.");
					else outputText("  You are able to bend it in almost every direction and with some effort you even manage to take a glimpse at your back.");
				}
			} else if (player.neck.type == Neck.COCKATRICE) {
				outputText("  Around your neck is a ruff of [neckColor] feathers which tends to puff out with your emotions.");
			}
			//BODY PG HERE
			outputText("\n\nYou have a humanoid shape with the usual torso, arms, hands, and fingers.");
			//WINGS!
			if (player.wings.type == Wings.BEE_LIKE_SMALL) 
				outputText("  A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly.");
			if (player.wings.type == Wings.BEE_LIKE_LARGE) 
				outputText("  A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully.  They flap quickly, allowing you to easily hover in place or fly.");
			if (player.wings.type == Wings.IMP) 
				outputText(" A pair of imp wings sprout from your back, flapping cutely but otherwise being of little use.");
			if (player.wings.type == Wings.IMP_LARGE) 
				outputText(" A pair of large imp wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.");
			if (player.wings.type == Wings.BAT_LIKE_TINY) 
				outputText("  A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use.");
			if (player.wings.type == Wings.BAT_LIKE_LARGE) 
				outputText("  A pair of large bat-like demon-wings fold behind your shoulders.  With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.");
			if (player.wings.type == Wings.FEATHERED_LARGE) 
				outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the " + player.wings.color + "-colored wings folded close, they can unfurl to allow you to soar as gracefully as a harpy.");
			if (player.wings.type == Wings.DRACONIC_SMALL) 
				outputText("  Small, vestigial wings sprout from your shoulders.  They might look like bat's wings, but the membranes are covered in fine, delicate scales.");
			else if (player.wings.type == Wings.DRACONIC_LARGE) 
				outputText("  Magnificent wings sprout from your shoulders.  When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky.  They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
			else if (player.wings.type == Wings.GIANT_DRAGONFLY) 
				outputText("  Giant dragonfly wings hang from your shoulders.  At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly.");

			// <mod name="BodyParts.RearBody" author="Stadler76">
			// rearBody
			switch (player.rearBody.type) {
				case RearBody.SHARK_FIN:
					outputText("  A large shark-like fin has sprouted between your shoulder blades."
					          +" With it you have far more control over swimming underwater.");
					break;
				case RearBody.DRACONIC_MANE:
					outputText("  Tracing your spine, a mane of [rearBodyColor] hair grows; starting at the base of your neck and continuing down"
					          +" your tail, ending on the tip of your tail in a small tuft. It grows in a thick vertical strip,"
					          +" maybe two inches wide. It reminds you vaguely of a horse's mane.");
					break;
				case RearBody.DRACONIC_SPIKES:
					// Teh spiky mane, similar to the hairy one.
					outputText("  Tracing your spine, a row of short steel-gray and curved backwards spikes protrude; starting at the base of your"
					          +" neck and continuing down your tail, ending on the tip of your tail. They've grown in a thick vertical strip,"
					          +" maybe an inch wide and two inches high. It reminds you very vaguely of a horse's mane.");
					break;
				default:
					//Nothing here, move along!
			}
			// </mod>

			// arms
			switch (player.arms.type) {
				case Arms.HARPY:
					outputText("  Feathers hang off your arms from shoulder to wrist, giving them a slightly wing-like look.");
					break;

				case Arms.WOLF:
					outputText("  Your arms are shaped like a wolf's, overly muscular at your shoulders and biceps before quickly slimming down."
					          +" They're covered in [furColor] fur and end in paws with just enough flexibility to be used as hands."
					          +" They're rather difficult to move in directions besides back and forth.");	
					break;

				case Arms.SPIDER:
					outputText("  Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves from a distance.");
					break;

				case Arms.BEE:
					outputText("  Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves ended with a yellow fuzz from a distance.");
					break;

				case Arms.SALAMANDER:
					outputText("  Shining thick, leathery red scales cover your arms from the biceps down and your fingernails are now short, fiery-red curved claws.");
					break;

				case Arms.PREDATOR:
					outputText("  Your arms are covered by [skinFurScales] and your fingernails are now [claws].");
					break;

				case Arms.COCKATRICE:
					outputText("  Your arms are covered in " + (player.hasCockatriceSkin() ? player.skin.furColor : player.hair.color) + " feathers"
					          +" from the shoulder down to the elbow where they stop in a fluffy cuff. A handful of long feathers grow from your"
					          +" elbow in the form of vestigial wings, and while they may not let you fly, they certainly help you jump. Your lower"
					          +" arm is coated in leathery [skinTone] scales and your fingertips terminate in deadly looking avian talons.");
					break;

				case Arms.RED_PANDA:
					outputText("  Soft, black-brown fluff cover your arms. Your paws have cute, pink paw pads and short claws.");
					break;

				case Arms.FERRET:
					outputText("  Soft, [hairOrFurColor] fluff covers your arms, turning into"
					          +" [if (hasFurryUnderBody)[underBody.furColor]|brown-black] fur from elbows to paws."
					          +" The latter have cute, pink paw pads and short claws.");
					break;
				default:
					//Nothing here, move along!
			}
			//Done with head bits. Move on to body stuff
			// <mod name="BodyParts.UnderBody" author="Stadler76">
			if (player.hasCockatriceSkin()) {
				outputText("  You’ve got a thick layer of [furColor] feathers covering your body, while [skinFurScales] coat you from"
				          +" chest to groin.");
			} else if (player.hasDifferentUnderBody()) {
				outputText("  While most of your body is covered by [skinFurScales] you have [underBody.skinFurScales] covering your belly.");
			}
			// </mod>
			//Horse lowerbody, other lowerbody texts appear lower
			if (player.isTaur()) 
			{
				if (player.lowerBody.type == LowerBody.HOOFED) 
					outputText("  From the waist down you have the body of a horse, with all [legCountText] legs capped by hooves.");
				else if (player.lowerBody.type == LowerBody.PONY) 
					outputText("  From the waist down you have an incredibly cute and cartoonish parody of a horse's body, with all [legCountText] legs ending in flat, rounded feet.");
				else
					outputText("  Where your legs would normally start you have grown the body of a feral animal, with all [legCountText] legs.");
			}
			if (player.isDrider()) 
				outputText("  Where your legs would normally start you have grown the body of a spider, with [legCountText] spindly legs that sprout from its sides.");
			//Hip info only displays if you aren't a centaur. 
			if (!player.isTaur()) 
			{
				if (player.thickness > 70) 
				{
					outputText("  You have [hips]");
					if (player.hips.rating < 6) 
					{
						if (player.tone < 65) 
							outputText(" buried under a noticeable muffin-top, and");
						else outputText(" that blend into your pillar-like waist, and");
					}
					if (player.hips.rating >= 6 && player.hips.rating < 10) 
						outputText(" that blend into the rest of your thick form, and");
					if (player.hips.rating >= 10 && player.hips.rating < 15) 
						outputText(" that would be much more noticeable if you weren't so wide-bodied, and");
					if (player.hips.rating >= 15 && player.hips.rating < 20) 
						outputText(" that sway and emphasize your thick, curvy shape, and");
					if (player.hips.rating >= 20) 
						outputText(" that sway hypnotically on your extra-curvy frame, and");
				}
				else if (player.thickness < 30) 
				{
					outputText("  You have [hips]");
					if (player.hips.rating < 6) 
						outputText(" that match your trim, lithe body, and");
					if (player.hips.rating >= 6 && player.hips.rating < 10) 
						outputText(" that sway to and fro, emphasized by your trim body, and");
					if (player.hips.rating >= 10 && player.hips.rating < 15) 
						outputText(" that swell out under your trim waistline, and");
					if (player.hips.rating >= 15 && player.hips.rating < 20) 
						outputText(", emphasized by your narrow waist, and");
					if (player.hips.rating >= 20) 
						outputText(" that swell disproportionately wide on your lithe frame, and");
				}
				//STANDARD
				else 
				{
					outputText("  You have [hips]");
					if (player.hips.rating < 6) 
						outputText(", and");
					if (player.femininity > 50) 
					{
						if (player.hips.rating >= 6 && player.hips.rating < 10) 
							outputText(" that draw the attention of those around you, and");
						if (player.hips.rating >= 10 && player.hips.rating < 15) 
							outputText(" that make you walk with a sexy, swinging gait, and");
						if (player.hips.rating >= 15 && player.hips.rating < 20) 
							outputText(" that make it look like you've birthed many children, and");
						if (player.hips.rating >= 20) 
							outputText(" that make you look more like an animal waiting to be bred than any kind of human, and");
					}
					else 
					{
						if (player.hips.rating >= 6 && player.hips.rating < 10) 
							outputText(" that give you a graceful stride, and");
						if (player.hips.rating >= 10 && player.hips.rating < 15) 
							outputText(" that add a little feminine swing to your gait, and");
						if (player.hips.rating >= 15 && player.hips.rating < 20) 
							outputText(" that force you to sway and wiggle as you move, and");
						if (player.hips.rating >= 20) 
						{
							outputText(" that give your ");
							if (player.balls > 0) 
								outputText("balls plenty of room to breathe");
							else if (player.hasCock()) 
								outputText(player.multiCockDescript() + " plenty of room to swing");
							else if (player.hasVagina()) 
								outputText(player.vaginaDescript() + " a nice, wide berth");
							else outputText("vacant groin plenty of room");
							outputText(", and");
						}
					}
				}
			}
			//ASS
			//Horse version
			if (player.isTaur()) 
			{
				//FATBUTT
				if (player.tone < 65) 
				{
					outputText("  Your [butt]");
					if (player.butt.rating < 4) 
						outputText(" is lean, from what you can see of it.");
					if (player.butt.rating >= 4 && player.butt.rating < 6) 
						outputText(" looks fairly average.");
					if (player.butt.rating >= 6 && player.butt.rating <10) 
						outputText(" is fairly plump and healthy.");
					if (player.butt.rating >= 10 && player.butt.rating < 15) 
						outputText(" jiggles a bit as you trot around.");
					if (player.butt.rating >= 15 && player.butt.rating < 20) 
						outputText(" jiggles and wobbles as you trot about.");
					if (player.butt.rating >= 20) 
						outputText(" is obscenely large, bordering freakish, even for a horse.");
				}
				//GIRL LOOK AT DAT BOOTY
				else 
				{
					outputText("  Your [butt]");
					if (player.butt.rating < 4) 
						outputText(" is barely noticeable, showing off the muscles of your haunches.");
					if (player.butt.rating >= 4 && player.butt.rating < 6) 
						outputText(" matches your toned equine frame quite well.");
					if (player.butt.rating >= 6 && player.butt.rating <10) 
						outputText(" gives hints of just how much muscle you could put into a kick.");
					if (player.butt.rating >= 10 && player.butt.rating < 15) 
						outputText(" surges with muscle whenever you trot about.");
					if (player.butt.rating >= 15 && player.butt.rating < 20) 
						outputText(" flexes its considerable mass as you move.");
					if (player.butt.rating >= 20) 
						outputText(" is stacked with layers of muscle, huge even for a horse.");
				}
			}
			//Non-horse PCs
			else 
			{
				//TUBBY ASS
				if (player.tone < 60) 
				{
					outputText(" your [butt]");
					if (player.butt.rating < 4) 
						outputText(" looks great under your gear.");
					if (player.butt.rating >= 4 && player.butt.rating < 6) 
						outputText(" has the barest amount of sexy jiggle.");
					if (player.butt.rating >= 6 && player.butt.rating <10) 
						outputText(" fills out your clothing nicely.");
					if (player.butt.rating >= 10 && player.butt.rating < 15) 
						outputText(" wobbles enticingly with every step.");
					if (player.butt.rating >= 15 && player.butt.rating < 20) 
						outputText(" wobbles like a bowl full of jello as you walk.");
					if (player.butt.rating >= 20) 
						outputText(" is obscenely large, bordering freakish, and makes it difficult to run.");
				}
				//FITBUTT
				else 
				{
					outputText(" your [butt]");
					if (player.butt.rating < 4) 
						outputText(" molds closely against your form.");
					if (player.butt.rating >= 4 && player.butt.rating < 6) 
						outputText(" contracts with every motion, displaying the detailed curves of its lean musculature.");
					if (player.butt.rating >= 6 && player.butt.rating <10) 
						outputText(" fills out your clothing nicely.");
					if (player.butt.rating >= 10 && player.butt.rating < 15) 
						outputText(" stretches your gear, flexing it with each step.");
					if (player.butt.rating >= 15 && player.butt.rating < 20) 
						outputText(" threatens to bust out from under your kit each time you clench it.");
					if (player.butt.rating >= 20) 
						outputText(" is marvelously large, but completely stacked with muscle.");
				}
			}
			//TAILS
			switch (player.tail.type) {
				case Tail.HORSE:
					outputText("  A long [hairColor] horsetail hangs from your [butt], smooth and shiny.");
					break;
				case Tail.FERRET:
					outputText("  Sprouting from your backside, you have a long, bushy tail. It’s covered in a fluffy layer of [hairOrFurColor] fur."
					          +" It twitches and moves happily with your body when you are excited.");
					break;
				case Tail.SHEEP:
					outputText("  A fluffy sheep tail hangs down from your [butt]. It occasionally twitches and shakes, its puffy fluff begging to be touched.");
					break;
				case Tail.DOG:
					outputText("  A fuzzy [furColor] dogtail sprouts just above your [butt], wagging to and fro whenever you are happy.");
					break;
				case Tail.DEMONIC:
					outputText("  A narrow tail ending in a spaded tip curls down from your [butt], wrapping around your [leg] sensually at every opportunity.");
					break;
				case Tail.COW:
					outputText("  A long cowtail with a puffy tip swishes back and forth as if swatting at flies.");
					break;
				case Tail.SPIDER_ABDOMEN:
					outputText("  A large, spherical spider-abdomen has grown out from your backside, covered in shiny black chitin.  Though it's heavy and bobs with every motion, it doesn't seem to slow you down.");
					if (player.tail.venom > 50 && player.tail.venom < 80) 
						outputText("  Your bulging arachnid posterior feels fairly full of webbing.");
					if (player.tail.venom >= 80 && player.tail.venom < 100) 
						outputText("  Your arachnid rear bulges and feels very full of webbing.");
					if (player.tail.venom == 100) 
						outputText("  Your swollen spider-butt is distended with the sheer amount of webbing it's holding.");
					break;
				case Tail.BEE_ABDOMEN:
					outputText("  A large insectile bee-abdomen dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger.");
					if (player.tail.venom > 50 && player.tail.venom < 80) 
						outputText("  A single drop of poison hangs from your exposed stinger.");
					if (player.tail.venom >= 80 && player.tail.venom < 100) 
						outputText("  Poisonous bee venom coats your stinger completely.");
					if (player.tail.venom == 100) 
						outputText("  Venom drips from your poisoned stinger regularly.");
					break;
				case Tail.SHARK:
					outputText("  A long shark-tail trails down from your backside, swaying to and fro while giving you a dangerous air.");
					break;
				case Tail.CAT:
					outputText("  A soft [furColor] cat-tail sprouts just above your [butt], curling and twisting with every step to maintain perfect balance.");
					break;
				case Tail.LIZARD:
					if (player.hasDifferentUnderBody()) {
						outputText("  A tapered tail, covered in [skinFurScales] with [underBody.skinFurScales] along its underside hangs down from just"
						          +" above your [ass].  It sways back and forth, assisting you with keeping your balance.");
					} else {
						outputText("  A tapered tail hangs down from just above your [ass].  It sways back and forth, assisting you with keeping your balance.");
					}
					break;
				case Tail.SALAMANDER:
					outputText("  A tapered, covered in red scales tail hangs down from just above your [ass].  It sways back and forth, assisting you with keeping your balance. When you are in battle or when you want could set ablaze whole tail in red-hot fire.");
					break;
				case Tail.RABBIT:
					outputText("  A short, soft bunny tail sprouts just above your [ass], twitching constantly whenever you don't think about it.");
					break;
				case Tail.HARPY:
					outputText("  A tail of feathers fans out from just above your [ass], twitching instinctively to help guide you if you were to take flight.");
					break;
				case Tail.KANGAROO:
					outputText("  A conical, ");
					if (player.hasGooSkin()) 
						outputText("gooey, [skinTone]");
					else outputText("furry, [furColor]");
					outputText(" tail extends from your [ass], bouncing up and down as you move and helping to counterbalance you.");
					break;
				case Tail.FOX:
					if (player.tail.venom <= 1) 
						outputText("  A swishing [hairOrFurColors] fox's brush extends from your [ass], curling around your body - the soft fur feels lovely.");
					else outputText("  " + Num2Text(player.tail.venom) + " swishing [hairOrFurColors] fox's tails extend from your [ass], curling around your body - the soft fur feels lovely.");
					break;
				case Tail.DRACONIC:
					if (player.hasDifferentUnderBody()) {
						outputText("  A thick, muscular, reptilian tail covered in [skinFurScales] with [underBody.skinFurScales] along its"
						          +" underside, almost as long as you are tall, swishes slowly from side to side behind you."
						          +" Its tip menaces with sharp spikes of bone, and could easily cause serious harm with a good sweep.");
					} else {
						outputText("  A thick, muscular, reptilian tail, almost as long as you are tall, unconsciously swings behind you slowly"
						          +" from side to side. Its tip menaces with sharp spikes of bone, and could easily cause grievous harm"
						          +" with a single, powerful sweep.");
					}
					break;
				case Tail.RACCOON:
					outputText("  A black-and-[furColor]-ringed raccoon tail waves behind you.");
					break;
				case Tail.MOUSE:
					outputText("  A naked, [skinTone] mouse tail pokes from your butt, dragging on the ground and twitching occasionally.");
					break;
				//<mod>
				case Tail.BEHEMOTH:
					outputText("  A long seemingly-tapering tail pokes from your butt, ending in spikes just like behemoth's.");
					break;
				case Tail.PIG:
					outputText("  A short, curly pig tail sprouts from just above your butt.");
					break;
				case Tail.SCORPION:
					outputText("  A chitinous scorpion tail sprouts from just above your butt, ready to dispense venom.");
					break;
				case Tail.GOAT:
					outputText("  A very short, stubby goat tail sprouts from just above your butt.");
					break;
				case Tail.RHINO:
					outputText("  A ropey rhino tail sprouts from just above your butt, swishing from time to time.");
					break;
				case Tail.ECHIDNA:
					outputText("  A stumpy echidna tail forms just about your [ass].");
					break;
				case Tail.DEER:
					outputText("  A very short, stubby deer tail sprouts from just above your butt.");
					break;
				case Tail.WOLF:
					outputText("  A thick-furred wolf tail hangs above your [ass].");
					break;
				case Tail.IMP:
					outputText("  A thin imp tail almost as long as you are tall hangs from above your [butt], dotted at the end with a small puff of hair.");
					break;
				case Tail.COCKATRICE:
					outputText("  A thick, scaly, prehensile reptilian tail hangs from your [butt], about half as long as you are tall."
					          +" The first inch or so is feathered, terminating in a 'v'shape and giving way to your [skinTone] scales.");
					break;
				case Tail.RED_PANDA:
					var tailColors:String = player.hasFur() ? (player.skin.furColor + " and " + player.redPandaTailColor2()) : "russet and orange";
					outputText("  Sprouting from your backside, you have a long, bushy tail. It has a beautiful pattern of rings in " + tailColors
					          +"  fluffy fur. It waves playfully as you walk giving to your step a mesmerizing touch.");
					break;
				//</mod>
				default:
					//Nothing here, move along!
			}
			//LOWERBODY SPECIAL
			switch (player.lowerBody.type) {
				case LowerBody.HUMAN:
					outputText("  [legCountTextUC] normal human legs grow down from your waist, ending in normal human feet.");
					break;

				case LowerBody.FERRET:
					outputText("  Your [legCountText] legs are equally covered in [hairOrFurColor] fur, the lower half having a darker shade."
					          +" They end on digitigrade ferret paws with short claws.");
					break;

				case LowerBody.HOOFED:
					outputText("  Your [legCountText] legs are muscled and jointed oddly, covered in fur, and end in a bestial hooves.");
					break;

				case LowerBody.WOLF:
					outputText("  You have [legCountText] digitigrade legs that end in wolf paws.");
					break;

				case LowerBody.DOG:
					outputText("  [legCountTextUC] digitigrade legs grow downwards from your waist, ending in dog-like hind-paws.");
					break;

				case LowerBody.NAGA:
					if (player.hasReptileUnderBody(true)) {
						var nagaColors:Array = ["", ""];
						if (player.underBody.type == UnderBody.NAGA)
							nagaColors = [player.underBody.skin.tone, player.nagaLowerBodyColor2()];
						else
							nagaColors = [player.skin.tone, player.underBody.skin.tone];
						outputText("  Below your waist, in place of where your legs would be, your body transitions into a long snake like tail."
						          +" Your snake-like lower body is covered by " + nagaColors[0] + " color scales,"
						          +" with " + nagaColors[1] + " color ventral scales along your underside.");
					} else
						outputText("  Below your waist your flesh is fused together into a very long snake-like tail.");
					break;

				case LowerBody.DEMONIC_HIGH_HEELS:
					outputText("  Your [legCountText] perfect lissome legs end in mostly human feet, apart from the horn protruding straight down from the heel that forces you to walk with a sexy, swaying gait.");
					break;

				case LowerBody.DEMONIC_CLAWS:
					outputText("  Your [legCountText] lithe legs are capped with flexible clawed feet.  Sharp black nails grow where once you had toe-nails, giving you fantastic grip.");
					break;

				case LowerBody.BEE:
					outputText("  Your [legCountText] legs are covered in a shimmering insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.  A bit of downy yellow and black fur fuzzes your upper thighs, just like a bee.");
					break;

				case LowerBody.GOO:
					outputText("  In place of legs you have a shifting amorphous blob.  Thankfully it's quite easy to propel yourself around on.  The lowest portions of your " + player.armorName + " float around inside you, bringing you no discomfort.");
					break;

				case LowerBody.CAT:
					outputText("  [legCountTextUC] digitigrade legs grow downwards from your waist, ending in soft, padded cat-paws.");
					break;

				case LowerBody.LIZARD:
					outputText("  [legCountTextUC] digitigrade legs grow down from your [hips], ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
					break;

				case LowerBody.SALAMANDER:
					outputText("  [legCountTextUC] digitigrade legs covered in thick, leathery red scales up to the mid-thigh grow down from your [hips], ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
					break;

				case LowerBody.BUNNY:
					outputText("  Your [legCountText] legs thicken below the waist as they turn into soft-furred rabbit-like legs.  You even have large bunny feet that make hopping around a little easier than walking.");
					break;

				case LowerBody.HARPY:
					outputText("  Your [legCountText] legs are covered with [furColor] plumage.  Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons.");
					break;

				case LowerBody.KANGAROO:
					outputText("  Your [legCountText] furry legs have short thighs and long calves, with even longer feet ending in prominently-nailed toes.");
					break;

				case LowerBody.CHITINOUS_SPIDER_LEGS:
					outputText("  Your [legCountText] legs are covered in a reflective black, insectile carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.");
					break;

				case LowerBody.FOX:
					outputText("  Your [legCountText] legs are crooked into high knees with hocks and long feet, like those of a fox; cute bulbous toes decorate the ends.");
					break;

				case LowerBody.DRAGON:
					outputText("  [legCountTextUC] human-like legs grow down from your [hips], sheathed in scales and ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
					break;

				case LowerBody.RACCOON:
					outputText("  Your [legCountText] legs, though covered in fur, are humanlike.  Long feet on the ends bear equally long toes, and the pads on the bottoms are quite sensitive to the touch.");
					break;

				case LowerBody.CLOVEN_HOOFED:
					outputText("  [legCountTextUC] digitigrade legs form below your [hips], ending in cloven hooves.");
					break;

				case LowerBody.IMP:
					outputText("  [legCountTextUC] digitigrade legs form below your [hips], ending in clawed feet. Three extend out the front, and one smaller one is in the back to keep your balance.");
					break;

				case LowerBody.COCKATRICE:
					outputText("  [legCountTextUC] digitigrade legs grow down from your [hips], ending in clawed feet."
					          +" There are three long toes on the front, and a small hind-claw on the back."
					          +" A layer of " + (player.hasCockatriceSkin() ? player.skin.furColor : player.hair.color) + " feathers covers your legs from the"
					          +" hip to the knee, ending in a puffy cuff.");
					break;

				case LowerBody.RED_PANDA:
					outputText("  Your [legCountText] legs are equally covered in [if (hasFurryUnderBody)[underBody.furColor]|black-brown] fur,"
					          +" ending on red-panda paws with short claws. They have a nimble and strong build,"
					          +" in case you need to escape from something.");
					break;

				default:
					//Nothing here, move along!
			}
			if (player.findPerk(PerkLib.Incorporeality) >= 0)
				outputText("  Of course, your [legs] are partially transparent due to their ghostly nature."); // isn't goo transparent anyway?
			outputText("\n");
			if (player.hasStatusEffect(StatusEffects.GooStuffed))
			{
				outputText("\n<b>Your gravid-looking belly is absolutely stuffed full of goo. There's no way you can get pregnant like this, but at the same time, you look like some fat-bellied breeder.</b>\n");
			}
			//Pregnancy Shiiiiiitz
			if ((player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) || (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) || player.isPregnant()) 
			{
				if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) 
				{
					outputText("<b>");
					//Compute size
					temp = player.statusEffectv3(StatusEffects.Eggs) + player.statusEffectv2(StatusEffects.Eggs) * 10;
					if (player.pregnancyIncubation <= 50 && player.pregnancyIncubation > 20) 
					{
						outputText("Your swollen pregnant belly is as large as a ");
						if (temp < 10) 
							outputText("basketball.");
						if (temp >= 10 && temp < 20) 
							outputText("watermelon.");
						if (temp >= 20) 
							outputText("beach ball.");
					}
					if (player.pregnancyIncubation <= 20) 
					{
						outputText("Your swollen pregnant belly is as large as a ");
						if (temp < 10) 
							outputText("watermelon.");
						if (temp >= 10 && temp < 20) 
							outputText("beach ball.");
						if (temp >= 20) 
							outputText("large medicine ball.");
					}
					outputText("</b>");
					temp = 0;
				}
				//Satur preggos - only shows if bigger than regular pregnancy or not pregnancy
				else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && player.buttPregnancyIncubation > player.pregnancyIncubation) 
				{
					if (player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75) 
					{
						outputText("<b>You've got the beginnings of a small pot-belly.</b>");
					}
					else if (player.buttPregnancyIncubation >= 50) 
					{
						outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>");	
					}
					else if (player.buttPregnancyIncubation >= 30) 
					{
						outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
					}
					else 
					{ //Surely Benoit and Cotton deserve their place in this list
						if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && (flags[kFLAGS.JOJO_STATUS] <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON || player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH) 
							outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
						else if (player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE) 
							outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
						else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
					}
				}
				//URTA PREG
				else if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA) 
				{
					if (player.pregnancyIncubation <= 432 && player.pregnancyIncubation > 360)
					{
						outputText("<b>Your belly is larger than it used to be.</b>\n");
					}
					if (player.pregnancyIncubation <= 360 && player.pregnancyIncubation > 288) 
					{
						outputText("<b>Your belly is more noticeably distended.   You're pretty sure it's Urta's.</b>");
					}
					if (player.pregnancyIncubation <= 288 && player.pregnancyIncubation > 216) 
					{
						outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>");
					}
					if (player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 144) 
					{
						outputText("<b>Your belly is large and very obviously pregnant to anyone who looks at you.  It's gotten heavy enough to be a pain to carry around all the time.</b>");
					}
					if (player.pregnancyIncubation <= 144 && player.pregnancyIncubation > 72) 
					{
						outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.  It's large and round, frequently moving.</b>");
					}
					if (player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48) 
					{
						outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
					}
					if (player.pregnancyIncubation <= 48) 
					{
						outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
					}
				}
				else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) 
				{
					if (player.buttPregnancyIncubation >= 8) 
						outputText("<b>Your stomach is so full of frog eggs that you look about to birth at any moment, your belly wobbling and shaking with every step you take, packed with frog ovum.</b>");
					else outputText("<b>You're stuffed so full with eggs that your belly looks obscenely distended, huge and weighted with the gargantuan eggs crowding your gut. They make your gait a waddle and your gravid tummy wobble obscenely.</b>");
				}
				else if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) { //Belly size remains constant throughout the pregnancy
					outputText("<b>Your belly remains swollen like a watermelon. ");
					if (player.pregnancyIncubation <= 100)
						outputText("It's full of liquid, though unlike a normal pregnancy the passenger you’re carrying is tiny.</b>");
					else if (player.pregnancyIncubation <= 140)
						outputText("It feels like it’s full of thick syrup or jelly.</b>");
					else outputText("It still feels like there’s a solid ball inside your womb.</b>");    
				}
				else 
				{
					if (player.pregnancyIncubation <= 336 && player.pregnancyIncubation > 280)
					{
						outputText("<b>Your belly is larger than it used to be.</b>");
					}
					if (player.pregnancyIncubation <= 280 && player.pregnancyIncubation > 216) 
					{
						outputText("<b>Your belly is more noticeably distended.   You are probably pregnant.</b>");
					}
					if (player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 180) 
					{
						outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>");
					}
					if (player.pregnancyIncubation <= 180 && player.pregnancyIncubation > 120) 
					{
						outputText("<b>Your belly is very obviously pregnant to anyone who looks at you.</b>");
					}
					if (player.pregnancyIncubation <= 120 && player.pregnancyIncubation > 72) 
					{
						outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>");
					}
					if (player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48) 
					{
						outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
					}
					if (player.pregnancyIncubation <= 48) 
					{ //Surely Benoit and Cotton deserve their place in this list
						if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && flags[kFLAGS.JOJO_STATUS] <= 0) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON || player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH) 
							outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
						else if (player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE) 
							outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
						else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
					}
				}
				outputText("\n");
			}
			outputText("\n");
			if (player.gills.type == Gills.ANEMONE) 
				outputText("A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest.  They allow you to stay in the water for quite a long time.  ");
			//Chesticles..I mean bewbz.
			if (player.breastRows.length == 1) 
			{
				outputText("You have " + num2Text(player.breastRows[temp].breasts) + " " + player.breastDescript(temp) + ", each supporting ");
				outputText( player.breastRows[temp].nipplesPerBreast == 1 ? "a" : num2Text(player.breastRows[temp].nipplesPerBreast)); //Number of nipples.
				outputText(" " + shortSuffix(player.nippleLength) + " ");		  // Length of nipples
				outputText(player.nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? "." : "s.")); //Nipple description and plural
				if (player.breastRows[0].milkFullness > 75) 
					outputText("  Your " + player.breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.");
				if (player.breastRows[0].breastRating >= 1) 
					outputText("  You could easily fill a " + player.breastCup(temp) + " bra.");
				//Done with tits.  Move on.
				outputText("\n");
			}
			//many rows
			else 
			{
				outputText("You have " + num2Text(player.breastRows.length) + " rows of breasts, the topmost pair starting at your chest.\n");
				while (temp < player.breastRows.length) 
				{
					if (temp == 0) 
						outputText("--Your uppermost rack houses ");
					if (temp == 1) 
						outputText("\n--The second row holds ");
					if (temp == 2) 
						outputText("\n--Your third row of breasts contains ");
					if (temp == 3) 
						outputText("\n--Your fourth set of tits cradles ");
					if (temp == 4) 
						outputText("\n--Your fifth and final mammary grouping swells with ");
					outputText(num2Text(player.breastRows[temp].breasts) + " " + player.breastDescript(temp) + " with ");
					outputText(num2Text(player.breastRows[temp].nipplesPerBreast)); //Number of nipples per breast
					outputText(" " + shortSuffix(player.nippleLength) + " ");		// Length of nipples
					outputText(player.nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? " each." : "s each.")); //Description and Plural
					if (player.breastRows[temp].breastRating >= 1) 
						outputText("  They could easily fill a " + player.breastCup(temp) + " bra.");
					if (player.breastRows[temp].milkFullness > 75) 
						outputText("  Your " + player.breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.");
					temp++;
				}
				//Done with tits.  Move on.
				outputText("\n");
			}	
			//Crotchial stuff - mention snake
			if (player.lowerBody.type == LowerBody.NAGA && player.gender > 0) 
			{
				outputText("\nYour sex");
				if (player.gender == 3 || player.cocks.length > 1) 
					outputText("es are ");
				else outputText(" is ");
				outputText("concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.\n");
			}

			// Cock Descriptions //
			if (player.hasCock()) {
				rando = rand(100);

				// Is taur and has multiple cocks?
				if      (player.isTaur() && player.cocks.length == 1)
					outputText("\nYour equipment has shifted to lie between your hind legs, like a feral animal.");
				else if (player.isTaur())
					outputText("\nBetween your hind legs, you have grown " + player.multiCockDescript() + "!\n");
				else if (player.cocks.length == 1)
					outputText("\n");
				else
					outputText("\nWhere a penis would normally be located, you have instead grown " + player.multiCockDescript() + "!\n");
			
				for (var cock_index:int = 0; cock_index < player.cocks.length; cock_index++) {
					rando++;

					// How to start the sentence?
					if  (player.cocks.length == 1)  outputText("Your ");
					else if (cock_index == 0)      outputText("--Your first ");
					else if (rando % 5 == 0)       outputText("--The next ");
					else if (rando % 5 == 1)       outputText("--The " + num2Text2(cock_index+1) + " of your ");
					else if (rando % 5 == 2)       outputText("--One of your ");
					else if (rando % 5 == 3)       outputText("--The " + num2Text2(cock_index+1) + " ");
					else if (rando % 5 == 4)       outputText("--Another of your ");

					// How large?
					outputText(player.cockDescript(cock_index) + ((rando % 5) % 3 == 0 || cock_index == 0 ? "":"s") +  " is " + inchesOrCentimetres(player.cocks[cock_index].cockLength) + " long and ");
					outputText(inchesOrCentimetres(player.cocks[cock_index].cockThickness));
					if      (rando % 3 == 0)  outputText(" wide.");
					else if (rando % 3 == 1)  outputText(" thick.");
					else if (rando % 3 == 2)  outputText(" in diameter.");

					// What flavor of cock do you have?
					switch (player.cocks[cock_index].cockType) {
						case CockTypesEnum.HORSE:     outputText("  It's mottled black and brown in a very animalistic pattern.  The 'head' of its shaft flares proudly, just like a horse's."); break;
						case CockTypesEnum.DOG:       outputText("  It is shiny, pointed, and covered in veins, just like a large dog's cock."); break;
						case CockTypesEnum.WOLF:      outputText("  It is shiny red, pointed, and covered in veins, just like a large wolf's cock."); break;
						case CockTypesEnum.FOX:       outputText("  It is shiny, pointed, and covered in veins, just like a large fox's cock."); break;
						case CockTypesEnum.DEMON:     outputText("  The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused.  The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins."); break;
						case CockTypesEnum.TENTACLE:  outputText("  The entirety of its green surface is covered in perspiring beads of slick moisture.  It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused."); break;
						case CockTypesEnum.CAT:       outputText("  It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip.  Each of the spines is soft and flexible, and shouldn't be painful for any of your partners."); break;
						case CockTypesEnum.LIZARD:    outputText("  It's a deep, iridescent purple in color.  Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps."); break;
						case CockTypesEnum.ANEMONE:   outputText("  The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload.  At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners."); break;
						case CockTypesEnum.KANGAROO:  outputText("  It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot."); break;
						case CockTypesEnum.DRAGON:    outputText("  With its tapered tip, there are few holes you wouldn't be able to get into.  It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would."); break;
						case CockTypesEnum.BEE:       outputText("  It's a long, smooth black shaft that's rigid to the touch.  Its base is ringed with a layer of " + shortSuffix(4) + " long soft bee hair.  The tip has a much finer layer of short yellow hairs.  The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it."); break;
						case CockTypesEnum.PIG:       outputText("  It's bright pinkish red, ending in a prominent corkscrew shape at the tip."); break;
						case CockTypesEnum.AVIAN:     outputText("  It's a red, tapered cock that ends in a tip.  It rests nicely in a sheath."); break;
						case CockTypesEnum.RHINO:     outputText("  It's a smooth, tough pink colored and takes on a long and narrow shape with an oval shaped bulge along the center."); break;
						case CockTypesEnum.ECHIDNA:   outputText("  It is quite a sight to behold, coming well-equipped with four heads."); break;
						case CockTypesEnum.RED_PANDA: outputText("  It lies protected in a soft, fuzzy sheath."); break;
						default: //Nothing here, move along!
					}

					// Knot?
					if (player.cocks[cock_index].knotMultiplier > 1) {
						if (player.cocks[cock_index].knotMultiplier >= 1.8) 
							outputText("  The obscenely swollen lump of flesh near the base of your " + player.cockDescript(cock_index) + " looks almost comically mismatched for your cock.");
						else if (player.cocks[cock_index].knotMultiplier >= 1.4) 
							outputText("  A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(cock_index) + ", to ensure it stays where it belongs during mating.");
						else // knotMultiplier < 1.4
							outputText("  A small knot of thicker flesh is near the base of your " + player.cockDescript(cock_index) + ", ready to expand to help you lodge it inside a female.");
						outputText("  The knot is " + inchesOrCentimetres(player.cocks[cock_index].cockThickness * player.cocks[cock_index].knotMultiplier) + " thick when at full size.");
					}

					// Sock Flavor
					if (player.cocks[cock_index].sock != "" && player.cocks[cock_index].sock != null){
						// I dunno what was happening, but it looks like .sock is null, as it doesn't exist. I guess this is probably more left over from some of the restucturing.
						// Anyways, check against null values, and stuff works again.
						//trace("Found a sock description (WTF even is a sock?)", player.cocks[cock_index].sock);
						sockDescript(cock_index);
					}
					outputText("\n");
				}

				//Worm flavor
				if (player.hasStatusEffect(StatusEffects.Infested))
					outputText("Every now and again slimy worms coated in spunk slip partway out of your " + player.multiCockDescriptLight() + ", tasting the air like tongues of snakes.\n");
			}


			//Of Balls and Sacks!
			if (player.balls > 0) 
			{
				if (player.hasStatusEffect(StatusEffects.Uniball))
				{
					if (player.hasGooSkin()) 
						outputText("Your [sack] clings tightly to your groin, dripping and holding " + player.ballsDescript() + " snugly against you.");
					else
						outputText("Your [sack] clings tightly to your groin, holding " + player.ballsDescript() + " snugly against you.");
				}
				else if (player.cocks.length == 0) 
				{
					if (player.hasPlainSkin()) 
						outputText("A " + player.sackDescript() + " with " + player.ballsDescript() + " swings heavily under where a penis would normally grow.");
					if (player.hasFur()) 
						outputText("A fuzzy " + player.sackDescript() + " filled with " + player.ballsDescript() + " swings low under where a penis would normally grow.");
					if (player.hasScales()) 
						outputText("A scaley " + player.sackDescript() + " hugs your " + player.ballsDescript() + " tightly against your body.");
					if (player.hasGooSkin()) 
						outputText("An oozing, semi-solid sack with " + player.ballsDescript() + " swings heavily under where a penis would normally grow.");
				}
				else 
				{
					if (player.hasPlainSkin()) 
						outputText("A " + player.sackDescript() + " with " + player.ballsDescript() + " swings heavily beneath your " + player.multiCockDescriptLight() + ".");
					if (player.hasFur()) 
						outputText("A fuzzy " + player.sackDescript() + " filled with " + player.ballsDescript() + " swings low under your " + player.multiCockDescriptLight() + ".");
					if (player.hasScales()) 
						outputText("A scaley " + player.sackDescript() + " hugs your " + player.ballsDescript() + " tightly against your body.");
					if (player.hasGooSkin()) 
						outputText("An oozing, semi-solid sack with " + player.ballsDescript() + " swings heavily beneath your " + player.multiCockDescriptLight() + ".");
				}
				outputText("  You estimate each of them to be about " + numInchesOrCentimetres(player.ballSize) + " across\n");
			}	
			//VAGOOZ
			if (player.vaginas.length > 0) 
			{
				if (player.gender == 2 && player.isTaur()) 
					outputText("\nYour womanly parts have shifted to lie between your hind legs, in a rather feral fashion.");
				outputText("\n");
				if (player.vaginas.length == 1) 
					outputText("You have a " + player.vaginaDescript(0) + ", with a " + inchesOrCentimetres(player.getClitLength()) + " clit");
				if (player.vaginas[0].virgin) 
					outputText(" and an intact hymen"); // Wait, won't this fuck up, with multiple vaginas?
				outputText(".  ");
				if (player.vaginas.length > 1) 
					outputText("You have " + player.vaginas.length+ " " + player.vaginaDescript(0) + "s, with " + inchesOrCentimetres(player.getClitLength()) + "-centimetre clits each.  ");
				if (player.lib100 < 50 && player.lust100 < 50) //not particularly horny
				
				{
					//Wetness
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_WET && player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_DROOLING) 
						outputText("Moisture gleams in ");
					if (player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_DROOLING) 
					{
						outputText("Occasional beads of ");
						outputText("lubricant drip from ");
					}
					//Different description based on vag looseness
					if (player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_WET) 
					{
						if (player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE) 
							outputText("your " + player.vaginaDescript(0) + ". ");
						if (player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE) 
							outputText("your " + player.vaginaDescript(0) + ", its lips slightly parted. ");
						if (player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE) 
							outputText("the massive hole that is your " + player.vaginaDescript(0) + ".  ");
					}
				}
				if ((player.lib100>=50 || player.lust100 >=50) && (player.lib100< 80 && player.lust100 < 80)) //kinda horny
				
				{
					//Wetness
					if (player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_WET) 
						outputText("Moisture gleams in ");
					if (player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_WET && player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_DROOLING) 
					{
						outputText("Occasional beads of ");
						outputText("lubricant drip from ");
					}
					if (player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_DROOLING) 
					{
						outputText("Thin streams of ");
						outputText("lubricant occasionally dribble from ");
					}
					//Different description based on vag looseness
					if (player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE) 
						outputText("your " + player.vaginaDescript(0) + ". ");
					if (player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE) 
						outputText("your " + player.vaginaDescript(0) + ", its lips slightly parted. ");
					if (player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE) 
						outputText("the massive hole that is your " + player.vaginaDescript(0) + ".  ");
				}
				if ((player.lib100> 80 || player.lust100 > 80)) //WTF horny!
				
				{
					//Wetness
					if (player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_WET) 
					
					{
						outputText("Occasional beads of ");
						outputText("lubricant drip from ");
					}
					if (player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_WET && player.vaginas[0].vaginalWetness< VaginaClass.WETNESS_DROOLING)
					
					{
						outputText("Thin streams of ");
						outputText("lubricant occasionally dribble from ");
					}
					if (player.vaginas[0].vaginalWetness>= VaginaClass.WETNESS_DROOLING) 
					
					{
						outputText("Thick streams of ");
						outputText("lubricant drool constantly from ");
					}
					//Different description based on vag looseness
					if (player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE) 
						outputText("your " + player.vaginaDescript(0) + ". ");
					if (player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE) 
						outputText("your " + player.vaginaDescript(0) + ", its lips slightly parted. ");
					if (player.vaginas[0].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE) 
						outputText("the massive hole that is your cunt.  ");
				}
				//Line Drop for next descript!
				outputText("\n");
			}
			//Genderless lovun'
			if (player.cocks.length == 0 && player.vaginas.length == 0) 
				outputText("\nYou have a curious lack of any sexual endowments.\n");
			
			
			//BUNGHOLIO
			if (player.ass) 
			{
				outputText("\n");
				outputText("You have one " + player.assholeDescript() + ", placed between your butt-cheeks where it belongs.\n");
			}
			//Piercings!
			if (player.eyebrowPierced > 0) 
				outputText("\nA solitary " + player.eyebrowPShort + " adorns your eyebrow, looking very stylish.");
			if (player.earsPierced > 0) 
				outputText("\nYour ears are pierced with " + player.earsPShort + ".");
			if (player.nosePierced > 0) 
				outputText("\nA " + player.nosePShort + " dangles from your nose.");
			if (player.lipPierced > 0) 
				outputText("\nShining on your lip, a " + player.lipPShort + " is plainly visible.");
			if (player.tonguePierced > 0) 
				outputText("\nThough not visible, you can plainly feel your " + player.tonguePShort + " secured in your tongue.");
			if (player.nipplesPierced == 3) 
				outputText("\nYour " + player.nippleDescript(0) + "s ache and tingle with every step, as your heavy " + player.nipplesPShort + " swings back and forth.");
			else if (player.nipplesPierced > 0) 
				outputText("\nYour " + player.nippleDescript(0) + "s are pierced with " + player.nipplesPShort + ".");
			if (player.cocks.length > 0) 
			{
				if (player.cocks[0].pierced > 0) 
				{
					outputText("\nLooking positively perverse, a " + player.cocks[0].pShortDesc + " adorns your " + player.cockDescript(0) + ".");
				}
			}
			if (flags[kFLAGS.CERAPH_BELLYBUTTON_PIERCING] == 1) 
				outputText("\nA magical, ruby-studded bar pierces your belly button, allowing you to summon Ceraph on a whim.");
			if (player.hasVagina()) 
			{
				if (player.vaginas[0].labiaPierced > 0) 
					outputText("\nYour " + player.vaginaDescript(0) + " glitters with the " + player.vaginas[0].labiaPShort + " hanging from your lips.");
				if (player.vaginas[0].clitPierced > 0) 
					outputText("\nImpossible to ignore, your " + player.clitDescript() + " glitters with its " + player.vaginas[0].clitPShort + ".");
			}
			//MONEY!
			if (player.gems == 0) 
				outputText("\n\n<b>Your money-purse is devoid of any currency.</b>");
			else if (player.gems == 1) 
				outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gem, collected in your travels.</b>");
			else if (player.gems > 1) 
				outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gems, collected in your travels.</b>");
			else {
				outputText("\n\n<b>Something is wrong with your gems!</b>");
			}
			if (player.udder.hasUdder && player.udder.fullness != 0) {
				outputText("\n\nYou have a an udder on your lowerbody it currently has " + player.udder.fullness + "oz of milk");
			}
			menu();
			doNext(playerMenu);
			output.flush();
		}

		public function sockDescript(index:int):void 
		{
			outputText("  ");
			if (player.cocks[index].sock == "wool") 
				outputText("It's covered by a wooly white cock-sock, keeping it snug and warm despite how cold it might get.");
			else if (player.cocks[index].sock == "alabaster") 
				outputText("It's covered by a white, lacey cock-sock, snugly wrapping around it like a bridal dress around a bride.");
			else if (player.cocks[index].sock == "cockring") 
				outputText("It's covered by a black latex cock-sock with two attached metal rings, keeping your cock just a little harder and [balls] aching for release.");
			else if (player.cocks[index].sock == "viridian") 
				outputText("It's covered by a lacey dark green cock-sock accented with red rose-like patterns.  Just wearing it makes your body, especially your cock, tingle.");
			else if (player.cocks[index].sock == "scarlet") 
				outputText("It's covered by a lacey red cock-sock that clings tightly to your member.  Just wearing it makes your cock throb, as if it yearns to be larger...");
			else if (player.cocks[index].sock == "cobalt") 
				outputText("It's covered by a lacey blue cock-sock that clings tightly to your member... really tightly.  It's so tight it's almost uncomfortable, and you wonder if any growth might be inhibited.");
			else if (player.cocks[index].sock == "gilded") 
				outputText("It's covered by a metallic gold cock-sock that clings tightly to you, its surface covered in glittering gems.  Despite the warmth of your body, the cock-sock remains cool.");
			else if (player.cocks[index].sock == "amaranthine") 
			
			{
				outputText("It's covered by a lacey purple cock-sock");
				if (player.cocks[index].cockType != CockTypesEnum.DISPLACER) 
					outputText(" that fits somewhat awkwardly on your member");
				else
					outputText(" that fits your coeurl cock perfectly");
				outputText(".  Just wearing it makes you feel stronger and more powerful.");
			}
			else if (player.cocks[index].sock == "red") 
				outputText("It's covered by a red cock-sock that seems to glow.  Just wearing it makes you feel a bit powerful.");
			else if (player.cocks[index].sock == "green") 
				outputText("It's covered by a green cock-sock that seems to glow.  Just wearing it makes you feel a bit healthier.");
			else if (player.cocks[index].sock == "blue") 
				outputText("It's covered by a blue cock-sock that seems to glow.  Just wearing it makes you feel like you can cast spells more effectively.");

			else outputText("<b>Yo, this is an error.</b>");
		}
		
	}
}
