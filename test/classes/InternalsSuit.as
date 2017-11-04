package classes {
	import classes.helper.MemoryLogTarget;
	import classes.helper.MemoryLogTargetTest;
	import classes.internals.LoggerFactoryTest;
	import classes.internals.RandomNumberTest;
	import classes.internals.SerializationUtilTest;
	import classes.internals.UtilsTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalsSuit
	{
		public var loggerFactoryTest:LoggerFactoryTest;
		public var serializationUtilTest:SerializationUtilTest;
		public var utilsTest:UtilsTest;
		public var randomNumberTest:RandomNumberTest;
	}
}
