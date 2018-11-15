package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	import classes.Cock;
	import classes.CockTypesEnum;
	import classes.internals.SerializationUtils;
	
	public class CockTest {
		private static const DEFAULT_COCK_TYPE:CockTypesEnum = CockTypesEnum.HUMAN;
		private static const DEFAULT_COCK_LENGTH:Number = 5.5;
		private static const DEFAULT_COCK_THICKNESS:Number = 1;
		private static const DEFAULT_KNOT_MULTIPLIER:Number = 1;
		
		private static const TEST_SOCK:String = "testSock";
		private static const PIERCING:int = 42;
		private static const PIERCING_DESCRIPTION:String = "piercing description";
		private static const PIERCING_NO_DESCRIPTION:String = "null";

		private static const COCK_LENGTH:Number = 12.3;
		private static const COCK_THICKNESS:Number= 3.21;
		private static const KNOT_MULTIPLIER:Number = 2.3;
		
		private var cut:Cock;
		private var serializedClass:*;

		[Before]
		public function setUp():void {
			cut = new Cock();
			
			serializedClass = [];
		}
		
		[Test] 
		public function testDefaultHumanCockType():void {
			assertThat(cut.cockType, equalTo(DEFAULT_COCK_TYPE));
		}
		
		[Test] 
		public function testDefaultLength():void {
			assertThat(cut.cockLength, equalTo(DEFAULT_COCK_LENGTH));
		}
		
		[Test] 
		public function testDefaultThickness():void {
			assertThat(cut.cockThickness, equalTo(DEFAULT_COCK_THICKNESS));
		}
		
		[Test] 
		public function testDefaultNotPierced():void {
			assertThat(cut.isPierced, equalTo(false));
		}
		
		[Test] 
		public function testDefaultKnotMultiplier():void {
			assertThat(cut.knotMultiplier, equalTo(DEFAULT_KNOT_MULTIPLIER));
		}
		
		[Test]
		public function deserializeUpgradeNoSock():void {
			serializedClass.sock = undefined;
			
			cut.upgradeSerializationVersion(serializedClass, 0);
			
			assertThat(cut.sock, equalTo(""));
		}
		
		[Test]
		public function deserializeUpgradeSock():void {
			serializedClass.sock = TEST_SOCK;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.sock, equalTo(TEST_SOCK));
		}
		
		[Test]
		public function deserializeUpgradeNoPiercingDescriptionShort():void {
			serializedClass.pShortDesc = PIERCING_NO_DESCRIPTION;
			
			cut.upgradeSerializationVersion(serializedClass, 0);
			
			assertThat(cut.pShortDesc, equalTo(""));
		}
		
		[Test]
		public function deserializeUpgradePiercingDescriptionShort():void {
			serializedClass.pShortDesc = PIERCING_DESCRIPTION;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.pShortDesc, equalTo(PIERCING_DESCRIPTION));
		}
		
		[Test]
		public function deserializeUpgradeNoPiercingDescriptionLong():void {
			serializedClass.pLongDesc = PIERCING_NO_DESCRIPTION;
			
			cut.upgradeSerializationVersion(serializedClass, 0);
			
			assertThat(cut.pLongDesc, equalTo(""));
		}
		
		[Test]
		public function deserializeUpgradePiercingDescriptionLong():void {
			serializedClass.pLongDesc = PIERCING_DESCRIPTION;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.pLongDesc, equalTo(PIERCING_DESCRIPTION));
		}
		
		[Test]
		public function deserializeUpgradeNoPiercing():void {
			serializedClass.pierced = undefined;
			
			cut.upgradeSerializationVersion(serializedClass, 0);
			
			assertThat(cut.pierced, equalTo(0));
		}
		
		[Test]
		public function deserializeUpgradePiercing():void {
			serializedClass.pierced = PIERCING;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.pierced, equalTo(PIERCING));
		}
		
		[Test(description="Not using Cock const is intentional")]
		public function limitMaxCockLength():void {
			serializedClass.cockLength = Number.MAX_VALUE;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.cockLength, equalTo(9999.9));
		}
		
		[Test(description="Not using Cock const is intentional")]
		public function limitMaxCockThickness():void {
			serializedClass.cockThickness = Number.MAX_VALUE;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.cockThickness, equalTo(999.9));
		}
		
		[Test]
		public function deserializeCockLength():void {
			serializedClass.cockLength = COCK_LENGTH;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.cockLength, equalTo(COCK_LENGTH));
		}
		
		[Test]
		public function deserializeCockThickness():void {
			serializedClass.cockThickness = COCK_THICKNESS;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.cockThickness, equalTo(COCK_THICKNESS));
		}

		[Test]
		public function doNotResetKnotIfKnotIsSupported():void
		{
			cut.knotMultiplier = KNOT_MULTIPLIER;

			cut.cockType = CockTypesEnum.DOG;

			assertThat(cut.knotMultiplier, equalTo(KNOT_MULTIPLIER));
		}

		[Test]
		public function resetKnotIfKnotIsNotSupported():void
		{
			cut.knotMultiplier = KNOT_MULTIPLIER;

			cut.cockType = CockTypesEnum.HORSE;

			assertThat(cut.knotMultiplier, equalTo(DEFAULT_KNOT_MULTIPLIER));
		}
		
		[Test]
		public function checkHasKnot():void
		{
			cut.knotMultiplier = KNOT_MULTIPLIER;

			assertThat(cut.hasKnot(), equalTo(true));
		}
		
		[Test]
		public function checkHasNoKnot():void
		{
			cut.knotMultiplier = Cock.KNOTMULTIPLIER_NO_KNOT;

			assertThat(cut.hasKnot(), equalTo(false));
		}
	}
}
