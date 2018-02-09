//Side Dungeon: Dragon City (Ember Quest, WIP)
package classes.Scenes.Dungeons 
{
	import classes.BaseContent;
	import classes.GlobalFlags.*;
	import classes.StatusEffects;
	/**
	 * ...
	 * @author ...
	 */
	public class DragonCity extends DungeonAbstractContent
	{	
		public function DragonCity() {}
		
		private function emberMF(man:String, woman:String):String {
			return getGame().emberScene.emberMF(man, woman);
		}
		
		//Dungeon Functions
		public function traverseCorridor(corridorId:String):void {
			//The reason for this function is to allow for kobold encounter.
			switch(corridorId) {
				case "1a":
					roomHousingDistrict();
					break;
				case "1b":
					roomCitySquare();
					break;
				case "2a":
					roomArena();
					break;
				case "2b":
					roomCitySquare();
					break;
				case "3a":
					roomCityHallFront();
					break;
				case "3b":
					roomCitySquare();
					break;
				case "4a":
					roomBaths();
					break;
				case "4b":
					roomArena();
					break;
				default:
					outputText("<b>SOMETHING DERPED UP!</b>");
			}
		}
		
		//Temporary code for entering and exiting dungeon.
		public function enterDungeonDev():void {
			kGAMECLASS.inDungeon = true;
			kGAMECLASS.dungeonLoc = DungeonCore.DUNGEON_DRAGON_CITY_SQUARE;
			playerMenu();
		}
		public function exitDungeonDev():void {
			kGAMECLASS.inDungeon = false;
			kGAMECLASS.dungeonLoc = 0;
			camp.returnToCampUseOneHour();
		}
		
		//Dungeon Intro
		public function dungeonQuestIntro():void {
			clearOutput();
			outputText("While trudging through the muddy soil of the swamp, you come across a relatively dry cave and decide to rest for a short while before you resume your exploration. While lounging on a rock you feel a breeze [stroke your (hair.length)]. Normally this wouldn’t faze you, but the weird thing is that it came from within the cave. This could mean that this cave is actually a tunnel to a new area. Do you investigate?");
			doYesNo(dungeonQuestIntroAccept, dungeonQuestIntroDecline);
		}
		private function dungeonQuestIntroAccept():void {
			clearOutput();
			outputText("You decide to check what lies on the other side of the cave, it is quite dark...");
			if (player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
				outputText("\n\nLuckily you know enough about magic to conjure a small flame on your hand to light your path.");
			}
			else {
				outputText("\n\nLuckily you know enough about survival to construct a small torch with the materials you have lying around. Using a small branch from a tree, a piece of cloth you always carry with you, and some flint, you craft a perfectly functional torch to light your path.");
			}
			outputText("\n\nAt first, the darkness is oppressive and you remain alert should anything or anyone try and jump you, but gradually the cave starts to brighten up... though this kind of light looks far from natural, which only serves to put you even more on edge than before. Cautiously, you put out the flames lighting your way and let your eyes adjust to the darkness, then continue on as it gets gradually brighter.");
			outputText("\n\nWhen you reach the end, you find yourself standing in a tunnel carved out of the naked rock - it might have been a natural cave originally, but you can see the clear signs of handiwork to ease accessibility, such as a smooth-polished floor. There has been a sizable cave-in towards the back of the tunnel mouth, plugging it up with an array of boulders. Strange markings adorn the walls; a mixture of hieroglyphic sigils and etchings showing winged, reptilian beings - dragons, without a question of a doubt. These symbols are the sources of the light, each casting its own prominent aura of glowing energy, though you can’t say whether it’s from magic or some substance glazed into the etched designs.");
			outputText("\n\nAs you stare at the scene around you, wondering if you’ve reached a dead end, you realise you can feel something cool and gentle wafting across your [skin]. A breeze... there must be a gap or something somewhere. Following your skin, you eventually track down the source; a small gap between two boulders, too small for even a goblin or an imp to move through. As you study the rocks, you decide it’s too risky to try and move them on your own; while you could doubtlessly shift them, it might trigger a cave-in.");
			outputText("\n\nLooks like you have no choice but to give up on going any further for the moment.");
			if (flags[kFLAGS.EMBER_HATCHED] > 0) 
				("\n\nPerhaps Ember would know something about this place? Even if " + emberMF("he", "she") + " doesn’t, this place is obviously tied to the dragons, so " + emberMF("he", "she") + " should be involved in entering it.");
			else
				("\n\nPerhaps you could find a way to properly clear the obstruction without triggering a cave-in? Some wooden beams for supports and a pickaxe should suffice.");
		}
		private function dungeonQuestIntroDecline():void {
			clearOutput();
			outputText("You decide that whatever lies in this cave is not worth the risk... at least for the moment.  So you finish your rest and resume making your way through the swamp’s moist soil.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Dungeon Rooms
		public function roomCitySquare():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_CITY_SQUARE;
			outputText("<b><u>City Square</u></b>\n");
			outputText("You guess that this would be the city square; it’s a wide, empty space dominated by a large fountain with a statue depicting a buxom anthro female dragon in flight. The fountain is, surprisingly, still going, but it oozes a sluggish trickle of water from the statue’s mouth, which flows into a shattered-rimmed basin and flows steadily across the uneven paving stones, cutting a small, moss-thick channel in the dusty rock. There are several other statues around, but all have been smashed and broken and graffitied to the point it’s hard to be sure what they originally were; the fountain only survived because someone or something feared interfering with its supply of water. A few scarred, chipped stone benches are scattered around the square. Here and there, you spot small puddles of green sludge, rapidly drying as the thick dust soaks them up.\n\n");
			//This comment is to be replaced with Ember dialogue.
			outputText("From what you can gather from the old signs, West goes to the Housing District, East goes to the City Hall and North goes to the City Arena.");
			dungeons.setDungeonButtons(createCallBackFunction(traverseCorridor, "2a"), null, createCallBackFunction(traverseCorridor, "1a"), createCallBackFunction(traverseCorridor, "3a"));
			addButton(11, "Exit", exitDungeonDev);
		}
		
		public function roomHousingDistrict():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_HOUSING_DISTRICT;
			outputText("<b><u>Housing District</u></b>\n");
			if (9999 != 9999) {
				//Ember dialogue would go here.
			}
			else {
				outputText("The house that the two of you are certain belonged to Ember’s parents is a fairly humble affair, thanks in part to the ruinous effects of time and kobold depredations. From the outside, it’s a simple, cave-like affair made from stone. Inside, it’s obvious that nobody’s lived here for a long time. Short tunnel-like passageways lead to various rooms, but you and Ember have settled in what was evidently the living room in its heyday. A few pots made from fired clay are scattered around, their glazing smashed by vandals and their contents long-dead. Most of the furniture has been broken, but there’s still a large and serviceable, if ragged, couch that Ember is currently sitting on, as well as a large chair into which you have settled yourself.\n\n");
				outputText("You could rest here to gather your strength... or you could have Ember help you relieve some steam.");
			}
			outputText("You recall seeing a sign saying that the Baths are located North, or you could go back to the City Square Eastward.");
			dungeons.setDungeonButtons(roomBaths, null, null, createCallBackFunction(traverseCorridor, "1b"));
		}
		
		public function roomBaths():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_BATHS;
			outputText("<b><u>Baths</u></b>\n");
			outputText("The baths are not what you expected; they’re a series of open-air fjords, or crater-like pools of water connected by channels and rivulets to let the water flow freely. Some of these streams look big enough to allow small children to freely swim from one pool to another.\n\n");
			outputText("You imagine that they were once beautiful, but now it seems that they have been defiled. The air is thick with noxious scents; kobold slime and sexual musk and old jizz. The waters are thick and vile-looking with strange chemical pollutants. One can only imagine what must have happened here that would leave the place in such a state of disrepair.");
			//This comment is to be replaced with Ember dialogue. 
			//This is also where Kobold fight would occur.
			dungeons.setDungeonButtons(null, roomHousingDistrict, null, createCallBackFunction(traverseCorridor, "4b"));
		}

		public function roomArena():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_ARENA;
			outputText("<b><u>Arena</u></b>\n");
			outputText("The area in which the arena lies is dominated by the large, dome-shaped stadium itself; a huge building, completely sealed and accessible only through sizable double-doors. Once made of ornately engraved wood, time and the vandalism of kobolds have ruined them and torn them apart roughly half-way down, letting them swing creakily on rusting hinges in the faint breezes. The open space around you houses many statues of what were undoubtedly champions in their time, but are now broken and obscured by kobold leavings and dust.\n\n");
			//This comment is to be replaced with Ember dialogue. 
			outputText("According to the signs in this area. North is the Library, West are the Baths and South is the City Square.");
			dungeons.setDungeonButtons(roomLibrary, createCallBackFunction(traverseCorridor, "2b"), createCallBackFunction(traverseCorridor, "4a"), null);
			if (9999 != 9999) {
				outputText("The doors leading into the arena are busted open, meaning you could just walk in if you wanted. Even though your nose is less sensitive than Ember’s, you can smell the scent of kobolds and sex. It is very strong and you’ve no doubt there are many of them inside, you should consider the merits of going in before making a hasty decision, lest you be overwhelmed by the lizard critters.");
				//addButton(0, "Enter Arena", null);
			}
			else {
				outputText("You now know that the arena was actually being used as a kobold breeding den, and have no desire to go inside once more... Besides the place’s been looted clean and the remaining kobolds have scattered, so there is little point in doing so.");
			}
		}
		
		public function roomLibrary():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_LIBRARY;
			outputText("<b><u>Library</u></b>\n");
			outputText("Though the exterior is constructed of solid stone blocks, making it look more like a castle of some sort than a library - there are even towers and minarets - the interior is quite obviously that of a library. Cavernous spaces connected by long passageways reveal seemingly countless shelves of books and scrolls; who can say how much lore must be hidden here? The place smells strongly of sexual musk, and there have obviously been vandals at work here; puddles of slime are splattered here and there, seeped into the dust, and broken shelves, torn or half-burnt tomes, and even the ash-heap remains of fires make it obvious that the present visitors care nothing for learning.\n\n");
			//This comment is to be replaced with Ember dialogue. 
			dungeons.setDungeonButtons(null, roomArena, null, null);
			if (9999 != 9999) {
				outputText("You notice a wooden door adorned with a plaque written “Basement” on its center. When you try to open the door, you realise it won’t budge... something must be blocking it from inside.");
			}
			else {
				outputText("The door to the basement is open. You opened it earlier to create a small shortcut through the tunnels that will lead you into the City Hall.");
				addButton(7, "Down", roomSewerBreedingDen);
			}
		}
		
		public function roomCityHallFront():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_CITY_HALL_FRONT;
			outputText("<b><u>Front of City Hall</u></b>\n");
			outputText("The City Hall is an impressive building, even if it has slowly fallen into ruin, but you dare not get too close; dozens of small, twisted, draconic forms are openly loitering in the streets and alleys around the hall; sleeping, assembling crude weapons, eagerly making out with each other, or scavenging for food.  They haven’t seen you yet, but get closer and they’ll surely attack.\n\n");
			//This comment is to be replaced with Ember dialogue. 
			outputText("Perhaps you should go West, back to the City Square, or you could try your luck and head North towards the City Hall... but that looks like suicide");
			dungeons.setDungeonButtons(null, null, createCallBackFunction(traverseCorridor, "3b"), null);
		}
		
		public function roomCityHall():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_CITY_HALL;
			outputText("<b><u>City Hall</u></b>\n");
			outputText("Placeholdery placeholder is placeholdery.");
			dungeons.setDungeonButtons(null, roomCityHallFront, null, null);
		}
		
		public function roomSewerWest():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_SEWERS_WEST;
			outputText("<b><u>Western Sewers Chamber</u></b>\n");
			outputText("You step through the darkness and both you and Ember stumble your way into what looks like a wide room illuminated by a faint light streaming down from a grating on the roof.\n\n");
			outputText("The room is dank and smells quite unpleasant. You seem to be located in a deep pool in the rock underfoot that serves as some sort of dam, and you can see a closed floodgate at one end of the room, keeping the water on the other side from rendering the tunnel impassable. Looking back you spot a floodgate above the tunnel you just came through, apparently it was made so the water can flood this room and be rerouted through a couple of water pipes above. What water seeps through into the empty pool that makes the room you’re currently at is a noxiously thick slime, choked with mud and other fluids you don't want to guess at.\n\n");
			outputText("You can feel a soft breeze coming from the tunnels above,a tunnel that winds away into the distance. You also can spot a number of passageways and oozing pipes about, but the main thing of interest is a set of stairs near the floodgate, just across the pool.\n\n");
			dungeons.setDungeonButtons(null, null, null, roomSewerEast);
			if (9999 != 9999) {
				//This comment is to be replaced with Ember dialogue.
				outputText("Kobolds suddenly begin swarming all around you. They surge out of the filthy water by the dozens and squeeze their way out of the smaller pipes, a living wave of reptilian forms charging towards you, yipping and babbling in their bizarre language.\n\n");
				outputText("You and Ember get ready for battle, covering each other’s backs. <b>It’s a fight!</b>");
				//addButton(0, "FIGHT!", null);
			}
		}
		
		public function roomSewerEast():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_SEWERS_EAST;
			outputText("<b><u>Eastern Sewers Chamber</u></b>\n");
			outputText("The tunnel eventually leads you to what looks like some sort of hub for the sewer system; a great chamber opening to some kind of central pool, myriad pipes and openings of all sizes littering the walls. From most of them pours more of the foul muck that the kobolds have created, churning into a stinking whirlpool in the central pond. Metallic grating forms a circular path around the walls of the chamber, and you can spot four other doorways similar to the one you had to fight your way through to reach this point.\n\n");
			//This comment is to be replaced with Ember dialogue.
			dungeons.setDungeonButtons(roomSewerBreedingDen, null, null, null);
			if (9999 != 9999) {
				//This is where Kobold fight would happen.
				//addButton(0, "FIGHT!", null);
			}
		}
		
		public function roomSewerBreedingDen():void {
			clearOutput();
			getGame().dungeonLoc = DungeonCore.DUNGEON_DRAGON_BREEDING_DEN;
			outputText("<b><u>Breeding Den</u></b>\n");
			outputText("Placeholdery placeholder is placeholdery.");
			dungeons.setDungeonButtons(null, null, roomLibrary, roomCityHall);
			if (9999 != 9999) {
				//This is where Kobold fight would happen.
				//addButton(0, "FIGHT!", null);
			}
			
		}
	}

}