package io.voodoo.game.drums {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	
	
	/**
	 *
	 */
	public class TargetDrum extends Drum {
		
		// CONSTANTS :
		public static const ITSELF:String = "TargetDrum.Itself";
		public static const ENEMY:String = "TargetDrum.Enemy";
		public static const ITEM:String = "TargetDrum.Item";
		
		// CONSTRUCTOR :
		public function TargetDrum() {
			super();
			this._type = Drum.TARGET;
		}
	}
}