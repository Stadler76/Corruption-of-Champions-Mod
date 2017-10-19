/**
 * Coded by aimozg on 24.08.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class AmilyVenomDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Amily Venom",AmilyVenomDebuff);
	public function AmilyVenomDebuff() {
		super(TYPE,'str','spe');
	}

	override protected function apply(firstTime:Boolean):void {
		buffHost('str', -2 - rand(5),'spe', -2 - rand(5));
	}
}
}
