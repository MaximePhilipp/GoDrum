package io.voodoo.game.drums.targets {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.TargetDrum;
	
	
	/**
	 *
	 */
	public class TargetDrumEnemy extends TargetDrum {
		
		// CONSTRUCTOR :
		public function TargetDrumEnemy() {
			super();
			this._subType = TargetDrum.ENEMY;
			// TODO
			this.sound = sound;
		}
	}
}