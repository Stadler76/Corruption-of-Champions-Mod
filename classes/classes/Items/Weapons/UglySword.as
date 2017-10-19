package classes.Items.Weapons
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;
	import classes.Player;

	public class UglySword extends Weapon {
		
		public function UglySword() {
			super("U.Sword", "U.Sword", "ugly sword", "an ugly sword", "slash", 7, 400, "This ugly sword is jagged and chipped, yet somehow perfectly balanced and unnaturally sharp. Its blade is black, and its material is of dubious origin.", "uglySword");
		}
		
		override public function get attack():Number { 
			var temp:int = 7 + int((game.player.corAdjustedUp() - 70) / 3)
			if (temp < 5) temp = 5;
			return temp; 
		}
		
		override public function canUse():Boolean {
			if (game.player.isCorruptEnough(70)) return true;
			outputText("You grab hold of the handle of the sword only to have it grow burning hot. You're forced to let it go lest you burn yourself. Something within the sword must be disgusted. ");
			return false;
		}
	}
}
