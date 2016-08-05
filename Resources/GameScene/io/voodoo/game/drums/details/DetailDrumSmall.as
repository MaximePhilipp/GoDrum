package io.voodoo.game.drums.details {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.DetailDrum;
	import io.voodoo.game.sounds.Drum08;
	
	
	/**
	 *
	 */
	public class DetailDrumSmall extends DetailDrum {
		
		// CONSTRUCTOR :
		public function DetailDrumSmall() {
			super();
			this._subType = DetailDrum.SMALL;
			this._soundClass = Drum08;
		}
	}
}