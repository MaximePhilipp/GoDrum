package io.voodoo.game.drums.targets {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.TargetDrum;
	
	
	/**
	 *
	 */
	public class TargetDrumItself extends TargetDrum {
		
		// CONSTRUCTOR :
		public function TargetDrumItself() {
			super();
			this._subType = TargetDrum.ITSELF;
			// TODO
			this.sound = sound;
		}
	}
}