package classes.StatusEffects.Combat {
import classes.PerkLib;
import classes.StatusEffectType;

public class NagaVenomDebuff extends CombatBuff {

	public static const TYPE:StatusEffectType = register("Naga Venom",NagaVenomDebuff);
	public function NagaVenomDebuff() {
		super(TYPE,'spe');
	}

	override protected function apply(first:Boolean):void {
		var debuff:* = buffHost('spe',first?-3:-2);
		if (debuff.spe == 0) host.takeDamage(5+rand(5));
		host.takeDamage(5+rand(5));
	}

	override public function onCombatRound():void {
		//Chance to cleanse!
		if (host.hasPerk(PerkLib.Medicine) && rand(100) <= 14) {
			if (playerHost) game.outputText("You manage to cleanse the naga venom from your system with your knowledge of medicine!\n\n");
			remove();
			return;
		}
		var debuff:* = buffHost('spe',-2);
		if (debuff.spe == 0) host.takeDamage(5);
		host.takeDamage(2);
		if (playerHost) game.outputText("You wince in pain and try to collect yourself, the naga's venom still plaguing you.\n\n");
	}
}

}