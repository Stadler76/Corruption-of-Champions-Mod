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
		
		public function ArmorWithPerk(id:String, shortName:String,name:String, longName:String, def:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "", playerPerk2:PerkType = null, playerPerk2V1:Number = 0, playerPerk2V2:Number = 0, playerPerk2V3:Number = 0, playerPerk2V4:Number = 0, playerPerk2Desc:String = "", supportsBulge:Boolean = false, supportsUndergarment:Boolean = true) {
			super(id, shortName, name, longName, def, value, description, perk, supportsBulge, supportsUndergarment);
			this.playerPerk = playerPerk;
			this.playerPerkV1 = playerPerkV1;
			this.playerPerkV2 = playerPerkV2;
			this.playerPerkV3 = playerPerkV3;
			this.playerPerkV4 = playerPerkV4;
			this.playerPerk2 = playerPerk2;
			this.playerPerk2V1 = playerPerk2V1;
			this.playerPerk2V2 = playerPerk2V2;
			this.playerPerk2V3 = playerPerk2V3;
			this.playerPerk2V4 = playerPerk2V4;
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
