package classes.internals 
{
	
	/**
	 * Interface for serialization and de-serialization.
	 * This is used to store class state in an object, so it can be persisted either
	 * to a shared object or file.
	 * The interface also provides a function to reverse the process.
	 */
	public interface ISerializable 
	{
		/**
		 * Serialize a class so it can be stored. Any state that is not serialized will be lost and replaced with the
		 * default value on deserialization.
		 * The class variables need to be stored manually.
		 * The object that is passed in must be initialized so class can write to it.
		 * 
		 * e.g.:
		 * relativeRootObject.foo = intValue;
		 * relativeRootObject.bar = StringValue;
		 * relativeRootObject.baz = [];
		 * this.complexObject.serialize(relativeRootObject.baz);
		 * 
		 * @param	relativeRootObject the object this class should write to 
		 */
		function serialize(relativeRootObject:*):void;
		
		/**
		 * Deserialize a class, restoring it's state. Deserialization requires some form of default constructor, this can be achieved
		 * with all parameters having a default value.
		 * 
		 * @param	relativeRootObject the object this class should read from
		 */
		function deserialize(relativeRootObject:*):void;
	}
}
