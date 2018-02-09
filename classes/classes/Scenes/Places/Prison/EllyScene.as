package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class EllyScene extends BaseContent
	{
		
		public function EllyScene() {}
		
		public function getFistedWREKT():void {
			if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) < 3) {
				outputText("(Placeholder) \"<i>You haven't yet earned the privilege of getting fucked by my cock.");
			}
			else {
				outputText("(Placeholder) \"<i>Being fucked by my cock would be too much of a reward given your recent behavior.");
			}
			outputText(" Perhaps you will be worthy of it next time. But don't worry, we'll still have plenty of fun.</i>\" She directs you to grab hold of a ring hanging above your head, and expertly teases your erogenous zones with her skillful hands until you become weak in the knees, lose your grip, and collapse to the floor. She then makes you lie on your back and hold your ankles, and she works the fingers on one hand into your [asshole] while teasing your genitals with the other. \n\n");
			outputText("Eventually she squeezes her entire hand inside and allows you to orgasm.");
			if (player.hasCock()) {
				outputText("Thanks to her stimulation of your prostate you cum buckets, painting your [fullChest] and [face] with your sticky goo.");
			}
			if ((player.hasVagina()) && player.wetness() >= 4) {
				if (player.hasCock()) {
					outputText("At the same time, your");
				}
				else {
					outputText("Your");
				}
				outputText(" abdomen is wracked with spasms of pleasure as a fountain of clear, viscous fluid erupts from your [cunt] and coats your Mistress' head and torso. She allows herself to indulge in a moment of ecstasy, rubbing your juices into her firm, shapely tits with her left hand while using them to massage her dick with her right. Despite being lost in your own pleasure, you cannot help but feel gratified watching her face, eyes closed, head tilted back, mouth agape, fiery red bangs haphazardly scattered across her face in sticky strands. Then the moment passes, and she speaks.");
			}
			outputText("\"<i>Do you understand now, slave? Your body craves my abuse. Embrace it -- once you do, your life will become an unending river of pleasure</i>\"");
			player.orgasm('Generic');
		}
		
		public function getBredByElly():void {
			if (player.hasVagina()) {
				outputText("(Placeholder) \"<i>You're going to get a special treat today, [boy], but first you need to beg me to put a baby in your dirty [cunt].</i>\" After a brief hesitation, you do so. She makes you present yourself like a bitch in heat while continuing to beg. Finally she gives you want you want, and fills your womb with her potent seed.\n\n");
				player.knockUp(PregnancyStore.PREGNANCY_IMP, 350, 50);
				player.cuntChange(32,true,true,false);
				player.orgasm('Vaginal');
			}
			else {
				getAnallyStuffedByElly();
			}
		}
		
		public function getAnallyStuffedByElly():void {
			outputText("(Placeholder) You assume a submissive position and your " + getGame().prison.prisonCaptor.captorTitle + " has " + getGame().prison.prisonCaptor.captorPronoun3 + " way with you, pounding your [asshole] mercilessly until you orgasm from the shameful stimulation. \"<i>Do you understand now, slave? I don't even have to touch your ");
			if (player.hasCock()) {
				outputText("pathetic [cock]");
			}
			else if (player.hasVagina()) {
				outputText("dirty [cunt]");
			}
			else {
				outputText("silly little mound");
			}
			outputText(" to make you spurt. Your body wants to be used by my dick and filled with my seed. You are a cocksucking, anal loving, cum-slut. Accept it.</i>\"");
			player.buttChange(32,true,true,false);
			player.orgasm('Anal');
		}
	}

}