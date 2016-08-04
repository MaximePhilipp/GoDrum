package io.voodoo.game.drums {
	import flash.media.Sound;
	
	
	/**
	 *
	 */
	public class TargetDrum extends Drum {
		
		// CONSTANTS :
		public static const ITSELF:String = "TargetDrum.Itself";
		public static const ENEMY:String = "TargetDrum.Enemy";
		public static const ITEM:String = "TargetDrum.Item";
		
		// CONSTRUCTOR :
		public function TargetDrum(subtype:String, sound:Sound) {
			super(Drum.TARGET, subtype, sound);
		}
	}
}