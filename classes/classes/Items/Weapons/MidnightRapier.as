package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;

	public class MidnightRapier extends Weapon {
		
		public function MidnightRapier() {
			this.weightCategory = Weapon.WEIGHT_LIGHT;
			super("MRapier", "MRapier", "midnight rapier", "a midnight rapier", "slash", 15, 1600, "This rapier is forged from a metal that is as dark as a starless night. Its blade shows some signs of use, but its power is no less tremendous.", "midnightRapier");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2);
			else boost += 4 + (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (15 + boost); 
		}

	}
}
