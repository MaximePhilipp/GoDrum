package io.voodoo.game.drums {
	import com.deboutludo.core.CruftManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import io.voodoo.game.DrumHandler;
	
	/**
	 *
	 */
	public class Drum extends MovieClip {
		private static const TAG:String = "Drum";
		
		// CONSTANTS :
		public static const ACTION:String = "Drum.Action";
		public static const TARGET:String = "Drum.Target";
		public static const DETAIL:String = "Drum.Detail";
		
		// PROPERTIES :
		protected var _type:String;
		public function get type():String {
			return this._type;
		}
		protected var _subType:String;
		public function get subType():String {
			return this._subType;
		}
		protected var sound:Sound;
		private var _drumHandler:DrumHandler;
		private function set drumHandler(value:DrumHandler):void {
			this._drumHandler = value;
			Log.info(TAG, "New value is " + value);
		}
		private function get drumHandler():DrumHandler {
			return _drumHandler;
		}
		private var cm:CruftManager;
		private var soundCM:CruftManager;
		
		// CONSTRUCTOR :
		public function Drum() {
			super();
			this.cm = new CruftManager();
			this.soundCM = new CruftManager();
			
			cm.addListener(this, MouseEvent.MOUSE_DOWN, onDrumTapped);
			cm.addListener(this, MouseEvent.MOUSE_UP, onDrumReleased);
			cm.addListener(this, MouseEvent.RELEASE_OUTSIDE, onDrumReleased);
			
			gotoAndStop(0);
		}
		
		public function init(givenDrumHandler:DrumHandler):void {
			this.drumHandler = givenDrumHandler;
			Log.info(TAG, "Drum " + type + " " + subType + " initialized.");
		}
		
		private function onDrumTapped(event:MouseEvent):void {
			Log.info(TAG, "Drum " + type + " tapped with subtype " + subType + " ...");
			//this.soundCM.playSound(sound);
			gotoAndStop(1);
			
			drumHandler.registerDrum(subType, getTimer());
		}
		
		private function onDrumReleased(event:MouseEvent):void {
			gotoAndStop(0);
		}
		
		
		// CLEANUP :
		public function dispose():void {
			if(cm != null) {
				cm.cleanup();
				cm = null;
			}
			if(soundCM != null) {
				soundCM.cleanup();
				soundCM = null;
			}
		}
	}
}