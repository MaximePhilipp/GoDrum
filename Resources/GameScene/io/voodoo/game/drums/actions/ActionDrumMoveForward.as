package io.voodoo.game.drums.actions {
	import flash.events.MouseEvent;
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	import io.voodoo.game.sounds.Drum05;
	
	
	/**
	 *
	 */
	public class ActionDrumMoveForward extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumMoveForward() {
			super();
			this._subType = ActionDrum.MOVE_FORWARD;
			this._soundClass = Drum05;
		}
	}
}