package io.voodoo.game.drums.actions {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	
	
	/**
	 *
	 */
	public class ActionDrumMoveForward extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumMoveForward() {
			super();
			this._subType = ActionDrum.MOVE_FORWARD;
			// TODO
			this.sound = sound;
		}
	}
}