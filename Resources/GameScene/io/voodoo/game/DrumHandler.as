package io.voodoo.game {
	import com.deboutludo.core.CruftManager;
	
	import flash.utils.getTimer;
	
	import io.voodoo.game.drums.Drum;
	import io.voodoo.game.sounds.FailSound;
	
	/**
	 *
	 */
	public class DrumHandler {
		private static const TAG:String = "DrumHandler";
		
		// CONSTANTS :
		private static const BEAT_TOLERANCE:int = 70;
		
		// PROPERTIES :
		private var currentCommand:Command;
		/** This property is synchronized at each beat loop. */
		public var startTime:int;
		private var beatTime:int;
		private var soundCM:CruftManager;
		
		// CONSTRUCTOR :
		public function DrumHandler(beatTime:int) {
			super();
			this.beatTime = beatTime;
			this.currentCommand = new Command();
			this.soundCM = new CruftManager();
			
			Log.info(TAG, "startTime : " + startTime);
		}
		
		
		public function registerDrum(drum:Drum, time:int):void {
			var timeInterval:int = (time - startTime) % beatTime;
			
			if(timeInterval < BEAT_TOLERANCE || Math.abs(timeInterval - beatTime) < BEAT_TOLERANCE) {
				Log.info(TAG, "Adding the drum " + drum.subType + " to the current command ... (Time interval : " + timeInterval + ")");
				currentCommand.addDrum(drum);
				currentCommand.checkCommand();
			}
			else {
				Log.info(TAG, "Incorrect beat, resetting the command. (Time interval : " + timeInterval + ")");
				soundCM.playSound(new FailSound());
				currentCommand.resetCommand();
			}
		}
	}
}