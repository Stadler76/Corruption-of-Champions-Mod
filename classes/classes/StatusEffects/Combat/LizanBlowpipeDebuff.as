/**
 * Coded by aimozg on 01.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class LizanBlowpipeDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Lizan Blowpipe", LizanBlowpipeDebuff);
	public function LizanBlowpipeDebuff() {
		super(TYPE, 'str', 'tou', 'spe', 'sens');
	}
	public function debuffStrSpe():void {
		var power:Number = 5;
		if (!host.isPureEnough(50)) {
			power = 10;
		}
		buffHost('str', -power, 'spe', -power);
	}
	public function debuffTouSens():void {
		var power:Number = 5;
		if (!host.isPureEnough(50)) {
			power = 10;
		}
		buffHost('tou', -power, 'sens', power);
	}
}

}
