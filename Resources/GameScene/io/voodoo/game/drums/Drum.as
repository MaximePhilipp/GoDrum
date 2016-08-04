package io.voodoo.game.drums {
	import com.deboutludo.core.CruftManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.ui.Mouse;
	
	/**
	 *
	 */
	public class Drum extends Sprite{
		private static const TAG:String = "Drum";
		
		// CONSTANTS :
		public static const ACTION:String = "Drum.Action";
		public static const TARGET:String = "Drum.Target";
		public static const DETAIL:String = "Drum.Detail";
		
		// PROPERTIES :
		private var _type:String;
		public function get type():String {
			return this._type;
		}
		private var _subType:String;
		public function get subType():String {
			return this._subType;
		}
		private var sound:Sound;
		private var soundCM:CruftManager;
		
		// CONSTRUCTOR :
		public function Drum(type:String, subtype:String, sound:Sound) {
			super();
			this._type = type;
			this._subType = subtype;
			this.sound = sound;
			this.soundCM = new CruftManager();
			
			this.addEventListener(MouseEvent.CLICK, onDrumTapped);
		}
		
		private function onDrumTapped(event:MouseEvent):void {
			Log.info(TAG, "Drum " + type + " tapped with subtype " + subType + " ...");
			this.soundCM.playSound(sound);
			// TODO add this drum to the current command.
		}
	}
}