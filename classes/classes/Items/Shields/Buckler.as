package classes.Items.Shields 
{
	import classes.Items.Shield;

	public class Buckler extends Shield
	{
		public function Buckler(tier:int) 
		{
			var ids:Array = ["Buckler", "Bucklr1", "Bucklr2"];
			var eqptNames:Array = ["wooden buckler", "fine buckler", "masterwork buckler"];
			var longNames:Array = ["a wooden buckler", "a fine, reinforced buckler", "a masterwork, metal buckler"];
			this.weightCategory = Shield.WEIGHT_LIGHT;
			this.tier = tier;
			super(ids[tier], "Buckler", eqptNames[tier], longNames[tier], 6, 50, "A small, " + (tier < 2 ? tier == 1 ? "reinforced, wooden" : "wooden" : "metal") + " rounded shield that's light and easy to hold. Doesn't offer much protection but it's better than nothing.");
		}
		
	}

}