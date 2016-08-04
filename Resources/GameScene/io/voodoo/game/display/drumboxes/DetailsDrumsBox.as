package io.voodoo.game.display.drumboxes {
	import flash.display.Sprite;
	
	import io.voodoo.game.drums.details.DetailDrumBig;
	import io.voodoo.game.drums.details.DetailDrumFast;
	import io.voodoo.game.drums.details.DetailDrumSmall;
	
	
	/**
	 *
	 */
	public class DetailsDrumsBox extends Sprite {
		
		// FLASH ELEMENTS :
		public var bigDrum:DetailDrumBig;
		public var smallDrum:DetailDrumSmall;
		public var fastDrum:DetailDrumFast;
		
		// CONSTRUCTOR :
		public function DetailsDrumsBox() {
			super();
		}
	}
}