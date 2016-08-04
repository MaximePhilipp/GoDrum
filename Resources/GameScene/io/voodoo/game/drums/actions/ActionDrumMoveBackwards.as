package io.voodoo.game.drums.actions {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	
	
	/**
	 *
	 */
	public class ActionDrumMoveBackwards extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumMoveBackwards() {
			super();
			this._subType = ActionDrum.MOVE_BAKCWARDS;
			// TODO
			this.sound = sound;
		}
	}
}