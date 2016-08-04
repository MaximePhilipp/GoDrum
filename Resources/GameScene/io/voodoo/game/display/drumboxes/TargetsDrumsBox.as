package io.voodoo.game.display.drumboxes {
	import flash.display.Sprite;
	
	import io.voodoo.game.drums.targets.TargetDrumEnemy;
	import io.voodoo.game.drums.targets.TargetDrumItem;
	import io.voodoo.game.drums.targets.TargetDrumItself;
	
	
	/**
	 *
	 */
	public class TargetsDrumsBox extends Sprite {
		
		// FLASH ELEMENTS :
		public var itselfDrum:TargetDrumItself;
		public var itemDrum:TargetDrumItem;
		public var enemyDrum:TargetDrumEnemy;
		
		// CONSTRUCTOR :
		public function TargetsDrumsBox() {
			super();
		}
	}
}