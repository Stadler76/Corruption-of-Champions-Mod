//idea from liadri, added to by others
package classes.Items.Armors {
import classes.Items.Armor;
import classes.TimeAwareInterface;
import classes.Player;
import classes.CoC;
import classes.GlobalFlags.kGAMECLASS;
import classes.Items.ConsumableLib;

public class NagaSilkDress extends Armor implements TimeAwareInterface {
    private var _name:String;
	private function get player():Player{ //need the instance of player
			return kGAMECLASS.player;
	}
    public function NagaSilkDress() {
        super("NagaDress","Naga Dress","","a desert naga silk dress",0,0,
                "",
        "",false,false);
        setColor();
		CoC.timeAwareClassAdd(this);
    }
    public function setColor(color:String="purple"):void
    {
        _name = "desert naga "+color+" and black silk dress";
        _longName = "a "+color+" desert naga silk dress";
        _description = "A very seductive dress made for naga or females without a human set of legs. It has a black collar, bikini top, sleeves with golden bangles and a waistcloth, all decorated with a golden trim. The bottom has a "+color+" silk veil that runs down to what would be the human knee while the center of the bikini is also covered by a small strand of silk. It helps accentuate your curves and increase your natural charm. The dress obviously is so minimalist that you could as well say you are naked yet it looks quite classy on a tauric or naga body giving you the air of a master seducer.";
    }
    public override function get name():String{return _name;}
	override public function useText():void{ //Produces any text seen when equipping the armor normally
		outputText("You wear the dress and hiss like a snake. \n\n Where did that come from?.\n");
	}

	public function timeChangeLarge():Boolean {	return false;	}
		
	public function timeChange():Boolean {
		if (player.armor is NagaSilkDress && kGAMECLASS.time.hours == 5) { //only call function once per day as time change is called every hour
			Progression(); 
			return true;
		}
		return false; //stop if not wearing
		}
	public function Progression():void {

		var dreams:Array = ["That night you have a strange dream. You are in the desert basking in the sun.   You look down and notice that there are not legs attached to your lower body. There is a large" +
		" snake-like tail. Thinking about it seems to make your tail flip slightly.   \n\n"+
		"Some travelers can be sensed nearby.You cannot hear them. Can you smell them…. Taste them? The thought of tasting someone causes your tongue to fork out. Oh yes, your tongue can sense things some" +
		" distance away. Wait, did you always have a snake’s tongue?\n\n"+
		"When you awaken, you check yourself out to make sure you were not the person who you seemed to be in your dream.\n\n",

 
		"When you sleep that night you dream of going home to your sweetheart. You open the door and... slither... inside. Your sweetheart is happy to see you. The two of you passionately embrace.  \n\n" +
		"You move to kiss and your forked tongue moves from your mouth. At the same time your snake-like lower body entwines around them forcing the two of you closer together.  \n\n"+ 
		"Something doesn’t seem like it should be and it startles you awake. The image of the you in the dream and the you before you contrasts in your mind heavily.\n\n",


		"Laying down for the night, you find a strange dream awaiting you as soon as you doze off. The sun goes down and the night chill brings a very unwelcome cold that makes your whole body feel heavy." +
		" Your snake-like eyes sense heat just like your old eyes could see color, causing you to notice a pillar of heat off in the distance.\n\n"+
		"You slither your way towards the source an detect a campfire smouldering. Next to the campfire is a tent. The tent seems to have a very enticing heat source inside.  \n\n"+
		"Your heat sensing eye detects the outline of a person after opening the flap. You quietly enter and proceed to position your snake-like lower half to wrap around the person." +
		" With a snap, you have the figure completely coiled.  \n\n"+
		"What happens next becomes very fuzzy in your dream.\n\n"+
		"Dawn breaks and awaken to you find yourself craving a warm body close to yours.",

		"That night you have a strange dream about being a naga.\n\n"+
		"It is a cold day outside so you go and prepare yourself a warm bath. You strip down and hop into the bath, making a nice splash. You coil your tail into the hot water, and plop the tip of your" +
		" snake-like lower half out of the water, wiggling it around a little bit.\n\n"+
		"There is a knock on the door.\n\n"+
		"“Honey, may I come in?” a familiar voice echoes from the other side of the door.\n\n"+
		"You wake up a little confused about your current self. Fantasies about two lovers in a bath together swirl about in your imagination. \n\n",    

		"You have a dream that night where you are lounging in a tree planning naughty schemes.\n\n"+
		"You are in the tree with your snake-like tail coiled around a branch enjoying the hot sun. A rather attractive person walks into the tree’s shade and sits down. Likely they are just trying to cool off.\n\n"+
		"This is a good time to surprise them - - - The thought occurs to you and you act on it a moment later. You ball up your snakelike lower half and strike with swiftness. \n\n"+
		"With precision you land a kiss right on the lips of the attractive victim below. They have no idea and stumble to the ground in surprise. Eventually, they look up and see you there smirking.\n\n"+
		"Being a naga is so fun.\n\n"+
		"What a weird dream...\n\n",

		"Lying down for the night brings strange dreams about yourself as a naga.\n\n"+
		"You are lying in bed with your lover. You turn over and move your tail a bit. Your lover gasps in shock after noticing a slithering at the end of the bed.\n\n"+
		"“Snake!” They scream.\n\n"+
		"“Silly, that’s just me.” You reply.\n\n"+
		"When morning comes you have to check to see if your lower half is snake-like or not.\n\n",

		"You and your special someone are going in a walk in the hot desert sun. Eventually, you come upon an oasis. After finding a good spot in the sand by the water, you and your " +
		"lover sit down and cuddle together.\n\n"+
		"Their arm wraps around your shoulder and your snake tail rises and rests on their shoulder.  \n\n"+
		"Hmmm… snake tail.\n\n"+
		"When you wake up you have to look yourself over. That dream seemed so real.\n\n",

		"In your dreams you are wandering and spot your hometown in Ingram off in the distance. It sure would be nice to go home.  \n\n"+
		"You find your house and go inside. You hear a noise and someone comes in from the other room.  Shockingly, that person is you, looking completely human. [he] shouts, “Monster ! What are you doing in my home?\n\n"+
		"You say, “I’m not a monster, this is my home, why do you look like me?”\n\n"+
		"Before protesting more you notice a mirror and see yourself in it; a full naga with snake eyes, a tail and forked tongue.\n\n",

		"You have a dream about a naga being hunted by demons.\n\n"+
		"The naga is fighting off demon dogs while they bark and bite. Lots of biting, barking and coiling happens. The result is a dozen defeated demon dogs and one wounded naga.  \n\n"+
		"You approach the wounded naga who begs for help before the demons that released the dogs find her to finish the hunt.  \n\n"+
		"As soon as you agree she hugs you tightly, enveloping your face with her voluptuous breasts.\n\n"+
		"You awake wondering why you dream about nagas so often.\n\n"		];
		clearOutput();
		outputText("\n\n" + dreams[rand(dreams.length)] + "\n\n");
		outputText("Lucky Day!   You find a vial of snake oil in your dress and quicky quaff it down.\n\n");
		kGAMECLASS.consumables.SNAKOIL.useItem();
	}
}}
