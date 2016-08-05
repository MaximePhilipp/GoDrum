package io.voodoo.game.drums.targets {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.TargetDrum;
	import io.voodoo.game.sounds.Drum10;
	
	
	/**
	 *
	 */
	public class TargetDrumItem extends TargetDrum {
		
		// CONSTRUCTOR :
		public function TargetDrumItem() {
			super();
			this._subType = TargetDrum.ITEM;
			this._soundClass = Drum10;
		}
	}
}