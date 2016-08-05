package io.voodoo.game.maps {
	import com.greensock.TweenLite;
	import com.greensock.easing.Power1;
	
	import flash.display.Sprite;
	
	
	/**
	 *
	 */
	public class Map1 extends Sprite {
		
		// CONSTANTS :
		private static const MOVE_STEP:Number = 300;
		public static const MOVE_DURATION:Number = 3;
		
		// PROPERTIES :
		private var _currentGroundYPosition:Number;
		public function get currentGroundYPosition():Number {
			return _currentGroundYPosition;
		}
		
		// CONSTRUCTOR :
		public function Map1() {
			super();
			_currentGroundYPosition = 700.0;
			this.cacheAsBitmap = true;
		}
		
		public function moveForward():void {
			TweenLite.to(this, MOVE_DURATION, {x: this.x - MOVE_STEP,  ease:Power1.easeInOut});
		}
		
		public function moveBackwards():void {
			TweenLite.to(this, MOVE_DURATION, {x: this.x + MOVE_STEP, ease:Power1.easeInOut});
		}
	}
}