package io.voodoo.game {
	import com.deboutludo.core.MovieClipModule;
	import com.deboutludo.core.Sequence;
	import com.deboutludo.display.Display;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Power2;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import io.voodoo.game.drums.Drum;
	import io.voodoo.game.sounds.Beat;
	
	
	/**
	 *
	 */
	public class GoDrumGameScene extends MovieClipModule {
		private static const TAG:String = "GoDrumGameScene";
		
		// CONSTANTS :
		// The time between each beat, in ms.
		private static const BEAT_PERIOD:int = 476;
		private static const BEAT_DISPLAYER_MARGIN:int = 10;
		private static const BEAT_DISPLAYER_THICKNESS:int = 5;
		
		// FLASH ELEMENTS :
		public var actionDrumTab:SimpleButton;
		public var targetDrumTab:SimpleButton;
		public var detailDrumTab:SimpleButton;
		
		// PROPERTIES :
		private var drumHandler:DrumHandler;
		private var beatDisplayer:Sprite;
		private var beatDisplayerTween:TweenMax;
		private var _currentDrumTab:String;
		public function get currentDrumTab():String {
			return this._currentDrumTab;
		}
		public function set currentDrumTab(value:String):void {
			if(value == _currentDrumTab)
				return;
			
			_currentDrumTab = value;
			Log.info(TAG, "Current drum tab changed, now " + value);
			
			updateAvailableDrums();
		}
		
		// Debug
		private var keysDown:Vector.<uint>;
		private var actionTabUpState:DisplayObject;
		private var actionTabDownState:DisplayObject;
		private var targetTabUpState:DisplayObject;
		private var targetTabDownState:DisplayObject;
		private var detailTabUpState:DisplayObject;
		private var detailTabDownState:DisplayObject;
		
		
		// CONSTRUCTOR :
		public function GoDrumGameScene() {
			super();
		}
		
		
		// LIFECYCLE :
		override protected function onPrepare():void {
			cm.addListener(actionDrumTab, MouseEvent.MOUSE_DOWN, onActionDrumTabTouched);
			cm.addListener(targetDrumTab, MouseEvent.MOUSE_DOWN, onTargetDrumTabTouched);
			cm.addListener(detailDrumTab, MouseEvent.MOUSE_DOWN, onDetailDrumTabTouched);
			
			super.onPrepare();
		}
		
		override protected function onShow(parent:DisplayObjectContainer, index:int):void {
			
			var screen:Rectangle = Display.getVisibleBounds(this);
			this.actionDrumTab.x = screen.x - 20;
			this.targetDrumTab.x = screen.x - 20;
			this.detailDrumTab.x = screen.x - 20;
			
			this.actionDrumTab.alpha = this.targetDrumTab.alpha = this.detailDrumTab.alpha = 0.6;
			
			this.generateBeatDisplayer();
			this.addChildAt(this.beatDisplayer, 0);
			
			super.onShow(parent, index);
		}
		
		override protected function onStart():void {
			
			this.drumHandler = new DrumHandler(BEAT_PERIOD);
			startBeat();
			
			// Debug
			this.registerDebugAssets();
			
			super.onStart();
		}
		
		
		
		// BEAT :
		private function startBeat():void {
			if(beatDisplayerTween != null)
				beatDisplayerTween.kill();
			beatDisplayer.alpha = 1;
			beatDisplayerTween = TweenMax.to(this.beatDisplayer, (BEAT_PERIOD/1000)/2.0, {alpha:0, repeat:-1, yoyo:true});
			
			this.drumHandler.startTime = getTimer();
			new Sequence(this).playSound(new Beat())
				.call(startBeat)
				.start();
		}
		
		
		
		
		
		
		
		
		
		// DISPLAY :
		private function updateAvailableDrums():void {
			
			this.actionDrumTab.alpha = this.targetDrumTab.alpha = this.detailDrumTab.alpha = 0.6;
			
			if(_currentDrumTab == Drum.ACTION) {
				this.setChildIndex(actionDrumTab, this.numChildren - 1);
				this.actionDrumTab.alpha = 1;
			}
			else if(_currentDrumTab == Drum.TARGET) {
				this.setChildIndex(targetDrumTab, this.numChildren - 1);
				this.targetDrumTab.alpha = 1;
			}
			else if(_currentDrumTab == Drum.DETAIL) {
				this.setChildIndex(detailDrumTab, this.numChildren - 1);
				this.detailDrumTab.alpha = 1;
			}
			
			// TODO
		}
		
		private function generateBeatDisplayer():void {
			this.beatDisplayer = new Sprite();
			var screen = Display.getVisibleBounds(this);
			
			beatDisplayer.graphics.beginFill(0xffffff, 1);
			beatDisplayer.graphics.drawRect(screen.x + BEAT_DISPLAYER_MARGIN, screen.y + BEAT_DISPLAYER_MARGIN, screen.width - (2*BEAT_DISPLAYER_MARGIN), BEAT_DISPLAYER_THICKNESS);
			beatDisplayer.graphics.drawRect(screen.x + BEAT_DISPLAYER_MARGIN, screen.y + BEAT_DISPLAYER_MARGIN + BEAT_DISPLAYER_THICKNESS, BEAT_DISPLAYER_THICKNESS, screen.height - (2 * (BEAT_DISPLAYER_MARGIN + BEAT_DISPLAYER_THICKNESS)));
			beatDisplayer.graphics.drawRect(screen.x + screen.width - BEAT_DISPLAYER_MARGIN - BEAT_DISPLAYER_THICKNESS, screen.y + BEAT_DISPLAYER_MARGIN + BEAT_DISPLAYER_THICKNESS, BEAT_DISPLAYER_THICKNESS, screen.height - (2 * (BEAT_DISPLAYER_MARGIN + BEAT_DISPLAYER_THICKNESS)));
			beatDisplayer.graphics.drawRect(screen.x + BEAT_DISPLAYER_MARGIN, screen.y + screen.height - BEAT_DISPLAYER_MARGIN - BEAT_DISPLAYER_THICKNESS, screen.width - (2*BEAT_DISPLAYER_MARGIN), BEAT_DISPLAYER_THICKNESS);
			beatDisplayer.graphics.endFill();
		}
		
		
		
		
		
		
		// CALLBAKCS :
		private function onActionDrumTabTouched(event:MouseEvent):void {
			currentDrumTab = Drum.ACTION;
		}
		
		private function onTargetDrumTabTouched(event:MouseEvent):void {
			currentDrumTab = Drum.TARGET;
		}
		
		private function onDetailDrumTabTouched(event:MouseEvent):void {
			currentDrumTab = Drum.DETAIL;
		}
		
		
		// DEBUG CALLBACKS :
		private function registerDebugAssets():void {
			this.keysDown = new Vector.<uint>();
			
			// DEBUG
			cm.addListener(stage, KeyboardEvent.KEY_DOWN, onDebugKeyDown);
			cm.addListener(stage, KeyboardEvent.KEY_UP, onDebugKeyUp);
			
			actionTabUpState = actionDrumTab.upState;
			actionTabDownState = actionDrumTab.downState;
			targetTabUpState = targetDrumTab.upState;
			targetTabDownState = targetDrumTab.downState;
			detailTabUpState = detailDrumTab.upState;
			detailTabDownState = detailDrumTab.downState;
		}
		
		private function onDebugKeyDown(event:KeyboardEvent):void {
			if(this.keysDown.indexOf(event.keyCode) != -1)
				return;
			
			this.keysDown.push(event.keyCode);
			handleKeyPressed();
		}
		
		private function onDebugKeyUp(event:KeyboardEvent):void {
			this.keysDown.splice(this.keysDown.indexOf(event.keyCode), 1);
			handleKeyPressed();
		}
		
		private function handleKeyPressed():void {
			var tmpDrumTab:String = null;
			
			var i:int, n:int = keysDown.length;
			for(i = 0 ; i < n ; i++) {
				if(keysDown[i] == Keyboard.A)
					tmpDrumTab = Drum.ACTION;
				else if(keysDown[i] == Keyboard.Z)
					tmpDrumTab = Drum.TARGET;
				else if(keysDown[i] == Keyboard.E)
					tmpDrumTab = Drum.DETAIL;
				
				if(keysDown[i] == Keyboard.P) {
					drumHandler.registerDrum("toto", getTimer());
				}
			}
			
			if(tmpDrumTab != currentDrumTab) {
				actionDrumTab.upState = actionTabUpState;
				targetDrumTab.upState = targetTabUpState;
				detailDrumTab.upState = detailTabUpState;
				
				if(tmpDrumTab == Drum.ACTION)
					actionDrumTab.upState = actionTabDownState;
				else if(tmpDrumTab == Drum.TARGET)
					targetDrumTab.upState = targetTabDownState;
				else if(tmpDrumTab == Drum.DETAIL)
					detailDrumTab.upState = detailTabDownState;
			}
			
			currentDrumTab = tmpDrumTab;
		}
	}
}