package io.voodoo.game.drums {
	import com.deboutludo.core.CruftManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
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
		protected var _soundClass:Class;
		public function get soundClass():Class {
			return this._soundClass;
		}
		private var drumHandler:DrumHandler;
		private var cm:CruftManager;
		private var soundCM:CruftManager;
		
		// CONSTRUCTOR :
		public function Drum() {
			super();
			this.cm = new CruftManager();
			this.soundCM = new CruftManager();
			
			cm.addListener(this, TouchEvent.TOUCH_BEGIN, onDrumTapped);
			cm.addListener(this, TouchEvent.TOUCH_END, onDrumReleased);
			cm.addListener(this, TouchEvent.TOUCH_OUT, onDrumReleased);
			
			gotoAndStop(0);
		}
		
		public function init(givenDrumHandler:DrumHandler):void {
			this.drumHandler = givenDrumHandler;
			Log.info(TAG, "Drum " + type + " " + subType + " initialized.");
		}
		
		public function onDrumTapped(event:TouchEvent):void {
			Log.info(TAG, "Drum " + type + " tapped with subtype " + subType + " ...");
			this.soundCM.playSound(new _soundClass());
			gotoAndStop("down");
			
			drumHandler.registerDrum(this, getTimer());
		}
		
		public function onDrumReleased(event:TouchEvent):void {
			gotoAndStop("up");
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