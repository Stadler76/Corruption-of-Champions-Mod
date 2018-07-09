/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Spellblade extends WeaponWithPerk
	{
		public function Spellblade()
		{
			this.weightCategory = Weapon.WEIGHT_MEDIUM;
			super(new WeaponWithPerkBuilder()
				.id("S.Blade")
				.shortName("S.Blade")
				.name("inscribed spellblade")
				.longName("a spellblade")
				.verb("slash")
				.attack(8)
				.value(500)
				.description("Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic."
				            +" Unlike the wizard staves it is based on, this weapon also has a sharp edge,"
				            +" a technological innovation which has proven historically useful in battle.")
				.perk("Wizard's Focus")
				.playerPerk(PerkLib.WizardsFocus, 0.5, 0, 0, 0)
			);
		}
	}
}
