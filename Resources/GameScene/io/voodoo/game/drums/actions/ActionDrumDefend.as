package io.voodoo.game.drums.actions {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	
	
	/**
	 *
	 */
	public class ActionDrumDefend extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumDefend(){
			super();
			this._subType = ActionDrum.DEFEND;
			// TODO
			this.sound = sound;
		}
	}
}