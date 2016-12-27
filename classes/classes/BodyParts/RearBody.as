package classes.BodyParts 
{
	/**
	 * Container class for the players rear body
	 * @since December 20, 2016
	 * @author Stadler76
	 */
	public class RearBody 
	{
		include "../../../includes/appearanceDefs.as";

		public var type:Number = REAR_BODY_NONE;
		public var color:String = "";

		public function RearBody() {}

		public function restore():RearBody
		{
			type  = REAR_BODY_NONE;
			color = "";

			return this;
		}

		public function setProps(p:Object):RearBody
		{
			if (p.hasOwnProperty('type'))  type  = p.type;
			if (p.hasOwnProperty('color')) color = p.color;

			return this;
		}

		public function setAllProps(p:Object):RearBody
		{
			restore();
			setProps(p);
			return this;
		}
	}
}
