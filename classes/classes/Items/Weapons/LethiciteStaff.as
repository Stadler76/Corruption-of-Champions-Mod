/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class LethiciteStaff extends WeaponWithPerk
	{
		public function LethiciteStaff()
		{
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			super(new WeaponWithPerkBuilder()
				.id("L.Staff")
				.shortName("Lthc. Staff")
				.name("lethicite staff")
				.longName("a lethicite staff")
				.verb("smack")
				.attack(14)
				.value(1337)
				.description("This staff is made of a dark material and seems to tingle to the touch. The top consists of a glowing lethicite orb."
				            +" Somehow you know this will greatly empower your spellcasting abilities.")
				.perk("Wizard's Focus")
				.playerPerk(PerkLib.WizardsFocus, 0.8, 0, 0, 0)
			);
		}

		override public function get verb():String
		{ 
			return game.player.findPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "smack"; 
		}
		
		override public function playerEquip():Weapon
		{
			while (game.player.findPerk(PerkLib.WizardsFocus) >= 0) game.player.removePerk(PerkLib.WizardsFocus);
			game.player.createPerk(PerkLib.WizardsFocus, 0.8, 0, 0, 0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon
		{
			while (game.player.findPerk(PerkLib.WizardsFocus) >= 0) game.player.removePerk(PerkLib.WizardsFocus);
			return super.playerRemove();
		}
	}
}
