package classes.Perks 
{
	import classes.Perk;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.CharCreation;
	
	public class AscensionWisdomPerk extends PerkType
	{
		
		override public function desc(params:Perk = null):String
		{
			return "(Rank: " + params.value1 + "/" + CharCreation.MAX_WISDOM_LEVEL + ") Increases experience gained in battles by " + params.value1 * 10 + "%.";
		}

		public function AscensionWisdomPerk() 
		{
			super("Ascension: Wisdom", "Ascension: Wisdom", "", "Increases experience gains by 10% per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}
