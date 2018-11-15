package classes.lists
{
	import classes.CockTypesEnum;
	/**
	 * Class for Genital lists
	 * @since September 29, 2018
	 * @author Stadler76
	 */
	public class GenitalLists
	{
		/**
		 * Contains cock types that support knots.
		 * This is used for the supportsKnot method and with that to decide if a knot is reset when the cock type changes
		 * e.g. player.cocks[0].cockType = CockTypesEnum.HORSE
		 */
		public static const KNOTTED_COCKS:Vector.<CockTypesEnum> = new <CockTypesEnum>[
			CockTypesEnum.DOG,
			CockTypesEnum.FOX,
			CockTypesEnum.WOLF,
			CockTypesEnum.DRAGON,
			CockTypesEnum.DISPLACER
		];
	}
}
