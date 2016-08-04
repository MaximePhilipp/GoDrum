package io.voodoo.game.drums {
	import flash.media.Sound;
	
	
	/**
	 *
	 */
	public class DetailDrum extends Drum {
		
		// CONSTANT :
		public static const BIG:String = "DetailDrum.Big";
		public static const SMALL:String = "DetailDrum.Small";
		public static const FAST:String = "DetailDrum.Fast";
 		
		// CONSTRUCTOR :
		public function DetailDrum(subtype:String, sound:Sound) {
			super(Drum.DETAIL, subtype, sound);
		}
	}
}