package classes.Items.Shields 
{
	import classes.Items.Shield;
	
	public class TowerShield extends Shield
	{
		public function TowerShield(tier:int)
		{
			var ids:Array = ["TowerSh", "TowerS1", "TowerS2"];
			var eqptNames:Array = ["tower shield", "fine tower shield", "masterwork tower shield"];
			var longNames:Array = ["a tower shield", "a fine tower shield", "a masterwork tower shield"];
			this.weightCategory = Shield.WEIGHT_HEAVY;
			this.tier = tier;
			super(ids[tier], "TowerShld", eqptNames[tier], longNames[tier], 16, 500, "A towering metal shield. It looks heavy! The weight of this shield might incite some penalties to accuracy.");
		}
		
		override public function canUse():Boolean {
			if (game.player.str >= 40) return true;
			outputText("This shield is too heavy for you to hold effectively. Perhaps you should try again when you have at least 40 strength?");
			return false;
		}
	}

}