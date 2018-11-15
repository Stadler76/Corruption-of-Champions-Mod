package classes.Perks 
{
	import classes.Perk;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.CharCreation;
	
	public class AscensionMysticalityPerk extends PerkType
	{
		
		override public function desc(params:Perk = null):String
		{
			return "(Rank: " + params.value1 + "/" + CharCreation.MAX_MYSTICALITY_LEVEL + ") Increases spell effect multiplier by " + params.value1 * 5 + "% multiplicatively.";
		}

		public function AscensionMysticalityPerk() 
		{
			super("Ascension: Mysticality", "Ascension: Mysticality", "", "Increases spell effect multiplier by 5% per level, multiplicatively.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}
