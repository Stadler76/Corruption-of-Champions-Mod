/**
 * Coded by aimozg on 01.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.PerkLib;
import classes.StatusEffectType;

public class DriderIncubusVenomDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Drider Incubus Venom",DriderIncubusVenomDebuff);
	public function DriderIncubusVenomDebuff() {
		super(TYPE,'str');
	}

	override protected function apply(firstTime:Boolean):void {
		// -5 perm -30 temp
		host.dynStats('str',-5);
		buffHost('str',-30);
	}
	override public function onCombatRound():void {
		//Chance to cleanse!
		if (host.findPerk(PerkLib.Medicine) >= 0 && rand(100) <= 14) {
			if (playerHost) game.outputText("You manage to cleanse the drider incubus venom from your system with your knowledge of medicine!\n\n");
			remove();
		}
	}
}

}
