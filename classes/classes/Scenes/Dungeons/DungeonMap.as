package classes.Scenes.Dungeons {
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Scenes.Dungeons.*;

	public class DungeonMap extends BaseContent {

		public function DungeonMap() {}

		//Declare those map variables. They're set in such a way that the map can be updated as flags change
		public var MAP_FACTORY_F1:Array;
		public var MAP_FACTORY_F2:Array;
		public var MAP_DEEPCAVE:Array;
		public var MAP_STRONGHOLD_P1:Array;
		public var MAP_STRONGHOLD_P2:Array;
		public var MAP_DESERTCAVE:Array;
		public var MAP_PHOENIXTOWER_B1:Array;
		public var MAP_PHOENIXTOWER_F1:Array;
		public var MAP_PHOENIXTOWER_F2:Array;
		public var MAP_PHOENIXTOWER_F3:Array;
		public var MAP_ANZUPALACE_B1:Array;
		public var MAP_ANZUPALACE_F1:Array;
		public var MAP_ANZUPALACE_F2:Array;
		public var MAP_ANZUPALACE_F3:Array;
		public var MAP_ANZUPALACE_F4:Array;
		public var MAP_HELLHOUNDLABS:Array;
		public var MAP_DRAGONCITY_F1:Array;
		public var MAP_DRAGONCITY_B1:Array;

		//How to work with the refactored map:
		//-1 is wide empty space 1x3
		//-2 is narrow empty space 1x1
		//-3 is vertical passage (|)
		//-4 is horizontal passage (-)
		//-5 and -6 are locked passage. Only used for boolean checks (L)
		//The numbered rooms correspond to the room ID

		public function updateMap():void {
			//Factory
			MAP_FACTORY_F1 = [ //Room 00-05 + 06
				"Factory, Floor 1",
				[-1, -2, 04, -2, -1],
				[-1, -2, -3, -2, -1],
				[05, -4, 02, -4, 03],
				[-1, -2, d1, -2, -1],
				[09, -4, 00, -4, 01],
				[-1, -2, -3, -2, -1]];
			MAP_FACTORY_F2 = [ //Room 06-08
				"Factory, Floor 2",
				[06, -4, 07],
				[d2, -2, -1],
				[08, -2, -1]];
			//Deep Cave
			MAP_DEEPCAVE = [ //Room 10-16
				"Zetaz's Lair",
				[-1, -2, 16, -4, 15],
				[-1, -2, d3, -2, -3],
				[13, -4, 12, -4, 14],
				[-1, -2, -3, -2, -1],
				[-1, -2, 11, -2, -1],
				[-1, -2, -3, -2, -1],
				[-1, -2, 10, -2, -1],
				[-1, -2, -3, -2, -1]];
			//Lethice's Stronghold
			MAP_STRONGHOLD_P1 = [
				"Basilisk Cave",
				[-1, -2, "tunnel2", -4, -1],
				[-1, -2, -3, -2, -1],
				[-1, -2, "magpiehalls", -2, -1], //Will need to account for magpiehalln 
				[-1, -2, -3, -2, -1],
				[-1, -2, "antechamber", -4, "roomofmirrors"],
				[-1, -2, -3, -2, -1],
				["entrance", -4, "tunnel", -2, -1],
				[-3, -2, -1, -2, -1]];
			MAP_STRONGHOLD_P2 = [
				"Lethice's Keep",
				[-1, -2, -1, -2, "throneroom", -2, -1, -2, -1],
				[-1, -2, -1, -2, d5, -2, -1, -2, -1],
				[-1, -2, "northwestcourtyard", -4, "northcourtyard", -4, "northeastcourtyard", -2, -1],
				[-1, -2, -3, -2, -1, -2, -3, -2, -1],
				[-1, -4, "northwestwalk", -2, -1, -2, "northeastwalk", -4, -1],
				[-1, -2, -3, -2, -1, -2, -3, -2, -1],
				[-1, -2, "westwalk", -4, "courtyardsquare", -4, "eastwalk", -2, -1],
				[-1, -2, -3, -2, -1, -2, -3, -2, -1],
				[-1, -2, "southwestwalk", -2, -1, -2, "southeastwalk", -2, -1],
				[-1, -2, -3, -2, -1, -2, -3, -2, -1],
				[-1, -4, "southwestcourtyard", -4, "southcourtyard", -4, "southeastcourtyard", -4, -1],
				[-1, -2, -1, -2, -3, -2, -3, -2, -1],
				[-1, -2, -1, -2, "northentry", -2, "greatlift", -2, -1],
				[-1, -2, -1, -2, -3, -2, -1, -2, -1],
				[-1, -2, -1, -4, "edgeofkeep", -2, -1, -2, -1]];
			//Desert Cave
			MAP_DESERTCAVE = [
				"Cave of the Sand Witches",
				[-1, -2, -1, -2, 38, -2, -1, -2, -1],
				[-1, -2, -1, -2, -3, -2, -1, -2, -1],
				[29, -2, 26, -2, 37, -2, 32, -4, 33],
				[-3, -2, -3, -2, d4, -2, -3, -2, -2],
				[28, -4, 25, -4, 24, -4, 31, -4, 34],
				[-3, -2, -3, -2, -3, -2, -2, -2, -3],
				[30, -2, 27, -2, 23, -2, 36, -4, 35],
				[-1, -2, -1, -2, -3, -2, -1, -2, -1]];
			//Phoenix Tower
			MAP_PHOENIXTOWER_B1 = [
				"Tower of the Phoenix, Basement",
				[-1, -2, 20],
				[-1, -2, -1],
				[-1, -2, 18]];
			MAP_PHOENIXTOWER_F1 = [
				"Tower of the Phoenix, Floor 1",
				[-1, -2, 19],
				[-1, -2, -3],
				[-1, -2, 17],
				[-1, -2, -3]];
			MAP_PHOENIXTOWER_F2 = [
				"Tower of the Phoenix, Floor 2",
				[-1, -2, 21],
				[-1, -2, -1],
				[-1, -2, -1]];
			MAP_PHOENIXTOWER_F3 = [
				"Tower of the Phoenix, Floor 3",
				[-1, -2, 22],
				[-1, -2, -1],
				[-1, -2, -1]];
			//Anzu's Palace
			MAP_ANZUPALACE_B1 = [
				"Anzu's Palace, Basement",
				[-1, -2, -1, -2, -1],
				[-1, -2, -1, -2, -1],
				[54, -4, 53, -2, -1]];
			MAP_ANZUPALACE_F1 = [
				"Anzu's Palace, Floor 1",
				[42, -2, -1, -2, 44],
				[-3, -2, -1, -2, -3],
				[41, -4, 40, -4, 43],
				[-1, -2, -3, -2, -1],
				[-1, -2, 39, -2, -1],
				[-1, -2, -3, -2, -1]];
			MAP_ANZUPALACE_F2 = [
				"Anzu's Palace, Floor 2",
				[-1, -2, 48, -2, -1],
				[-1, -2, -3, -2, -1],
				[46, -4, 45, -4, 47]];
			MAP_ANZUPALACE_F3 = [
				"Anzu's Palace, Floor 3",
				[-1, -2, -1, -2, -1],
				[-1, -2, -1, -2, -1],
				[50, -4, 49, -4, 51]];
			MAP_ANZUPALACE_F4 = [
				"Anzu's Palace, Roof",
				[-1, -2, -1, -2, -1],
				[-1, -2, -1, -2, -1],
				[-1, -2, 52, -2, -1]];
			//Hellhound Master Dungeon
			MAP_HELLHOUNDLABS = [
				"Hellhound Labs",
				[]];
			//Dragon City (Ember Quest)
			MAP_DRAGONCITY_F1 = [
				"Dragon City",
				[-1, -2, 59, -2, -1],
				[-1, -2, -3, -2, -3],
				[57, -4, 58, -2, 61],
				[-3, -2, -3, -2, -3],
				[56, -4, 55, -4, 60],
				[-1, -2, -3, -2, -1]];
			MAP_DRAGONCITY_B1 = [
				"Dragon City, Sewers",
				[-1, -2, 64, -2, -1],
				[-1, -2, -3, -2, -1],
				[62, -4, 63, -2, -1]];
		}

		public function get d1():int { //Door that requires iron key
			return (player.hasKeyItem("Iron Key") >= 0 ? -3 : -5);
		}
		public function get d2():int { //Door that requires supervisors key
			return (player.hasKeyItem("Supervisor's Key") >= 0 ? -3 : -5);
		}
		public function get d3():int { //Door in Zetaz's lair
			return (flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] > 0 ? -3 : -5);
		}
		public function get d4():int { //Door in desert cave
			return (flags[kFLAGS.SANDWITCH_THRONE_UNLOCKED] > 0 ? -3 : -5);
		}
		public function get d5():int {
			return (kGAMECLASS.lethicesKeep.unlockedThroneRoom() ? -3 : -5);
		}

		public function chooseRoomToDisplay():void {
			updateMap();
			if (getGame().inRoomedDungeon) {
			//	if (getGame().inRoomedDungeonName == "GrimdarkMareth") buildMapDisplay(MAP_MARETH);
				if (getGame().inRoomedDungeonName == "BasiliskCave") buildMapDisplay(MAP_STRONGHOLD_P1);
				if (getGame().inRoomedDungeonName == "LethicesKeep") buildMapDisplay(MAP_STRONGHOLD_P2);
			}
			else if (kGAMECLASS.dungeonLoc >= 0 && kGAMECLASS.dungeonLoc < 10) { //Factory
				if (kGAMECLASS.dungeonLoc < 6 || kGAMECLASS.dungeonLoc == 9)
					 buildMapDisplay(MAP_FACTORY_F1);
				else buildMapDisplay(MAP_FACTORY_F2);
			}
			else if (kGAMECLASS.dungeonLoc >= 10 && kGAMECLASS.dungeonLoc < 17) //Zetaz's Lair
				buildMapDisplay(MAP_DEEPCAVE);
			else if (kGAMECLASS.dungeonLoc >= 17 && kGAMECLASS.dungeonLoc < 23) { //Tower of the Phoenix
				switch(kGAMECLASS.dungeonLoc) {
					case 18:
					case 20: buildMapDisplay(MAP_PHOENIXTOWER_B1); break;
					case 17:
					case 19: buildMapDisplay(MAP_PHOENIXTOWER_F1); break;
					case 21: buildMapDisplay(MAP_PHOENIXTOWER_F2); break;
					case 22: buildMapDisplay(MAP_PHOENIXTOWER_F3); break;
					default: buildMapDisplay(MAP_PHOENIXTOWER_F1);
				}
			}
			else if (kGAMECLASS.dungeonLoc >= 23 && kGAMECLASS.dungeonLoc < 39) //Desert Cave
				buildMapDisplay(MAP_DESERTCAVE);
			else if (kGAMECLASS.dungeonLoc >= 39 && kGAMECLASS.dungeonLoc < 55) { //Anzu's Palace
				if (kGAMECLASS.dungeonLoc >= 39 && kGAMECLASS.dungeonLoc <= 44) buildMapDisplay(MAP_ANZUPALACE_F1);
				if (kGAMECLASS.dungeonLoc >= 45 && kGAMECLASS.dungeonLoc <= 48) buildMapDisplay(MAP_ANZUPALACE_F2);
				if (kGAMECLASS.dungeonLoc >= 49 && kGAMECLASS.dungeonLoc <= 51) buildMapDisplay(MAP_ANZUPALACE_F3);
				if (kGAMECLASS.dungeonLoc == 52) buildMapDisplay(MAP_ANZUPALACE_F4);
				if (kGAMECLASS.dungeonLoc == 53 || kGAMECLASS.dungeonLoc == 54) buildMapDisplay(MAP_ANZUPALACE_B1);
			}
			else if (kGAMECLASS.dungeonLoc >= 55 && kGAMECLASS.dungeonLoc < 65) { //Dragon City
				if (kGAMECLASS.dungeonLoc < 62)
					 buildMapDisplay(MAP_DRAGONCITY_F1);
				else buildMapDisplay(MAP_DRAGONCITY_B1);
			}
		}

		public function buildMapDisplay(map:Array):void {
			displayHeader(map[0] + "\n");
			outputText("<font face=\"Consolas, _typewriter\">");
			for (var i:int = 1; i < map.length; i++) {
				for (var j:int = 0; j < map[i].length; j++) {
					//Negative numbers are special
					if (map[i][j] is int && map[i][j] < 0) {
						switch(map[i][j]) {
							case -1: rawOutputText("   "); break;
							case -2: rawOutputText(" "); break;
							case -3: rawOutputText(" | "); break;
							case -4: rawOutputText("—"); break;
							case -5: rawOutputText(" L "); break;
							case -6: rawOutputText("L"); break;
						}
					}
					else if (getGame().inDungeon && map[i][j] is int && map[i][j] >= 0) {
						switch(map[i][j]) {
							case getGame().dungeonLoc: rawOutputText("[<u>@</u>]"); break;
							case 05:
							case 18:
							case 20:
							case 53: rawOutputText("[<u>^</u>]"); break;
							case 06:
							case 17:
							case 22:
							case 52: rawOutputText("[<u>v</u>]"); break;
							case 19:
							case 21:
							case 40:
							case 45:
							case 49: rawOutputText("[<u>↕</u>]"); break;
							default: rawOutputText("[<u> </u>]");
						}
					}
					else if (getGame().inRoomedDungeon) {
						if (getGame().dungeons._currentRoom == map[i][j])
							 rawOutputText("[<u>@</u>]");
						else rawOutputText("[<u> </u>]");
					}
				} rawOutputText("\n");
			} outputText("</font>");
		}

		public function displayMap():void {
			clearOutput();
			chooseRoomToDisplay();
			outputText("\n\n<b><u>Legend</u></b>");
			outputText("\n<font face=\"Consolas, _typewriter\">@</font> — Player Location");
			outputText("\n<font face=\"Consolas, _typewriter\">L</font> — Locked Door");
			outputText("\n<font face=\"Consolas, _typewriter\">^v↕</font> — Stairs");
			menu();
			addButton(0, "Close Map", playerMenu);
		}
	}
}
