package classes {

import classes.helper.DummyOutputTest;
import classes.helper.FireButtonEventTest;
import classes.helper.MemoryLogTargetTest;
import classes.helper.StageLocatorTest;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
	public class HelperSuite
	{
		 public var stageLocatorTest:StageLocatorTest;
		 public var memoryLogTargetTest:MemoryLogTargetTest;
		 public var fireButtonEventTest:FireButtonEventTest;
		 public var dummyOutputTest:DummyOutputTest;
	}
}
