		//Calls are now made through kGAMECLASS rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.GlobalFlags.kFLAGS;
		import classes.GlobalFlags.kGAMECLASS;
		import classes.Items.ArmorLib;
		import classes.Items.WeaponLib;
		import classes.Items.UndergarmentLib;

		/**
		 * Possible text arguments in the conditional of a if statement
		 * First, there is an attempt to cast the argument to a Number. If that fails,
		 * a dictionary lookup is performed to see if the argument is in the conditionalOptions[]
		 * object. If that fails, we just fall back to returning 0
		 */
		public var conditionalOptions:Object =
		{
				"strength"			: function():* {return  kGAMECLASS.player.str;},
				"toughness"			: function():* {return  kGAMECLASS.player.tou;},
				"speed"				: function():* {return  kGAMECLASS.player.spe;},
				"intelligence"		: function():* {return  kGAMECLASS.player.inte;},
				"libido"			: function():* {return  kGAMECLASS.player.lib;},
				"sensitivity"		: function():* {return  kGAMECLASS.player.sens;},
				"corruption"		: function():* {return  kGAMECLASS.player.cor;},
				"fatigue"			: function():* {return  kGAMECLASS.player.fatigue;},
				"hp"				: function():* {return  kGAMECLASS.player.HP;},
				"hunger"			: function():* {return  kGAMECLASS.player.hunger;},
				"minute"			: function():* {return  kGAMECLASS.time.minutes;},
				"hour"				: function():* {return  kGAMECLASS.time.hours;},
				"days"				: function():* {return  kGAMECLASS.time.days;},
				"hasarmor"			: function():* {return  kGAMECLASS.player.armor != ArmorLib.NOTHING;},
				"haslowergarment"	: function():* {return  kGAMECLASS.player.lowerGarment != UndergarmentLib.NOTHING;},
				"hasweapon"			: function():* {return  kGAMECLASS.player.weapon != WeaponLib.FISTS;},
				"tallness"			: function():* {return  kGAMECLASS.player.tallness;},
				"hairlength"		: function():* {return  kGAMECLASS.player.hair.length;},
				"femininity"		: function():* {return  kGAMECLASS.player.femininity;},
				"masculinity"		: function():* {return  100 - kGAMECLASS.player.femininity;},
				"cocks"				: function():* {return  kGAMECLASS.player.cockTotal();},
				"breastrows"		: function():* {return  kGAMECLASS.player.bRows();},
				"biggesttitsize"	: function():* {return  kGAMECLASS.player.biggestTitSize();},
				"vagcapacity"		: function():* {return  kGAMECLASS.player.vaginalCapacity();},
				"analcapacity"		: function():* {return  kGAMECLASS.player.analCapacity();},
				"balls"				: function():* {return  kGAMECLASS.player.balls;},
				"cumquantity"		: function():* {return  kGAMECLASS.player.cumQ();},
				"biggesttitsize"	: function():* {return  kGAMECLASS.player.biggestTitSize();},
				"milkquantity"		: function():* {return  kGAMECLASS.player.lactationQ();},
				"hasvagina"			: function():* {return  kGAMECLASS.player.hasVagina();},
				"istaur"			: function():* {return  kGAMECLASS.player.isTaur();},
				"ishoofed"			: function():* {return  kGAMECLASS.player.isHoofed();},
				"iscentaur"			: function():* {return  kGAMECLASS.player.isCentaur();},
				"isnaga"			: function():* {return  kGAMECLASS.player.isNaga();},
				"isgoo"				: function():* {return  kGAMECLASS.player.isGoo();},
				"isbiped"			: function():* {return  kGAMECLASS.player.isBiped();},
				"hasbreasts"		: function():* {return  (kGAMECLASS.player.biggestTitSize() >= 1);},
				"hasballs"			: function():* {return  (kGAMECLASS.player.balls > 0);},
				"hascock"			: function():* {return  kGAMECLASS.player.hasCock();},
				"hassheath"			: function():* {return  kGAMECLASS.player.hasSheath();},
				"hasbeak"			: function():* {return  kGAMECLASS.player.hasBeak();},
				"hasdragonneck"		: function():* {return  kGAMECLASS.player.hasDragonNeck();},
				"neckpos"			: function():* {return  kGAMECLASS.player.neck.pos;},
				"hasfur"			: function():* {return  kGAMECLASS.player.hasFur();},
				"haswool"			: function():* {return  kGAMECLASS.player.hasWool();},
				"hasfeathers"		: function():* {return  kGAMECLASS.player.hasFeathers();},
				"hasfurryunderbody"	: function():* {return  kGAMECLASS.player.hasFurryUnderBody();},
				"isfurry"			: function():* {return  kGAMECLASS.player.isFurry();},
				"isfluffy"			: function():* {return  kGAMECLASS.player.isFluffy();},
				"isgenderless"		: function():* {return  (kGAMECLASS.player.isGenderless());},
				"ismale"			: function():* {return  (kGAMECLASS.player.isMale());},
				"isfemale"			: function():* {return  (kGAMECLASS.player.isFemale());},
				"isherm"			: function():* {return  (kGAMECLASS.player.isHerm());},
				"ismaleorherm"		: function():* {return  (kGAMECLASS.player.isMaleOrHerm());},
				"isfemaleorherm"	: function():* {return  (kGAMECLASS.player.isFemaleOrHerm());},
				"cumnormal"			: function():* {return  (kGAMECLASS.player.cumQ() <= 150);},
				"cummedium"			: function():* {return  (kGAMECLASS.player.cumQ() > 150 && kGAMECLASS.player.cumQ() <= 350);},
				"cumhigh"			: function():* {return  (kGAMECLASS.player.cumQ() > 350 && kGAMECLASS.player.cumQ() <= 1000);},
				"cumveryhigh"		: function():* {return  (kGAMECLASS.player.cumQ() > 1000 && kGAMECLASS.player.cumQ() <= 2500);},
				"cumextreme"		: function():* {return  (kGAMECLASS.player.cumQ() > 2500);},
				"issquirter"		: function():* {return  (kGAMECLASS.player.wetness() >= 4);},
				"vaginalwetness"	: function():* {return  kGAMECLASS.player.wetness();},
				"anallooseness"		: function():* {return  kGAMECLASS.player.ass.analLooseness;},
				"buttrating"		: function():* {return  kGAMECLASS.player.butt.rating;},
				"ispregnant"		: function():* {return  (kGAMECLASS.player.pregnancyIncubation > 0);},
				"isbuttpregnant"	: function():* {return  (kGAMECLASS.player.buttPregnancyIncubation > 0);},
				"hasnipplecunts"	: function():* {return  kGAMECLASS.player.hasFuckableNipples();},
				"totalnipples"		: function():* {return  kGAMECLASS.player.totalNipples();},
				"canfly"			: function():* {return  kGAMECLASS.player.canFly();},
				"hasovipositor"		: function():* {return  kGAMECLASS.player.hasOvipositor();},
				"islactating"		: function():* {return  (kGAMECLASS.player.lactationQ() > 0);},
				"isbimbo"			: function():* {return  kGAMECLASS.player.isBimbo();},
				"true"				: function():* {return  true;},
				"false"				: function():* {return  false;},
				
				//Prison
				"esteem"			: function():* {return  kGAMECLASS.player.esteem; },
				"obey"				: function():* {return  kGAMECLASS.player.obey; },
				"will"				: function():* {return  kGAMECLASS.player.will; },

				//---[NPCs]---
				//Joy
				"joyhascock"		: function():* {return  kGAMECLASS.joyScene.joyHasCock(); },

				//Tel Adre
				"bakerytalkedroot"	: function():* {return  kGAMECLASS.flags[kFLAGS.MINO_CHEF_TALKED_RED_RIVER_ROOT] > 0; }
			}
