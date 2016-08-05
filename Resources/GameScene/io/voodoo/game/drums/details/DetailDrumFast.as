package io.voodoo.game.drums.details {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.DetailDrum;
	import io.voodoo.game.sounds.Drum07;
	
	
	/**
	 *
	 */
	public class DetailDrumFast extends DetailDrum {
		
		// CONSTRUCTOR :
		public function DetailDrumFast() {
			super();
			this._subType = DetailDrum.FAST;
			this._soundClass = Drum07;
		}
	}
}