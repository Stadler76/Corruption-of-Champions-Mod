/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class EldritchStaff extends WeaponWithPerk
	{
		public function EldritchStaff()
		{
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			super(new WeaponWithPerkBuilder()
				.id("E.Staff")
				.shortName("E.Staff")
				.name("eldritch staff")
				.longName("an eldritch staff")
				.verb("thwack")
				.attack(10)
				.value(1000)
				.description("This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands."
				            +" It fairly sizzles with magical power.")
				.perk("Wizard's Focus")
				.playerPerk(PerkLib.WizardsFocus, 0.6, 0, 0, 0)
			);
		}

		override public function get verb():String
		{ 
			return game.player.findPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "thwack"; 
		}
	}
}
