package classes.Items.Consumables 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.StatusEffects;
	
	/**
	 * Goo transformative item.
	 */
	public class WetCloth extends Consumable 
	{
		public function WetCloth() 
		{
			super("WetClth", "WetClth", "a wet cloth dripping with slippery slime", ConsumableLib.DEFAULT_VALUE, "Dripping with a viscous slime, you've no doubt rubbing this cloth on your body would have some kind of strange effect.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			var tfSource:String = "gooGasmic";
			outputText("You take the wet cloth in hand and rub it over your body, smearing the strange slime over your " + player.skinDesc + " slowly.");
			//Stat changes
			//libido up to 80
			if (player.lib100 < 80) {
				dynStats("lib", (.5 + (90 - player.lib) / 10), "lus", player.lib / 2);
				outputText("\n\nBlushing and feeling horny, you make sure to rub it over your chest and erect nipples, letting the strange slimy fluid soak into you.");
			}
			//sensitivity moves towards 50
			if (player.sens100 < 50) {
				outputText("\n\nThe slippery slime soaks into your " + player.skinDesc + ", making it tingle with warmth, sensitive to every touch.");
				dynStats("sen", 1);
			}
			else if (player.sens100 > 50) {
				outputText("\n\nThe slippery slime numbs your " + player.skinDesc + " slightly, leaving behind only gentle warmth.");
				dynStats("sen", -1);
			}

			//Cosmetic changes based on 'goopyness'
			//Neck restore
			if (player.neck.type != NECK_TYPE_NORMAL && changes < changeLimit && rand(4) == 0) mutations.restoreNeck(tfSource);
			//Rear body restore
			if (player.hasNonSharkRearBody() && changes < changeLimit && rand(5) == 0) mutations.restoreRearBody(tfSource);
			//Ovi perk loss
			if (rand(5) === 0) {
				mutations.updateOvipositionPerk(tfSource);
			}
			//Remove wings and shark fin
			if (player.wingType != WING_TYPE_NONE || player.rearBody.type == REAR_BODY_SHARK_FIN) {
				if (player.rearBody.type == REAR_BODY_SHARK_FIN) {
					outputText("\n\nYou sigh, feeling a hot wet tingling down your back.  It tickles slightly as you feel your fin slowly turn to"
					          +" sludge, dripping to the ground as your body becomes more goo-like.");
					player.rearBody.restore();
				} else {
					outputText("\n\nYou sigh, feeling a hot wet tingling down your back.  It tickles slightly as you feel your wings slowly turn to"
					          +" sludge, dripping to the ground as your body becomes more goo-like.");
				}
				player.wings.restore();
				return false;
			}
			//Goopy hair
			if (player.hairType !== 3) {
				player.hairType = 3;
				//if bald
				if (player.hairLength <= 0) {
					outputText("\n\nYour head buzzes pleasantly, feeling suddenly hot and wet.  You instinctively reach up to feel the source of your wetness, and discover you've grown some kind of gooey hair.  From time to time it drips, running down your back to the crack of your " + player.buttDescript() + ".");
					player.hairLength = 5;
				}
				else {
					//if hair isnt rubbery or latexy
					if (player.hairColor.indexOf("rubbery") === -1 && player.hairColor.indexOf("latex-textured") === -1) {
						outputText("\n\nYour head buzzes pleasantly, feeling suddenly hot and wet.  You instinctively reach up to feel the source of your wetness, and discover your hair has become a slippery, gooey mess.  From time to time it drips, running down your back to the crack of your " + player.buttDescript() + ".");
					}
					//Latexy stuff
					else {
						outputText("\n\nYour oddly inorganic hair shifts, becoming partly molten as rivulets of liquid material roll down your back.  How strange.");
					}
				}
				if (player.hairColor !== "green" && player.hairColor !== "purple" && player.hairColor !== "blue" && player.hairColor !== "cerulean" && player.hairColor !== "emerald") {
					outputText("  Stranger still, the hue of your semi-liquid hair changes to ");
					var blah:int = rand(10);
					if (blah <= 2) player.hairColor = "green";
					else if (blah <= 4) player.hairColor = "purple";
					else if (blah <= 6) player.hairColor = "blue";
					else if (blah <= 8) player.hairColor = "cerulean";
					else player.hairColor = "emerald";
					outputText(player.hairColor + ".");
				}
				dynStats("lus", 10);
				return false;
			}
			//1.Goopy skin
			if (player.hairType === 3 && (player.skinDesc !== "skin" || player.skinAdj !== "slimy")) {
				if (player.hasPlainSkin()) outputText("\n\nYou sigh, feeling your " + player.armorName + " sink into you as your skin becomes less solid, gooey even.  You realize your entire body has become semi-solid and partly liquid!");
				else if (player.hasFur()) outputText("\n\nYou sigh, suddenly feeling your fur become hot and wet.  You look down as your " + player.armorName + " sinks partway into you.  With a start you realize your fur has melted away, melding into the slime-like coating that now serves as your skin.  You've become partly liquid and incredibly gooey!");
				else if (player.hasScales()) outputText("\n\nYou sigh, feeling slippery wetness over your scales.  You reach to scratch it and come away with a slippery wet coating.  Your scales have transformed into a slimy goop!  Looking closer, you realize your entire body has become far more liquid in nature, and is semi-solid.  Your " + player.armorName + " has even sunk partway into you.");
				player.skinType = SKIN_TYPE_GOO;
				player.skinDesc = "skin";
				player.skinAdj = "slimy";
				player.underBody.restore();
				if (player.skinTone !== "green" && player.skinTone !== "purple" && player.skinTone !== "blue" && player.skinTone !== "cerulean" && player.skinTone !== "emerald") {
					outputText("  Stranger still, your skintone changes to ");
					var blaht:int = rand(10);
					if (blaht <= 2) player.skinTone = "green";
					else if (blaht <= 4) player.skinTone = "purple";
					else if (blaht <= 6) player.skinTone = "blue";
					else if (blaht <= 8) player.skinTone = "cerulean";
					else player.skinTone = "emerald";
					outputText(player.skinTone + "!");
					if (player.armType !== ARM_TYPE_HUMAN || player.clawType !== CLAW_TYPE_NORMAL) {
						mutations.restoreArms(tfSource);
					}
				}
				return false;
			}
			////1a.Make alterations to dick/vaginal/nippular descriptors to match
			//DONE EXCEPT FOR TITS & MULTIDICKS (UNFINISHED KINDA)
			//2.Goo legs
			if (player.skinAdj === "slimy" && player.skinDesc === "skin" && player.lowerBody !== LOWER_BODY_TYPE_GOO) {
				outputText("\n\nYour viewpoint rapidly drops as everything below your " + player.buttDescript() + " and groin melts together into an amorphous blob.  Thankfully, you discover you can still roll about on your new slimey undercarriage, but it's still a whole new level of strange.");
				player.tallness -= 3 + rand(2);
				if (player.tallness < 36) {
					player.tallness = 36;
					outputText("  The goo firms up and you return to your previous height.  It would truly be hard to get any shorter than you already are!");
				}
				player.lowerBody = LOWER_BODY_TYPE_GOO;
				player.legCount = 1;
				return false;
			}
			//3a. Grow vagina if none
			if (!player.hasVagina()) {
				outputText("\n\nA wet warmth spreads through your slimey groin as a narrow gash appears on the surface of your groin.  <b>You have grown a vagina.</b>");
				player.createVagina();
				player.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
				player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING;
				player.setClitLength(.4);
				return false;
			}
			//3b.Infinite Vagina
			if (player.vaginalCapacity() < 9000) {
				if (!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity, 9000, 0, 0, 0);
				else player.addStatusValue(StatusEffects.BonusVCapacity, 1, 9000);
				outputText("\n\nYour " + player.vaginaDescript(0) + "'s internal walls feel a tingly wave of strange tightness.  Experimentally, you slip a few fingers, then your hand, then most of your forearm inside yourself.  <b>It seems you're now able to accommodate just about ANYTHING inside your sex.</b>");
				return false;
			}
			else if (player.tallness < 100 && rand(3) <= 1) {
				outputText("\n\nYour gel-like body swells up from the intake of additional slime.  If you had to guess, you'd bet you were about two inches taller.");
				player.tallness += 2;
				dynStats("str", 1, "tou", 1);
			}
			//Big slime girl
			else {
				if (!player.hasStatusEffect(StatusEffects.SlimeCraving)) {
					outputText("\n\nYou feel a growing gnawing in your gut.  You feel... hungry, but not for food.  No, you need something wet and goopy pumped into you.  You NEED it.  You can feel it in your bones.  <b>If you don't feed that need... you'll get weaker and maybe die.</b>");
					player.createStatusEffect(StatusEffects.SlimeCraving, 0, 0, 0, 1); //Value four indicates this tracks strength and speed separately
				}
				else {
					outputText("\n\nYou feel full for a moment, but you know it's just a temporary respite from your constant need to be 'injected' with fluid.");
					player.changeStatusValue(StatusEffects.SlimeCraving, 1, 0);
				}
			}
			if (rand(2) === 0) outputText(player.modFem(85, 3));
			if (rand(2) === 0) outputText(player.modThickness(20, 3));
			if (rand(2) === 0) outputText(player.modTone(15, 5));
			game.flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			return false;
		}
	}
}
