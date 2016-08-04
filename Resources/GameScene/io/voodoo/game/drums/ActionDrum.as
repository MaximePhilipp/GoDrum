package io.voodoo.game.drums {
	import flash.media.Sound;
	
	
	/**
	 *
	 */
	public class ActionDrum extends Drum {
		
		// CONSTANTS :
		public static const MOVE_FORWARD:String = "ActionDrum.MoveForward";
		public static const MOVE_BAKCWARDS:String = "ActionDrum.MoveBackward";
		public static const LIFT:String = "ActionDrum.Lift";
		public static const LAY:String = "ActionDrum.Lay";
		public static const ATTACK:String = "ActionDrum.Attack";
		public static const DEFEND:String = "ActionDrum.Defend";
		
		// CONSTRUCTOR :
		public function ActionDrum(subtype:String, sound:Sound) {
			super(Drum.ACTION, subtype, sound);
		}
	}
}