package classes {
	import classes.Items.ArmorsSuite;
	import classes.Items.ConsumableTest;
	import classes.Items.ConsumablesSuite;
	import classes.Items.MutationsTest;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
	public class ItemsSuite
	{
		 public var mutationsTest:MutationsTest;
		 public var consumableTest:ConsumableTest;
		 public var armorsSuite:ArmorsSuite;
		 public var consumablesSuite:ConsumablesSuite;
	}
}
