package io.voodoo.game.drums.actions {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	import io.voodoo.game.sounds.Drum04;
	
	
	/**
	 *
	 */
	public class ActionDrumMoveBackwards extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumMoveBackwards() {
			super();
			this._subType = ActionDrum.MOVE_BAKCWARDS;
			this._soundClass = Drum04;
		}
	}
}