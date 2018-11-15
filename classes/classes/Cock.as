package classes
{
	import classes.CockTypesEnum;
	import classes.internals.Serializable;
	import classes.internals.Utils;
	import classes.lists.GenitalLists;
	import mx.logging.ILogger;
	import classes.internals.LoggerFactory;

	public class Cock implements Serializable
	{
		private static const LOGGER:ILogger = LoggerFactory.getLogger(Cock);
		
		private static const SERIALIZATION_VERSION:int = 1;
		
		private static const OBJECT_NOT_FOUND:int = -1;

		public static const MAX_LENGTH:Number = 9999.9;
		public static const MAX_THICKNESS:Number = 999.9;
		public static const KNOTMULTIPLIER_NO_KNOT:Number = 1;
		
		private var _cockLength:Number;
		private var _cockThickness:Number;		
		private var _cockType:CockTypesEnum;	//See CockTypesEnum.as for all cock types
		
		/**
		 * Used to determine thickness of knot relative to normal thickness
		 */
		private var _knotMultiplier:Number;
		
		//Piercing info
		private var _isPierced:Boolean;
		private var _pierced:Number;
		private var _pShortDesc:String;
		private var _pLongDesc:String;
		
		//Sock
		private var _sock:String;


		/**
		 * @return string description of errors
		 */
		public function validate():String {
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this,"Cock.validate",["cockLength","cockThickness","knotMultiplier","pierced"]);
			if (!_isPierced){
				if (_pShortDesc.length>0) error += "Not pierced but _pShortDesc = "+_pShortDesc+". ";
				if (_pLongDesc.length>0) error += "Not pierced but pLong = "+_pLongDesc+". ";
			} else {
				if (_pShortDesc.length==0) error += "Pierced but no _pShortDesc. ";
				if (_pLongDesc.length==0) error += "Pierced but no pLong. ";
			}
			return error;
		}
		
		//constructor. Default type is HUMAN
		public function Cock(i_cockLength:Number = 5.5, i_cockThickness:Number = 1, i_cockType:CockTypesEnum=null)
		{
			if (i_cockType === null) i_cockType = CockTypesEnum.HUMAN;
			_cockLength = i_cockLength;
			_cockThickness = i_cockThickness;
			_cockType = i_cockType;
			_pierced = 0;
			_knotMultiplier = KNOTMULTIPLIER_NO_KNOT;
			_isPierced = false;
			_pShortDesc = "";
			_pLongDesc = "";
			_sock = "";
		}
		
		//MEMBER FUNCTIONS
		public function cArea():Number
		{
			return cockThickness * cockLength;
		}
		
		public function growCock(lengthDelta:Number, bigCock:Boolean):Number
		{
			
			if (lengthDelta === 0) {
				LOGGER.error("growCock called with 0, aborting...")
				return lengthDelta;
			}
			
			var threshhold:int = 0;
			LOGGER.debug("growcock starting at: {0}", lengthDelta);

			if (lengthDelta > 0) { // growing
				LOGGER.debug("and growing...");
				threshhold = 24;
				// BigCock Perk increases incoming change by 50% and adds 12 to the length before diminishing returns set in
				if (bigCock) {
					LOGGER.debug("growCock found BigCock Perk");
					lengthDelta *= 1.5;
					threshhold += 12;
				}
				// Not a human cock? Multiple the length before dimishing returns set in by 3
				if (cockType !== CockTypesEnum.HUMAN)
					threshhold *= 2;
				// Modify growth for cock socks
				if (sock === "scarlet") {
					LOGGER.debug("growCock found Scarlet sock");
					lengthDelta *= 1.5;
				}
				else if (sock === "cobalt") {
					LOGGER.debug("growCock found Cobalt sock");
					lengthDelta *= .5;
				}
				// Do diminishing returns
				if (cockLength > threshhold) 
					lengthDelta /= 4;
				else if (cockLength > threshhold / 2)
					lengthDelta /= 2;
			}
			else {
				LOGGER.debug("and shrinking...");
				
				threshhold = 0;
				// BigCock Perk doubles the incoming change value and adds 12 to the length before diminishing returns set in
				if (bigCock) {
					LOGGER.debug("growCock found BigCock Perk");
					lengthDelta *= 0.5;
					threshhold += 12;
				}
				// Not a human cock? Add 12 to the length before dimishing returns set in
				if (cockType !== CockTypesEnum.HUMAN)
					threshhold += 12;
				// Modify growth for cock socks
				if (sock === "scarlet") {
					LOGGER.debug("growCock found Scarlet sock");
					lengthDelta *= 0.5;
				}
				else if (sock === "cobalt") {
					LOGGER.debug("growCock found Cobalt sock");
					lengthDelta *= 1.5;
				}
				// Do diminishing returns
				if (cockLength > threshhold) 
					lengthDelta /= 3;
				else if (cockLength > threshhold / 2)
					lengthDelta /= 2;
			}

			LOGGER.debug("then changing by: {0}", lengthDelta);

			cockLength += lengthDelta;
			
			if (cockLength < 1)
				cockLength = 1;

			if (cockThickness > cockLength * .33)
				cockThickness = cockLength * .33;

			return lengthDelta;
		}
		
		public function thickenCock(increase:Number):Number
		{
			var amountGrown:Number = 0;
			var temp:Number = 0;
			if (increase > 0)
			{
				while (increase > 0)
				{
					if (increase < 1)
						temp = increase;
					else
						temp = 1;
					//Cut thickness growth for huge dicked
					if (cockThickness > 1 && cockLength < 12)
					{
						temp /= 4;
					}
					if (cockThickness > 1.5 && cockLength < 18)
						temp /= 5;
					if (cockThickness > 2 && cockLength < 24)
						temp /= 5;
					if (cockThickness > 3 && cockLength < 30)
						temp /= 5;
					//proportional thickness diminishing returns.
					if (cockThickness > cockLength * .15)
						temp /= 3;
					if (cockThickness > cockLength * .20)
						temp /= 3;
					if (cockThickness > cockLength * .30)
						temp /= 5;
					//massive thickness limiters
					if (cockThickness > 4)
						temp /= 2;
					if (cockThickness > 5)
						temp /= 2;
					if (cockThickness > 6)
						temp /= 2;
					if (cockThickness > 7)
						temp /= 2;
					//Start adding up bonus length
					amountGrown += temp;
					cockThickness += temp;
					temp = 0;
					increase--;
				}
				increase = 0;
			}
			else if (increase < 0)
			{
				while (increase < 0)
				{
					temp = -1;
					//Cut length growth for huge dicked
					if (cockThickness <= 1)
						temp /= 2;
					if (cockThickness < 2 && cockLength < 10)
						temp /= 2;
					//Cut again for massively dicked
					if (cockThickness < 3 && cockLength < 18)
						temp /= 2;
					if (cockThickness < 4 && cockLength < 24)
						temp /= 2;
					//MINIMUM Thickness of OF .5!
					if (cockThickness <= .5)
						temp = 0;
					//Start adding up bonus length
					amountGrown += temp;
					cockThickness += temp;
					temp = 0;
					increase++;
				}
			}
			LOGGER.debug("thickenCock called and thickened by: {0}", amountGrown);
			return amountGrown;
		}

		/**
		 * Check if the given cockType supports a knot.
		 * @param cockType the cockType to check
		 * @return true if the cockType supports a knot
		 */
		public static function supportsKnot(cockType:CockTypesEnum):Boolean
		{
			return GenitalLists.KNOTTED_COCKS.indexOf(cockType) != OBJECT_NOT_FOUND;
		}
		
		public function get cockLength():Number 
		{
			return _cockLength;
		}
		
		public function set cockLength(value:Number):void 
		{
			_cockLength = value;
		}
		
		public function get cockThickness():Number 
		{
			return _cockThickness;
		}
		
		public function set cockThickness(value:Number):void 
		{
			_cockThickness = value;
		}
		
		public function get cockType():CockTypesEnum 
		{
			return _cockType;
		}
		
		/**
		 * Sets the cock type.
		 * If the cock type does not support a knot, the knot is reset.
		 */
		public function set cockType(value:CockTypesEnum):void 
		{
			_cockType = value;

			if (!supportsKnot(value) && this.knotMultiplier !== KNOTMULTIPLIER_NO_KNOT) {
				this.knotMultiplier = KNOTMULTIPLIER_NO_KNOT;
				LOGGER.debug("Cock type {0} does not support knots, setting knot knotMultiplier to {1}", value, knotMultiplier);
			}
		}
		
		public function hasKnot():Boolean
		{
			return knotMultiplier > KNOTMULTIPLIER_NO_KNOT;
		}
		
		public function get knotMultiplier():Number 
		{
			return _knotMultiplier;
		}
		
		public function set knotMultiplier(value:Number):void 
		{
			_knotMultiplier = value;
		}
		
		public function get isPierced():Boolean 
		{
			return _isPierced;
		}
		
		public function set isPierced(value:Boolean):void 
		{
			_isPierced = value;
		}
		
		public function get pShortDesc():String 
		{
			return _pShortDesc;
		}
		
		public function set pShortDesc(value:String):void 
		{
			_pShortDesc = value;
		}
		
		public function get pLongDesc():String 
		{
			return _pLongDesc;
		}
		
		public function set pLongDesc(value:String):void 
		{
			_pLongDesc = value;
		}
		
		public function get sock():String 
		{
			return _sock;
		}
		
		public function set sock(value:String):void 
		{
			_sock = value;
		}
		
		public function get pierced():Number 
		{
			return _pierced;
		}
		
		public function set pierced(value:Number):void 
		{
			_pierced = value;
		}
		
		public function serialize(relativeRootObject:*):void 
		{
			relativeRootObject.cockThickness = this.cockThickness;
			relativeRootObject.cockLength = this.cockLength;
			relativeRootObject.cockType = this.cockType.Index;
			relativeRootObject.knotMultiplier = this.knotMultiplier;
			relativeRootObject.pierced = this.pierced;
			relativeRootObject.pShortDesc = this.pShortDesc;
			relativeRootObject.pLongDesc = this.pLongDesc;
			relativeRootObject.sock = this.sock;
		}
		
		public function deserialize(relativeRootObject:*):void 
		{
			this.cockThickness = relativeRootObject.cockThickness;
			this.cockLength = relativeRootObject.cockLength;
			this.knotMultiplier = relativeRootObject.knotMultiplier;
			this.cockType = CockTypesEnum.ParseConstantByIndex(relativeRootObject.cockType);
			this.sock = relativeRootObject.sock;
			
			this.pierced = relativeRootObject.pierced;
			this.pShortDesc = relativeRootObject.pShortDesc;
			this.pLongDesc = relativeRootObject.pLongDesc;
			
			enforceCockSizeCaps();
		}
		
		private function enforceCockSizeCaps():void 
		{
			if (this.cockLength > MAX_LENGTH) {
				this.cockLength = MAX_LENGTH;
			}
			
			if (this.cockThickness > MAX_THICKNESS) {
				this.cockThickness = MAX_THICKNESS;
			}
		}
		
		public function upgradeSerializationVersion(relativeRootObject:*, serializedDataVersion:int):void 
		{
			switch(serializedDataVersion) {
				case 0:
					upgradeLegacyFormat(relativeRootObject);
					
				default:
					/*
					 * The default block is left empty intentionally,
					 * this switch case operates by using fall through behavior.
					 */
			}
		}
		
		/**
		 * Load un-versioned (legacy) cocks.
		 */
		private function upgradeLegacyFormat(relativeRootObject:*):void {
			LOGGER.info("Upgrading legacy save format...");
			
			if (relativeRootObject.sock === undefined) {
				relativeRootObject.sock = "";
				LOGGER.warn("Cock was missing sock field, setting to {0}", relativeRootObject.sock);
			}
			
			if (relativeRootObject.pShortDesc === "null" || relativeRootObject.pLongDesc === "null")
			{
				relativeRootObject.pShortDesc = "";
				relativeRootObject.pLongDesc = "";
				LOGGER.warn("Cock piercing description was null, setting to blank");
			}
			
			if (relativeRootObject.pierced === undefined)
			{
				relativeRootObject.pierced = 0;
				LOGGER.warn("Cock piercing was undefined, set to {0}", relativeRootObject.pierced);
			}
		}
		
		public function currentSerializationVerison():int 
		{
			return SERIALIZATION_VERSION;
		}
	}
}
