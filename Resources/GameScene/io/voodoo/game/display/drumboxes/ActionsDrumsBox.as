package io.voodoo.game.display.drumboxes {
	import flash.display.Sprite;
	
	import io.voodoo.game.drums.actions.ActionDrumAttack;
	import io.voodoo.game.drums.actions.ActionDrumDefend;
	import io.voodoo.game.drums.actions.ActionDrumLiftLay;
	import io.voodoo.game.drums.actions.ActionDrumMoveBackwards;
	import io.voodoo.game.drums.actions.ActionDrumMoveForward;
	
	
	/**
	 *
	 */
	public class ActionsDrumsBox extends Sprite {
		
		// FLASH ELEMENTS :
		public var moveForwardDrum:ActionDrumMoveForward;
		public var moveBackwardsDrum:ActionDrumMoveBackwards;
		public var liftLayDrum:ActionDrumLiftLay;
		public var attackDrum:ActionDrumAttack;
		public var defendDrum:ActionDrumDefend;
		
		// CONSTRUCTOR :
		public function ActionsDrumsBox() {
			super();
		}
	}
}