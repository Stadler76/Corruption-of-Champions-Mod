/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.PerkType;
	import classes.PerkLib;
	import classes.Player;

	public class ArmorWithPerk extends Armor {
		private var playerPerk:PerkType;
		private var playerPerkV1:Number;
		private var playerPerkV2:Number;
		private var playerPerkV3:Number;
		private var playerPerkV4:Number;
		private var playerPerk2:PerkType;
		private var playerPerk2V1:Number;
		private var playerPerk2V2:Number;
		private var playerPerk2V3:Number;
		private var playerPerk2V4:Number;
		
		public function ArmorWithPerk(...args)
		{
			var errorString:String = "";
			var paramObject:Object;

			if (args.length === 0 || (args.length > 1 && args.length < 13)) {
				errorString = "Invalid number of arguments given for ArmorWithPerk-constructor.";
			}

			if (args.length === 1) {
				if (!(args[0] is ArmorWithPerkParamBuilder)) {
					errorString = "Single argument must be of type ArmorWithPerkParamBuilder for ArmorWithPerk-constructor.";
				} else {
					paramObject = args[0].toObject();
				}
			} else if (errorString === "") {
				paramObject = {
					id:                   args[0],
					shortName:            args[1],
					name:                 args[2],
					longName:             args[3],
					def:                  args[4],
					value:                args[5],
					description:          args[6],
					perk:                 args[7],
					playerPerk:           args[8],
					playerPerkV1:         args[9],
					playerPerkV2:         args[10],
					playerPerkV3:         args[11],
					playerPerkV4:         args[12],
					playerPerkDesc:       args.length >= 14 ? args[13] : "",
					playerPerk2:          args.length >= 15 ? args[14] : null,
					playerPerk2V1:        args.length >= 16 ? args[15] : 0,
					playerPerk2V2:        args.length >= 17 ? args[16] : 0,
					playerPerk2V3:        args.length >= 18 ? args[17] : 0,
					playerPerk2V4:        args.length >= 19 ? args[18] : 0,
					playerPerk2Desc:      args.length >= 20 ? args[19] : "",
					supportsBulge:        args.length >= 21 ? args[20] : false,
					supportsUndergarment: args.length >= 22 ? args[21] : true
				};
			}

			if (errorString === "") {
				super(
					paramObject.id,
					paramObject.shortName,
					paramObject.name,
					paramObject.longName,
					paramObject.def,
					paramObject.value,
					paramObject.description,
					paramObject.perk,
					paramObject.supportsBulge,
					paramObject.supportsUndergarment
				);
				this.playerPerk = paramObject.playerPerk;
				this.playerPerkV1 = paramObject.playerPerkV1;
				this.playerPerkV2 = paramObject.playerPerkV2;
				this.playerPerkV3 = paramObject.playerPerkV3;
				this.playerPerkV4 = paramObject.playerPerkV4;
				this.playerPerk2 = paramObject.playerPerk2;
				this.playerPerk2V1 = paramObject.playerPerk2V1;
				this.playerPerk2V2 = paramObject.playerPerk2V2;
				this.playerPerk2V3 = paramObject.playerPerk2V3;
				this.playerPerk2V4 = paramObject.playerPerk2V4;
			} else {
				// Nasty workaround-ish error handling, because of: "Error: A super statement cannot occur after a this, super, return, or throw statement."
				throw new Error(errorString);
			}
		}
		
		override public function playerEquip():Armor { //This item is being equipped by the player. Add any perks, etc.
			while (game.player.findPerk(playerPerk) >= 0) game.player.removePerk(playerPerk);
			game.player.createPerk(playerPerk, playerPerkV1, playerPerkV2, playerPerkV3, playerPerkV4);
			if (playerPerk2 != null && game.player.findPerk(playerPerk2) >= 0) game.player.removePerk(playerPerk2);
			if (playerPerk2 != null) game.player.createPerk(playerPerk2, playerPerk2V1, playerPerk2V2, playerPerk2V3, playerPerk2V4);
			return super.playerEquip();
		}
		
		override public function playerRemove():Armor { //This item is being removed by the player. Remove any perks, etc.
			while (game.player.findPerk(playerPerk) >= 0) game.player.removePerk(playerPerk);
			if (playerPerk2 != null && game.player.findPerk(playerPerk2) >= 0) game.player.removePerk(playerPerk2);
			return super.playerRemove();
		}

		override public function get description():String {
			var desc:String = super.description;
			//Perk
			desc += "\nSpecials: " + playerPerk.name;
			if (playerPerk == PerkLib.WizardsEndurance) desc += " (-" + playerPerkV1 + "% Spell Cost)";
			else if (playerPerkV1 > 0) desc += " (Magnitude: " + playerPerkV1 + ")";
			//Second perk
			if (playerPerk2 != null) {
				desc += "\n" + playerPerk2.name;
				if (playerPerk2 == PerkLib.WizardsEndurance) desc += " (-" + playerPerk2V1 + "% Spell Cost)";
				else if (playerPerk2V1 > 0) desc += " (Magnitude: " + playerPerk2V1 + ")";
			}
			return desc;
		}
		
/*
		override public function equipEffect(player:Player, output:Boolean):void
		{
			if (player.findPerk(playerPerk) < 0)
				player.createPerk(playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			while(player.findPerk(playerPerk) >= 0) player.removePerk(playerPerk);
		}
*/
	}
}
