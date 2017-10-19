/**
 * Coded by aimozg on 24.08.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class MightBuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Might",MightBuff);
	public function MightBuff() {
		super(TYPE,'str','tou');
	}

	override protected function apply(firstTime:Boolean):void {
		var buff:Number = 10 * host.spellMod();
		if (buff > 100) buff = 100;
		buffHost('str',buff,'tou',buff,'scale',false,'max',false);
	}

}
}
