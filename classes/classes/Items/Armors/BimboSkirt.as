package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Items.ArmorLib;
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.UndergarmentLib;
	import classes.internals.Utils;
	import classes.lists.Gender;

	public class BimboSkirt extends ArmorWithPerk
	{
		public function BimboSkirt()
		{
			super(new ArmorWithPerkBuilder()
				.id("BimboSk")
				.shortName("BimboSk")
				.name("bimbo skirt")
				.longName("A skirt that looks like it belongs on a bimbo")
				.def(1)
				.value(50)
				.description("A tight, cleavage-inducing halter top and an extremely short miniskirt. The sexual allure of this item is undoubtable.")
				.perk("Light")
				.playerPerk(PerkLib.SluttySeduction, 10, 0, 0, 0)
				.supportsUndergarment(false)
			);
		}

		override public function useText():void
		{ 
			var wornUpper:Boolean = (game.player.upperGarment != UndergarmentLib.NOTHING);
			var wornLower:Boolean = (game.player.lowerGarment != UndergarmentLib.NOTHING);

			if (wornUpper && wornLower) {
				outputText("You look very awkward wearing " + game.player.lowerGarment.longName + " while putting your skirt on."
				          +" You realize that you probably won't be able to seduce many of your foes in this ludicrous outfit."
				          +" For a moment you consider taking your " + game.player.lowerGarment.longName + " off, but then decide against it.");
				return;
			}

			game.dynStats("lus", 5);

			if (!wornUpper) {
				if (game.player.biggestTitSize() >= 8) {
					outputText("The halter top clings tightly to your bustline, sending a shiver of pleasure through your body."
					          +" You feel how your erect [nipples] protrude from the soft fabric of your beautiful dress,"
					          +" and the sensation makes you feel slightly dizzy. ");
					if (game.player.isLactating()) {
						outputText("You feel how the top of your dress becomes wet, as droplets of milk leak from your [nipples]. ");
					}
				} else if (game.player.biggestTitSize() >= 5) {
					outputText("The halter top clings to your bustline, sending a shiver of pleasure through your body. ");
					if (game.player.isLactating()) {
						outputText("You feel how the top of your dress becomes wet, as droplets of milk leak from your [nipples]. ");
					}
					game.dynStats("lus", 2);
				} else if (game.player.biggestTitSize() >= 2) {
					outputText("The halter top of your sluttish outfit snugly embraces your [tits]."
					          +" The sensation of the soft fabric on your bare [nipples] makes you feel warm and sexy. ");
					if (game.player.isLactating()) {
						outputText("You feel how the top of your dress becomes wet, as droplets of milk leak from your [nipples]. ");
					}
					game.dynStats("lus", 5);
				} else if (game.player.biggestTitSize() >= 1) {
					outputText("You feel how the soft fabric of your dress caresses your [tits]."
					          +" The sensation is very erotic and you touch your sensitive [nipples], feeling the spread of arousal."
					          +" You idly notice that the halter top of your whorish dress is somewhat loose,"
					          +" and it would feel much better if your breasts were bigger and suppler. ");
					if (game.player.isLactating()) {
						outputText("You feel how the top of your dress becomes wet, as droplets of milk leak from your [nipples]. ");
					}
					game.dynStats("lus", 10);
				} else {
					outputText("You feel rather stupid putting the top part on like this, but you're willing to bear with it. As you put it on,"
					          +" you feel how the soft fabric of your dress touches your [nipples], making them erect.");
					game.dynStats("lus", 15);
				}
				outputText("\n\n");
				game.player.orgasm('Tits',false); 
			}
			
			if (!wornLower) {
				if (game.player.butt.rating < 8) {
					outputText("The sensation of tender fabric clinging to your [butt] arouses you immensely, as you smooth your skirt. ");
				}else {
					outputText("You can feel how the fine fabric of your sluttish skirt doesn't quite cover your [ass]");
					if (game.player.hips.rating > 8) {
						outputText(", and how the smooth skirt is stretched by your [hips]. ");
					} else {
						outputText(". ");
					}
				}
				if (game.player.hasCock()) {
					outputText("Your [cock] becomes erect under your obscene skirt, bulging unnaturally. ");
				} else if (game.player.hasVagina()) {
					switch (game.player.vaginas[0].vaginalWetness) {
						case 5:
							outputText("Your juice constantly escapes your [pussy] and spoils your sexy skirt. ");
							game.dynStats("lus", 5);
							break;
						case 4:
							outputText("A thin stream of your girl-cum escapes your [pussy] and spoils your skirt. ");
							game.dynStats("lus", 5);
							break;
						case 3:
							outputText("Your [pussy] becomes all tingly and wet under your slutty skirt. ");
							game.dynStats("lus", 5);
							break;
						default: //Move along
					}
				}
				if (game.player.gender === Gender.NONE) {
					outputText("Despite your lack of features, you indeed feel arousal all over your body. ");
				}
				outputText("\n\n");
				game.player.orgasm('Anal', false);
				game.player.orgasm('Vaginal', false);
			}
			
			game.player.orgasm('Lips',false);
		}

		override public function get supportsUndergarment():Boolean
		{
			return game.player.isPureEnough(10);
		}

		override public function canUse():Boolean
		{
			var wornUpper:Boolean = game.player.upperGarment != UndergarmentLib.NOTHING;
			var wornLower:Boolean = game.player.lowerGarment != UndergarmentLib.NOTHING;

			if (!game.player.isPureEnough(10)) {
				if (wornUpper || wornLower) {
					var undergarmentStrings:Array;
					if (wornUpper) {
						undergarmentStrings.push(game.player.upperGarment.longName);
					}
					if (wornLower) {
						undergarmentStrings.push(game.player.lowerGarment.longName);
					}
					outputText("It would be awkward to put on " + longName + " when you're currently wearing "
					          + formatStringArray(undergarmentStrings) + ". You should consider removing them. You put it back into your inventory."
					);
					return false;
				}
			}
			return true;
		}
	}
}
