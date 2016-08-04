package io.voodoo.game {
	import flash.utils.getTimer;
	
	/**
	 *
	 */
	public class DrumHandler {
		private static const TAG:String = "DrumHandler";
		
		// CONSTANTS :
		private static const BEAT_TOLERANCE:int = 70;
		
		// PROPERTIES :
		private var currentCommand:Vector.<String>;
		/** This property is synchronized at each beat loop. */
		public var startTime:int;
		private var beatTime:int;
		
		// CONSTRUCTOR :
		public function DrumHandler(beatTime:int) {
			super();
			this.beatTime = beatTime;
			
			Log.info(TAG, "startTime : " + startTime);
		}
		
		
		public function registerDrum(drumSubtype:String, time:int):void {
			var timeInterval:int = (time - startTime) % beatTime;
			
			if(timeInterval < BEAT_TOLERANCE || Math.abs(timeInterval - beatTime) < BEAT_TOLERANCE) {
				Log.info(TAG, "Adding the drum " + drumSubtype + " to the current command ... (Time interval : " + timeInterval + ")");
			}
			else {
				Log.info(TAG, "Incorrect beat, resetting the command. (Time interval : " + timeInterval + ")");
			}
		}
		
		
		private function checkCurrentCommand():void {
			
		}
	}
}