/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Shields
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Shield;
	import classes.Player;

	public class DragonShellShield extends Shield {
		
		public function DragonShellShield(upgraded:Boolean) {
			var id:String = upgraded ? "RDgnShl" : "DrgnShl";
			var sname:String = upgraded ? "RDgnShl" : "DrgnShl";
			var ename:String = upgraded ? "runed dragon-shell shield" : "dragon-shell shield";
			var lname:String = upgraded ? "a dragon-shell shield with rune markings" : "a dragon-shell shield";
			var tier:int = upgraded ? 1 : 0;
			this.weightCategory = Shield.WEIGHT_MEDIUM;
			super(id, sname, ename, lname, 14, 1500, "", Shield.PERK_ABSORPTION);
		}
		
		override public function get shortName():String { //Don't display +1 for runed shield.
			return _shortName;
		}
		
		override public function get description():String {
			var desc:String = game.flags[kFLAGS.EMBER_HATCHED] > 0 ? "A durable shield that has been forged from the dragon eggshell Ember gave you for maxing out " + game.emberScene.emberMF("his", "her") + " affection." : "A durable shield that has been forged from the remains of the dragon egg you found in the swamp.";
			desc += " Absorbs any fluid attacks you can catch, rendering them useless.";
			if (tier > 0) desc += " This shield has since been enhanced and now intricate glowing runes surround the edges in addition to more imposing spiky appearance.";
			//Type
			desc += "\n\nType: Shield";
			//Block Rating
			desc += "\nBlock: " + String(block);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void { //Produces any text seen when equipping the armor normally
			if (game.flags[kFLAGS.TIMES_EQUIPPED_EMBER_SHIELD] == 0) {
				clearOutput();
				outputText("Turning the sturdy shield over in inspection, you satisfy yourself as to its craftsmanship and adjust the straps to fit your arm snugly.  You try a few practice swings, but find yourself overbalancing at each one due to the deceptive lightness of the material.  Eventually, though, you pick up the knack of putting enough weight behind it to speed it through the air while thrusting a leg forward to stabilize yourself, and try bashing a nearby rock with it.  You smile with glee as ");
				if (game.player.str < 80) outputText("bits and pieces from the surface of the");
				else outputText("huge shards of the shattered");
				outputText(" rock are sent flying in all directions.");
				outputText("\n\nAfter a few more practice bashes and shifts to acquaint yourself with its weight, you think you're ready to try facing an enemy with your new protection.  One last thing... taking off the shield and turning it straps-down, you spit onto the surface.  Satisfyingly, the liquid disappears into the shell as soon as it touches.");
			}
			else {
				outputText("You equip " + this.longName + ".  ");
			}
			game.flags[kFLAGS.TIMES_EQUIPPED_EMBER_SHIELD]++;
		}
		
	}
}
