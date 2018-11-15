package classes.Perks
{
	import classes.Perk;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;

	public class ControlledBreathPerk extends PerkType
	{

		override public function desc(params:Perk = null):String
		{
			if (!player.isPureEnough(30)) return "<b>DISABLED</b> - Corruption too high!";
			else return super.desc(params);
		}

		public function ControlledBreathPerk()
		{
			super("Controlled Breath", "Controlled Breath", "Jojo’s training allows you to recover more quickly. Increases rate of fatigue regeneration by 10%");
		}
	}
}
