package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class AnemoneVenomDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Anemone Venom",AnemoneVenomDebuff);
	public function AnemoneVenomDebuff() {
		super(TYPE,'str','spe');
	}

	public function applyEffect(str:Number):void {
		host.takeLustDamage((2 * str), true);
		buffHost('str', -str,'spe',-str);
	}
}

}
