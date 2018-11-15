package classes {
	import classes.helper.MemoryLogTarget;
	import classes.helper.MemoryLogTargetTest;
	import classes.internals.LoggerFactoryTest;
	import classes.internals.ActionScriptRNGTest;
	import classes.internals.SerializationUtilTest;
	import classes.internals.UtilsTest;
	import classes.internals.PregnancyUtilsTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalsSuite
	{
		public var loggerFactoryTest:LoggerFactoryTest;
		public var serializationUtilTest:SerializationUtilTest;
		public var utilsTest:UtilsTest;
		public var actionScriptRNGTest:ActionScriptRNGTest;
		public var pregnancyUtilsTest:PregnancyUtilsTest;
	}
}
