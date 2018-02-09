		//Calls are now made through kGAMECLASS rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.GlobalFlags.kGAMECLASS;

// PRONOUNS: The parser uses Elverson/Spivak Pronouns specifically to allow characters to be written with non-specific genders.
		// http://en.wikipedia.org/wiki/Spivak_pronoun
		//
		// Cheat Table:
		//           | Subject    | Object       | Possessive Adjective | Possessive Pronoun | Reflexive         |
		// Agendered | ey laughs  | I hugged em  | eir heart warmed     | that is eirs       | ey loves emself   |
		// Masculine | he laughs  | I hugged him | his heart warmed     | that is his        | he loves himself  |
		// Feminine  | she laughs | I hugged her | her heart warmed     | that is hers       | she loves herself |

		// (Is it bad that half my development time so far has been researching non-gendered nouns? ~~~~Fake-Name)


		public var arianLookups:Object = // For subject: "arian"
		{
			"man"		: function():String {return kGAMECLASS.arianScene.arianMF("man","woman")},
			// argh! "Man" is the mass-noun for humanity, and I'm loathe to choose an even more esoteric variant.
			// Elverson/Spivak terminology is already esoteric enough, and it lacks a ungendered mass noun.

			"ey"		: function():String {return kGAMECLASS.arianScene.arianMF("he","she")},
			"em"		: function():String {return kGAMECLASS.arianScene.arianMF("him","her")},
			"eir"		: function():String {return kGAMECLASS.arianScene.arianMF("his","her")},
			"eirs"		: function():String {return kGAMECLASS.arianScene.arianMF("his","hers")},
			"emself"	: function():String {return kGAMECLASS.arianScene.arianMF("himself","herself")},

			"chestadj"	: function():String {return kGAMECLASS.arianScene.arianChestAdjective()},
			"chest"		: function():String {return kGAMECLASS.arianScene.arianChest()}
		}
		// Arian unhandled terms (I have not decided how to support them yet):
		// arianMF("mas","mis")
		// arianMF("master","mistress")
		// arianMF("male","girly")

		public var emberLookups:Object = // For subject: "ember"
		{
			"man"		: function():String { return kGAMECLASS.arianScene.emberMF("man", "woman") },
			
			"ey"		: function():String {return kGAMECLASS.emberScene.emberMF("he","she")},
			"em"		: function():String {return kGAMECLASS.emberScene.emberMF("him","her")},
			"eir"		: function():String {return kGAMECLASS.emberScene.emberMF("his","her")},
			"eirs"		: function():String {return kGAMECLASS.emberScene.emberMF("his","hers")},
			"emself"	: function():String {return kGAMECLASS.emberScene.emberMF("himself","herself")}
		}

		public var rubiLookups:Object = // For subject: "rubi"
		{
			"man"		: function():String {return kGAMECLASS.telAdre.rubi.rubiMF("man","woman")},

			"ey"		: function():String {return kGAMECLASS.telAdre.rubi.rubiMF("he","she")},
			"em"		: function():String {return kGAMECLASS.telAdre.rubi.rubiMF("him","her")},
			"eir"		: function():String {return kGAMECLASS.telAdre.rubi.rubiMF("his","her")},
			"eirs"		: function():String {return kGAMECLASS.telAdre.rubi.rubiMF("his","hers")},
			"emself"	: function():String {return kGAMECLASS.telAdre.rubi.rubiMF("himself","herself")},

			"cock"		: function():String {return kGAMECLASS.telAdre.rubi.rubiCock()},
			"breasts"	: function():String {return kGAMECLASS.telAdre.rubi.rubiBreasts()}

		}
		//Rubi unhandled terms :
		// rubiMF("boy","girl")
		// rubiMF("demon","demoness")
		// rubiMF("gentleman","lady")

		public var benoitLookups:Object = // For subject: "benoit"
		{
			"man"		: function():String {return kGAMECLASS.bazaar.benoit.benoitMF("man", "woman")},
			"name"		: function():String {return kGAMECLASS.bazaar.benoit.benoitMF("Benoit", "Benoite")},

			"ey"		: function():String {return kGAMECLASS.bazaar.benoit.benoitMF("he", "she")},
			"em"		: function():String {return kGAMECLASS.bazaar.benoit.benoitMF("him", "her")},
			"eir"		: function():String {return kGAMECLASS.bazaar.benoit.benoitMF("his", "her")},
			"eirs"		: function():String {return kGAMECLASS.bazaar.benoit.benoitMF("his", "hers")},
			"emself"	: function():String {return kGAMECLASS.bazaar.benoit.benoitMF("himself", "herself")}
		}
