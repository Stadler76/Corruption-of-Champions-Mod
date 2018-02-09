/**
 * ...
 * @author Melchi ...
 */
package classes.Items.Shields 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Shield;
	import classes.Player;
	
	public class WoodenShield extends Shield
	{
		
		public function WoodenShield() 
		{
			this.weightCategory = Shield.WEIGHT_LIGHT;
			super("WoodShl", "WoodShld", "wood shield", "a wooden shield", 6, 10, "A crude wooden shield. It doesn't look very sturdy");
		}
		
	}

}