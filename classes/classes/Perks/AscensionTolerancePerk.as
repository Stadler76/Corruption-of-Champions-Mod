package classes.Perks 
{
	import classes.Perk;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.CharCreation;
	
	public class AscensionTolerancePerk extends PerkType
	{
		
		override public function desc(params:Perk = null):String
		{
			return "(Rank: " + params.value1 + "/" + CharCreation.MAX_TOLERANCE_LEVEL + ") Increases corruption tolerance by " + params.value1 * 5 + " and reduces corruption requirement by " + params.value1 * 5 + ".";
		}
		
		public function AscensionTolerancePerk() 
		{
			super("Ascension: Corruption Tolerance", "Ascension: Corruption Tolerance", "", "Increases corruption tolerance by 5 per level and reduces corruption requirement by 5 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}
