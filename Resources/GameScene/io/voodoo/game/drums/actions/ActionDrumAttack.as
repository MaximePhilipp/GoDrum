package io.voodoo.game.drums.actions {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	
	
	/**
	 *
	 */
	public class ActionDrumAttack extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumAttack(){
			super();
			this._subType = ActionDrum.ATTACK;
			// TODO
			this.sound = sound;
		}
	}
}