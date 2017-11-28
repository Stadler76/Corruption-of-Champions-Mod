package coc.test {
	import classes.DefaultDict;
	import classes.internals.LoggerFactory;
	import coc.model.GameModel;
	import coc.view.MainView;
	import flash.display.MovieClip;
	import mx.logging.ILogger;

	public class TestMainView extends MovieClip {
		private static const LOGGER:ILogger = LoggerFactory.getLogger(TestMainView);
		public var mainView :MainView;
		public var gameModel :GameModel;

		public function TestMainView() :void {
			// This variable is used to maintain a reference to the Test's
			// this in unbound functions.
			var testThis :TestMainView = this;

			this.gameModel = new GameModel();
			this.mainView = new MainView( this.gameModel );
			this.stage.addChild( this.mainView );

			this.gameModel.flags = new DefaultDict();

			LOGGER.debug( "MainView:", this.mainView );

			this.gameModel.flags[kFLAGS. 273 ] = 0;
			this.mainView.selectSprite( 2 );

			// TODO: put in actual callbacks here because that be how we do, now.
			this.mainView.setButton( 0, 'Lol' );
			this.mainView.setButton( 4, 'Poop' );
			this.mainView.setButton( 6, 'Penis' );
			this.mainView.setButton( 9, 'Clear Buttons' );
			this.mainView.setButton( 8, '' );

			LOGGER.debug( "test: hasButton( 'Lol' )?\n\t",
				this.mainView.hasButton( 'Lol' ), "(Should be 'true')" );

			LOGGER.debug( "test: indexOfButtonWithLabel( 'Poop' )?\n\t",
				this.mainView.indexOfButtonWithLabel( 'Poop' ), "(Should be '4')" );

			LOGGER.debug( "test: getButtonText( 6 ) =>\n\t",
				this.mainView.getButtonText( 6 ), "(Should be 'Penis')" );

			LOGGER.debug( "test: buttonTextIsOneOf( 6, [ 'Peepee', 'Dingaling', 'Penis', 'Cock', 'Doodle', 'Dick', 'Sausage' ] )\n\t",
				this.mainView.buttonTextIsOneOf( 6, [ 'Peepee', 'Dingaling', 'Penis', 'Cock', 'Doodle', 'Dick', 'Sausage' ] ),
				"(Should be 'true')" );

			LOGGER.debug( "test: buttonIsVisible( 0 ) =>\n\t",
				this.mainView.buttonIsVisible( 0 ),
				"(Should be 'true')" );

			LOGGER.debug( "test: buttonIsVisible( 8 ) =>\n\t",
				this.mainView.buttonIsVisible( 8 ),
				"(Should be 'false')" );

			LOGGER.debug( "test: menuButtonHasLabel( 'newGame', 'New Game' )?\n\t",
				this.mainView.menuButtonHasLabel( 'newGame', 'New Game' ),
				"(Should be 'true')" );

			function makeButtonTracer( name :String ) :Function {
				return function( event ) {
					LOGGER.debug( "You pressed the", name, "button!" );
				};
			}

			this.mainView.onNewGameClick = makeButtonTracer( "NewGame" );
			this.mainView.onDataClick = makeButtonTracer( "Data" );
			this.mainView.onStatsClick = makeButtonTracer( "Stats" );
			this.mainView.onLevelClick = makeButtonTracer( "Level" );
			this.mainView.onPerksClick = makeButtonTracer( "Perks" );
			this.mainView.onAppearanceClick = makeButtonTracer( "Appearance" );

			this.mainView.setButton( 2, 'Hide Menu' );
			this.mainView.setButton( 3, 'Show Menu' );
		};
	}
}