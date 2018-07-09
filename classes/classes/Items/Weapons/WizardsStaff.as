/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class WizardsStaff extends WeaponWithPerk
	{
		public function WizardsStaff()
		{
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			super(new WeaponWithPerkBuilder()
				.id("W.Staff")
				.shortName("W. Staff")
				.name("wizard's staff")
				.longName("a wizard's staff")
				.verb("smack")
				.attack(3)
				.value(350)
				.description("This staff is made of very old wood and seems to tingle to the touch."
				            +" The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use."
				            +" It probably belonged to a wizard at some point and would aid magic use.")
				.perk("Wizard's Focus")
				.playerPerk(PerkLib.WizardsFocus, 0.4, 0, 0, 0)
			);
		}

		override public function get verb():String
		{ 
				return game.player.findPerk(PerkLib.StaffChanneling) >= 0 ? "shot" : "smack"; 
		}
	}
}
