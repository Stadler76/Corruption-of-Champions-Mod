package classes 
{
	import classes.internals.LoggerFactory;
	import mx.logging.ILogger;
	/**
	 * ...
	 * @author Fake-Name
	 */
	public class CoC_Settings
	{
		private static const LOGGER:ILogger = LoggerFactory.getLogger(CoC_Settings);

		public static const debugBuild:Boolean = CONFIG::debug;
		public static const charviewEnabled:Boolean = CONFIG::debug;

		// Horrible static abuse FTW
		public static const haltOnErrors:Boolean = false;
		private static const bufferSize:int = 50;

		/**
		 * trace("ERROR "+description);
		 * If haltOnErrors=true, throws Error
		 */
		public static function error(description:String=""):void {
			LOGGER.error("ERROR "+description);
			if (haltOnErrors) throw Error(description);
		}

		/**
		 * trace("ERROR Abstract method call: "+clazz+"."+method+"(). "+description);
		 * If haltOnErrors=true, throws Error
		 */
		public static function errorAMC(clazz:String,method:String,description:String=""):void{
			error("Abstract method call: "+clazz+"."+method+"(). "+description);
		}
		
		public function CoC_Settings()
		{

		}
		
	}

}