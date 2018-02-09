package classes.Items.Shields 
{
	import classes.ItemType;
	import classes.Items.Shield;
	import classes.Player;
	
	public class Nothing extends Shield
	{
		public function Nothing()
		{
			this.weightCategory = Shield.WEIGHT_LIGHT;
			super("noshild", "noshield", "nothing", "nothing", 0, 0, "no shield", "shield");
		}
		
		override public function playerRemove():Shield {
			return null; //There is nothing!
		}
	}
}