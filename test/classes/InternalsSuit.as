package classes {
	import classes.helper.MemoryLogTarget;
	import classes.helper.MemoryLogTargetTest;
	import classes.internals.LoggerFactoryTest;
	import classes.internals.SerializationUtilTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalsSuit
	{
		public var loggerFactoryTest:LoggerFactoryTest;
		public var serializationUtilTest:SerializationUtilTest;
	}
}
