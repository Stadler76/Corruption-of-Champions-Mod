package classes{

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	import classes.Cock;
	import classes.CockTypesEnum;

	import org.flexunit.runners.Parameterized;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class CockKnotSupportTest
	{

		private var cockType:CockTypesEnum;
		private var supportsKnot:Boolean;

		[Parameters]
		public static var testData:Array = [
			[CockTypesEnum.DOG, 		true],
			[CockTypesEnum.DRAGON, 		true],
			[CockTypesEnum.FOX, 		true],
			[CockTypesEnum.WOLF, 		true],
			[CockTypesEnum.DISPLACER, 	true],

			[CockTypesEnum.HUMAN, 		false],
			[CockTypesEnum.HORSE, 		false],
			[CockTypesEnum.DEMON, 		false],
			[CockTypesEnum.TENTACLE, 	false],
			[CockTypesEnum.CAT, 		false],
			[CockTypesEnum.LIZARD, 		false],
			[CockTypesEnum.ANEMONE, 	false],
			[CockTypesEnum.KANGAROO, 	false],
			[CockTypesEnum.BEE, 		false],
			[CockTypesEnum.PIG, 		false],
			[CockTypesEnum.AVIAN, 		false],
			[CockTypesEnum.RHINO, 		false],
			[CockTypesEnum.ECHIDNA, 	false],
			[CockTypesEnum.RED_PANDA, 	false],
			[CockTypesEnum.FERRET, 		false],
			[CockTypesEnum.UNDEFINED, 	false]
		];

		public function CockKnotSupportTest(cockType:CockTypesEnum, supportsKnot:Boolean):void
		{
			this.cockType = cockType;
			this.supportsKnot = supportsKnot;
		}

		[Test]
		public function testIfCockSupportsKnot():void
		{
			assertThat(Cock.supportsKnot(cockType), equalTo(supportsKnot));
		}
	}
}
