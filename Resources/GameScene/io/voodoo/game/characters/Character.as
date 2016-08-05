package io.voodoo.game.characters {
	import com.deboutludo.utils.randRangeNum;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	
	
	/**
	 *
	 */
	public class Character extends MovieClip {
		private static const TAG:String = "Character";
		
		// FRAMES NAMES:
		
		// CONSTRUCTOR :
		public function Character() {
			super();
		}
		
		public function breathe():void {
			TweenLite.delayedCall(randRangeNum(0.0, 0.7), gotoAndPlay, ["breathe"]); 
		}
		
		public function walk():void {
			gotoAndPlay("walk");
		}
	}
}