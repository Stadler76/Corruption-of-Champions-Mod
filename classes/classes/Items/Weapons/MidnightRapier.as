package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;

	public class MidnightRapier extends Weapon {
		
		public function MidnightRapier() {
			super("MRapier", "MRapier", "midnight rapier", "a midnight rapier", "slash", 15, 1250, "This rapier is forged from a metal that is as dark as a starless night. Its blade shows some signs of use, but its power is no less tremendous.", "midnightRapier");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2) + ((game.player.corAdjustedUp() - 90) / 3);
			else boost += 4 + (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2) + ((game.player.corAdjustedUp() - 90) / 3);
			return (15 + boost); 
		}
		
		override public function canUse():Boolean {
			if (game.player.isCorruptEnough(90)) return true;
			outputText("You grab hold of the handle of the rapier only to have it grow burning hot. You're forced to let it go lest you burn yourself. Something within the rapier must be disgusted. ");
			return false;
		}
	}
}
