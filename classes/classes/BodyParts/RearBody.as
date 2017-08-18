package classes.BodyParts 
{
	import classes.Creature;

	/**
	 * Container class for the players rear body
	 * @since December 20, 2016
	 * @author Stadler76
	 */
	public class RearBody extends BaseBodyPart
	{
		include "../../../includes/appearanceDefs.as";

		public var type:Number = REAR_BODY_NONE;
		public var color:String = "no";

		public function RearBody() {}

		public function restore():void
		{
			type  = REAR_BODY_NONE;
			color = "no";
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type'))  type  = p.type;
			if (p.hasOwnProperty('color')) color = p.color;
		}

		public function setAllProps(p:Object):void
		{
			restore();
			setProps(p);
		}

		override public function canDye():Boolean
		{
			return type == REAR_BODY_DRACONIC_MANE;
		}

		override public function hasDyeColor(_color:String):Boolean
		{
			return color == _color;
		}

		override public function applyDye(_color:String):void
		{
			color = _color;
		}

		public function toObject():Object
		{
			return {
				type:  type,
				color: color
			};
		}
	}
}
