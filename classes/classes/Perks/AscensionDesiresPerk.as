package classes.Perks 
{
	import classes.Perk;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.CharCreation;
	
	public class AscensionDesiresPerk extends PerkType
	{
		
		override public function desc(params:Perk = null):String
		{
			return "(Rank: " + params.value1 + "/" + CharCreation.MAX_DESIRES_LEVEL + ") Increases maximum lust by " + params.value1 * 5 + ".";
		}
		
		public function AscensionDesiresPerk() 
		{
			super("Ascension: Desires", "Ascension: Desires", "", "Increases maximum lust by 5 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}
