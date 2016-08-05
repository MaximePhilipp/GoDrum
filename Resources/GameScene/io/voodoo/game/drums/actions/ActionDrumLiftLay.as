package io.voodoo.game.drums.actions {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	import io.voodoo.game.sounds.Drum03;
	
	
	/**
	 *
	 */
	public class ActionDrumLiftLay extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumLiftLay() {
			super();
			this._subType = ActionDrum.LIFT;
			this._soundClass = Drum03;
		}
	}
}