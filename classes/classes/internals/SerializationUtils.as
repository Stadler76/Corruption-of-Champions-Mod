package classes.internals 
{
	import classes.Items.Armors.Nothing;
	import flash.errors.IllegalOperationError;
	import classes.internals.LoggerFactory;
	import mx.logging.ILogger;
	import classes.internals.Serializable;
	import ArgumentError;
	
	/**
	 * A class providing utility methods to make serialization and deserialization easier.
	 */
	public class SerializationUtils 
	{
		private static const LOGGER:ILogger = LoggerFactory.getLogger(SerializationUtils);
		
		private static const SERIALIZATION_VERSION_PROPERTY:String = "serializationVersion";
		
		public function SerializationUtils() 
		{
			throw new IllegalOperationError("This class cannot be instantiated");
		}
		
		/**
		 * Serializes a Vector into an array.
		 * @param	vector to serialize
		 * @return a array containing the serialized vector
		 */
		public static function serializeVector(vector:Vector.<*>):Array {
			var serialized:Array = [];
			
			for each(var element:Serializable in vector) {
				var obj:Array = [];
				serialized.push(obj);
				
				SerializationUtils.serialize(obj, element);
			}
			
			return serialized;
		}
		
		/**
		 * Deserializes a Array into a Vector of Serializable
		 * @param   destinationVector Vector where deserialized items will be written
		 * @param	serializedVector an Array containing the serialized vector
		 * @param	type of the serialized Vector
		 * @return a deserialized Vector
		 */
		public static function deserializeVector(destinationVector:Vector.<*>, serializedVector:Array, type:Class):void {
			// 'is' will only work on an instance
			if (!(new type() is Serializable)) {
				throw new ArgumentError("Type must implement Serializable");
			}
			
			if (destinationVector === null) {
				throw new ArgumentError("Destination Vector cannot be null");
			}
			
			if (serializedVector === null) {
				throw new ArgumentError("Serialized Vector cannot be null");
			}
			
			for each(var element:Object in serializedVector) {
				var instance:Serializable = new type();
				SerializationUtils.deserialize(element, instance);
				destinationVector.push(instance);
			}
		}
		
		/**
		 * Casts a vector from one type to another. DOES NO VALIDATION.
		 * @param	destinationVector vector where casted elements will be put
		 * @param	sourceVector where elements for casting will be read from
		 * @param	destinationType the class to cast to
		 */
		public static function castVector(destinationVector:*, sourceVector:*, destinationType:Class):void {
			/**
			 * If anyone has a better idea, i'm all ears.
			 * Implement your solution and see if the tests pass.
			 */
			
			for each(var element:* in sourceVector) {
				destinationVector.push(element as destinationType);
			}
		}
		
		/**
		 * Get the serialization version from the object, if any.
		 * @param	relativeRootObject that possibly contains a serialization version
		 * @return the serialization version, or 0 if no version is found
		 */
		public static function serializationVersion(relativeRootObject:*):int {
			return relativeRootObject[SERIALIZATION_VERSION_PROPERTY];
		}
		
		/**
		 * Check the version of the serialized data and compare it with the current version.
		 * @param	relativeRootObject object that contains serialized data
		 * @return true if the serialized version is compatible with the current verison
		 */
		public static function serializedVersionCheck(relativeRootObject:*, expectedVersion:int):Boolean {
			var version:int = SerializationUtils.serializationVersion(relativeRootObject);
			
			if (version > expectedVersion) {
				LOGGER.error("Serialized version is {0}, but the current version is {1}. Backward compatibility is not guaranteed!", version, expectedVersion);
				return false;
			}else{
				LOGGER.debug("Serialized version is {0}", version);
			}
			
			return true;
		}
		
		/**
		 * Check the version of the serialized data and compare it with the current version. Throws a Exception
		 * if the version is newer.
		 * @param	relativeRootObject object that contains serialized data
		 * @throws RangeError if the stored version is newer than the current version
		 */
		public static function serializedVersionCheckThrowError(relativeRootObject:*, expectedVersion:int):void {
			if (!SerializationUtils.serializedVersionCheck(relativeRootObject, expectedVersion)) {
				throw new RangeError("Stored version is newer than the current version");
			}
		}
		
		/**
		 * Deserialize a class. This method is intended to automate deserialization, in order to avoid
		 * a lot of code duplication.
		 * @param	relativeRootObject the object that contains the serialized classes data
		 * @param	serialized class instance that should have it's state restored
		 */
		public static function deserialize(relativeRootObject:*, serialized:Serializable):void {
			LOGGER.debug("Deserializing  {0}...", serialized);

			objectDefinedCheck(relativeRootObject, "Object passed for deserialization must be defined. Does the loaded property exist?")
			objectDefinedCheck(serialized, "Instance of class to load is not defined. Did you call the class constructor?");
			
			SerializationUtils.serializedVersionCheckThrowError(relativeRootObject, serialized.currentSerializationVerison());
			var serializedObjectVersion:int = SerializationUtils.serializationVersion(relativeRootObject);
			
			serialized.upgradeSerializationVersion(relativeRootObject, serializedObjectVersion);
			serialized.deserialize(relativeRootObject);
		}
		
		/**
		 * Serialize a class. This method is intended to automate serialization, in order to avoid
		 * a lot of code duplication.
		 * 
		 * @param	relativeRootObject to write the classes data to
		 * @param	toSerialize instance of class to serialize
		 */
		public static function serialize(relativeRootObject:*, toSerialize:Serializable):void {
			LOGGER.debug("Serializing {0}...", toSerialize);
			
			objectDefinedCheck(relativeRootObject, "Object used for storage must be defined. Did you forget to initialize e.g. foo = []; ?");
			objectDefinedCheck(toSerialize, "Instance of class to store is not defined. Did you call the class constructor?");
			
			relativeRootObject[SERIALIZATION_VERSION_PROPERTY] = toSerialize.currentSerializationVerison();
			
			toSerialize.serialize(relativeRootObject);
		}
		
		private static function objectDefinedCheck(object:*, message:String):void {
			if (object === null || object === undefined) {
				LOGGER.error("Object failed defined check with message: {0}", message);
				throw new ArgumentError(message);
			}
		}
	}
}
