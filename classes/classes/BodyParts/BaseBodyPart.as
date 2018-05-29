package classes.BodyParts 
{
	/**
	 * ...
	 * @since August 06, 2017
	 * @author Stadler76
	 */
	public class BaseBodyPart 
	{
		public static const COLOR_ID_MAIN:int = 1;
		public static const COLOR_ID_2ND:int  = 2;

		public function getColorDesc(id:int):String
		{
			return "";
		}

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

		public function canOil2():Boolean
		{
			return false;
		}

		public function hasOil2Color(_color2:String):Boolean
		{
			return true;
		}

		public function applyOil2(_color2:String):void {}
	}
}
