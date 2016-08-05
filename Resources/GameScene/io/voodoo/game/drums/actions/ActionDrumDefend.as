package io.voodoo.game.drums.actions {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	import io.voodoo.game.sounds.Drum02;
	
	
	/**
	 *
	 */
	public class ActionDrumDefend extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumDefend(){
			super();
			this._subType = ActionDrum.DEFEND;
			this._soundClass = Drum02;
		}
	}
}