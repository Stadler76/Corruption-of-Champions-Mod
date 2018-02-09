package classes.Items.Shields 
{
	import classes.Items.Shield;

	public class KiteShield extends Shield
	{
		public function KiteShield(tier:int) 
		{
			var ids:Array = ["Kite Sh", "KiteSh1", "KiteSh2"];
			var eqptNames:Array = ["kiteshield", "fine kiteshield", "masterwork kiteshield"];
			var longNames:Array = ["a kiteshield", "a fine kiteshield", "a masterwork kiteshield"];
			this.weightCategory = Shield.WEIGHT_MEDIUM;
			super(ids[tier], "KiteShld", eqptNames[tier], longNames[tier], 10, 300, "A teardrop-shaped kiteshield made of durable wood.");
		}
		
	}

}