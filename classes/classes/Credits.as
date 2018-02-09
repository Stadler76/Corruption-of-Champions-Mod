package classes 
{
	import classes.GlobalFlags.kGAMECLASS;
	import flash.text.TextField;

	 /**
	 * Class to handle the credits box
	 * @since  22.12.2017
	 * @author Stadler76
	 */
	public class Credits 
	{
		public var headline:String = 'Scene by:';
		public var authorText:String = '';

		private static var _instance:Credits = new Credits();

		public function Credits()
		{
			if (_instance != null)
			{
				throw new Error("Credits can only be accessed through Credits.init()");
			}
		}

		public static function init():Credits { return _instance; }

		protected function get creditsBox():TextField
		{
			return kGAMECLASS.mainView.creditsBox;
		}

		public function show():void
		{
			if (authorText === '')
				return;

			creditsBox.htmlText = '<font face="Georgia"><b>' + headline + '</b></font>\n' + authorText;
		}

		public function clear():void
		{
			creditsBox.htmlText = '';
			headline = 'Scene by:';
			authorText = '';
		}
	}
}