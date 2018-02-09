package classes.BodyParts 
{
	/**
	 * ...
	 * @since August 06, 2017
	 * @author Stadler76
	 */
	public class BaseBodyPart 
	{
		public function canDye():Boolean
		{
			return false;
		}

		public function hasDyeColor(_color:String):Boolean
		{
			return true;
		}

		public function applyDye(_color:String):void {}

		public function canOil():Boolean
		{
			return false;
		}

		public function hasOilColor(_color:String):Boolean
		{
			return true;
		}

		public function applyOil(_color:String):void {}
	}
}
