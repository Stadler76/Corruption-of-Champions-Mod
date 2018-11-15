/**
 * Created by aimozg on 31.01.14.
 */
package classes.StatusEffects
{
import classes.StatusEffect;
import classes.StatusEffectType;

public class CombatStatusEffect extends StatusEffect
{

	public function CombatStatusEffect(stype:StatusEffectType)
	{
		super(stype);
	}

	override public function onCombatEnd():void {
		remove();
	}
}
}
