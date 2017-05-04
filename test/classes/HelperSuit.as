package classes {

import classes.helper.FireButtonEventTest;
import classes.helper.MemoryLogTargetTest;
import classes.helper.StageLocatorTest;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
	public class HelperSuit
	{
		 public var stageLocatorTest:StageLocatorTest;
		 public var memoryLogTargetTest:MemoryLogTargetTest;
		 public var fireButtonEventTest:FireButtonEventTest;
	}
}
