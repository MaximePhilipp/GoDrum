package io.voodoo.game.drums.targets {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.TargetDrum;
	import io.voodoo.game.sounds.Drum09;
	
	
	/**
	 *
	 */
	public class TargetDrumEnemy extends TargetDrum {
		
		// CONSTRUCTOR :
		public function TargetDrumEnemy() {
			super();
			this._subType = TargetDrum.ENEMY;
			this._soundClass = Drum09;
		}
	}
}