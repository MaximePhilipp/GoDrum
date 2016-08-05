package io.voodoo.game.drums.details {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.DetailDrum;
	import io.voodoo.game.sounds.Drum06;
	
	
	/**
	 *
	 */
	public class DetailDrumBig extends DetailDrum {
		
		// CONSTRUCTOR :
		public function DetailDrumBig() {
			super();
			this._subType = DetailDrum.BIG;
			this._soundClass = Drum06;
		}
	}
}