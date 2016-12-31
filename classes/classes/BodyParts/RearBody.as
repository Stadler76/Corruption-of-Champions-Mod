package classes.BodyParts 
{
	import classes.Creature;

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
		public var skin:Skin;

		private var _creature:Creature;

		public function RearBody(i_creature:Creature)
		{
			skin = new Skin(i_creature);
			_creature = i_creature;
		}

		public function restore():RearBody
		{
			type  = REAR_BODY_NONE;
			color = "";
			skin.restore();

			return this;
		}

		public function setProps(p:Object):RearBody
		{
			if (p.hasOwnProperty('type'))  type  = p.type;
			if (p.hasOwnProperty('color')) color = p.color;
			if (p.hasOwnProperty('skin'))  skin.setProps(p.skin);

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
