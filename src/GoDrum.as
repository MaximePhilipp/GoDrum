package {
	import com.deboutludo.display.Display;
	import com.deboutludo.utils.Stats;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import io.voodoo.App;
	
	
	/**
	 * Main class of the app.
	 */
	[SWF(frameRate="60", width="1024", height="768", backgroundColor="0")]
	public class GoDrum extends Sprite {
		private static const TAG:String = "App";
		
		// CONSTANTS :
		private static const SHOW_STATS:Boolean = true;
		
		
		// CONSTRUCTOR
		public function GoDrum() {
			super();
			
			Log.init(Log.CONSOLE_ONLY);
			
			Log.info(TAG, "Debout Ludo started.");
			
			// Init display
			Display.init(stage);
			
			// Log some device infos :
			Log.info(TAG, "Device : " + Capabilities.manufacturer + " " + Capabilities.os + " (" + Capabilities.version + "), " +
				Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + "@" + Capabilities.screenDPI + "dpi");
			
			// Add stats :
			if(SHOW_STATS) {
				Log.info(TAG, "Adding stats ...");
				const stats:Stats = new Stats();
				stats.scaleX = 1 / Display.STATS_LAYER.scaleX;
				stats.scaleY = 1 / Display.STATS_LAYER.scaleY;
				stats.addEventListener(Event.ENTER_FRAME, positionStats);
				Display.STATS_LAYER.addChild(stats);
				function positionStats(ev:Event):void {
					stats.removeEventListener(Event.ENTER_FRAME, positionStats);
					const bounds:Rectangle = Display.getVisibleBounds(Display.STATS_LAYER);
					stats.x = bounds.x + bounds.width - stats.width;
					stats.y = bounds.y + bounds.height - stats.height;
				}
			}
			
			// Keep the device awake as long as the app is running
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			// Create the app singleton :
			Log.info(TAG, "Creating the App singleton instance ...");
			new App();
			
			// Handle uncaught errors :
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
			
			// Wait for the native application to be fully prepared before listening to its events :
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(ev:Event):void {
			if(!stage) 
				return;
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			// Handle App events :
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactivate);
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onActivate);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExit);
		}
		
		private function onActivate(ev:Event):void {
			App.instance.resume();
			Log.info(TAG, "App activated.");
		}
		
		private function onDeactivate(ev:Event):void {
			App.instance.pause();
			Log.info(TAG, "App deactivated.");
		}
		
		private function onExit(ev:Event):void {
			Log.info(TAG, "App exiting.");
			Log.dispose();
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			if (event.keyCode != Keyboard.BACK)
				return;
			
			Log.info(TAG, "Back button pressed");
			
			event.preventDefault();
			event.stopImmediatePropagation();
		}
		
		private function onUncaughtError(ev:UncaughtErrorEvent):void {
			Log.error(TAG, ev.error.message  + ev.error.getStackTrace());
		}
	}
}