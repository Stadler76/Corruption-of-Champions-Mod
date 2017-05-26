package classes.Scenes.API 
{
	/**
	 * Interface for explorable areas.
	 */
	public interface IExplorable 
	{
		/**
		 * Check if the area has already been discovered.
		 * @return true if the area has been discovered.
		 */
		function isDiscovered():Boolean;
		/**
		 * Discover the area, making it available for future exploration.
		 */
		function discover():void;
		/**
		 * Explore the area, possibly triggering encounters.
		 */
		function explore():void;
	}
}
