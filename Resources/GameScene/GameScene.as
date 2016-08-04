package {
	import com.deboutludo.core.ModuleEvent;
	import com.deboutludo.display.Display;
	import com.deboutludo.utils.ScreenCapture;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	
	import io.voodoo.game.GoDrumGameScene;
	
	
	/**
	 *
	 */
	public class GameScene extends Sprite {
		
		private var game:GoDrumGameScene;
		
		// CONSTRUCTOR :
		public function GameScene() {
			Log.info("Main", "Starting up ...");
			Log.init(Log.CONSOLE_ONLY);
			Display.init(stage, Capabilities.os.toLowerCase().indexOf("win") != -1);
			ScreenCapture.init(stage);
			
			game = new GoDrumGameScene();
			game.addListener(ModuleEvent.PREPARED, game.show, Display.CONTENT_LAYER);
			game.addListener(ModuleEvent.SHOWN, game.start);
			game.prepare();
			
			Log.info("Main", "Init complete");
		}
	}
}