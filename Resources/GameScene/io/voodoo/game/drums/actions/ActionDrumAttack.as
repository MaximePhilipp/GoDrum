package io.voodoo.game.drums.actions {
	import flash.media.Sound;
	
	import io.voodoo.game.DrumHandler;
	import io.voodoo.game.drums.ActionDrum;
	import io.voodoo.game.sounds.Drum01;
	
	
	/**
	 *
	 */
	public class ActionDrumAttack extends ActionDrum {
		
		// CONSTRUCTOR :
		public function ActionDrumAttack(){
			super();
			this._subType = ActionDrum.ATTACK;
			this._soundClass = Drum01;
		}
	}
}