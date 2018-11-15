package classes.Perks 
{
	import classes.Perk;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class MilkMaidPerk extends PerkType
	{
		
		override public function desc(params:Perk = null):String
		{
			return "(Rank: " + params.value1 + "/10) Increases milk production by " + (200 + (params.value1 * 100)) + "mL.";
		}
		
		public function MilkMaidPerk() 
		{
			super("Milk Maid", "Milk Maid", "Increases milk production by ---mL. Allows you to lactate perpetually.");
		}
	}
}
