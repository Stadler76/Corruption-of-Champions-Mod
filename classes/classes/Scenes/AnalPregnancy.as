package classes.Scenes 
{
	import classes.Creature;
	/**
	 * Interface for anal pregnancy.
	 * The class must at least implement a birth scene.
	 */
	public interface AnalPregnancy 
	{
		/**
		 * Progresses a active pregnancy. Updates should eventually lead to birth.
		 * @return true if the display output needs to be updated.
		 */
		function updateAnalPregnancy(): Boolean;
		
		/**
		 * Give birth. Should outout a birth scene.
		 */
		function analBirth(): void;
	}
}
