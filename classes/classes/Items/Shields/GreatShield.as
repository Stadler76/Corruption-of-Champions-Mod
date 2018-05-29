package classes.Items.Shields 
{
	import classes.Items.Shield;

	public class GreatShield extends Shield
	{
		public function GreatShield(tier:int) 
		{
			var ids:Array = ["GreatSh", "GrtShl1", "GrtShl2"];
			var eqptNames:Array = ["greatshield", "fine greatshield", "masterwork greatshield"];
			var longNames:Array = ["a greatshield", "a fine greatshield", "a masterwork greatshield"];
			this.weightCategory = Shield.WEIGHT_MEDIUM;
			this.tier = tier;
			super(ids[tier], "GreatShld", eqptNames[tier], longNames[tier], 10, 300, "A large, rectangular metal shield. It's a bit heavy.");
		}
		
	}

}