package io.voodoo.game.drums.targets {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.TargetDrum;
	import io.voodoo.game.sounds.Drum11;
	
	
	/**
	 *
	 */
	public class TargetDrumItself extends TargetDrum {
		
		// CONSTRUCTOR :
		public function TargetDrumItself() {
			super();
			this._subType = TargetDrum.ITSELF;
			this._soundClass = Drum11;
		}
	}
}