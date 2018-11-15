package classes.Scenes {

import classes.Scenes.NPCs.IsabellaSceneTest;
import classes.Scenes.NPCs.JojoSceneTest;
import classes.Scenes.NPCs.IsabellaFollowerSceneTest;
import classes.Scenes.NPCs.JojoTest;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
	public class NPCsSuite
	{
		 public var jojoSceneTest:JojoSceneTest;
		 public var isabellaSceneTest : IsabellaSceneTest;
		 public var isabellaFollowerSceneTest:IsabellaFollowerSceneTest;
		 public var jojoTest:JojoTest
	}
}
