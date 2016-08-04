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
	
	import io.voodoo.game.display.drumboxes.ActionsDrumsBox;
	import io.voodoo.game.display.drumboxes.DetailsDrumsBox;
	import io.voodoo.game.display.drumboxes.TargetsDrumsBox;
	import io.voodoo.game.drums.DetailDrum;
	import io.voodoo.game.drums.Drum;
	import io.voodoo.game.drums.actions.ActionDrumAttack;
	import io.voodoo.game.drums.actions.ActionDrumDefend;
	import io.voodoo.game.drums.actions.ActionDrumLiftLay;
	import io.voodoo.game.drums.actions.ActionDrumMoveBackwards;
	import io.voodoo.game.drums.actions.ActionDrumMoveForward;
	import io.voodoo.game.drums.details.DetailDrumBig;
	import io.voodoo.game.drums.details.DetailDrumFast;
	import io.voodoo.game.drums.details.DetailDrumSmall;
	import io.voodoo.game.drums.targets.TargetDrumEnemy;
	import io.voodoo.game.drums.targets.TargetDrumItem;
	import io.voodoo.game.drums.targets.TargetDrumItself;
	import io.voodoo.game.sounds.Beat2;
	
	
	/**
	 *
	 */
	public class GoDrumGameScene extends MovieClipModule {
		private static const TAG:String = "GoDrumGameScene";
		
		// CONSTANTS :
		// The time between each beat, in ms.
		private static const BEAT_PERIOD:int = 666;
		private static const BEAT_DISPLAYER_MARGIN:int = 10;
		private static const BEAT_DISPLAYER_THICKNESS:int = 5;
		private static const DRUMS_APPEAR_ANIMATION_DURATION:Number = 0.1;
		
		// FLASH ELEMENTS :
		public var actionDrumTab:SimpleButton;
		public var targetDrumTab:SimpleButton;
		public var detailDrumTab:SimpleButton;
		public var actionsDrumBox:ActionsDrumsBox;
		public var targetsDrumBox:TargetsDrumsBox;
		public var detailsDrumBox:DetailsDrumsBox;
		
		
		// PROPERTIES :
		private var drumHandler:DrumHandler;
		private var beatDisplayer:Sprite;
		private var beatDisplayerTween:TweenMax;
		private var screen:Rectangle;
		private var _currentDrumTab:String;
		public function get currentDrumTab():String {
			return this._currentDrumTab;
		}
		public function set currentDrumTab(value:String):void {
			if(value == _currentDrumTab)
				return;
			
			actionsDrumBox.x = targetsDrumBox.x = detailsDrumBox.x = screen.width;
			
			_currentDrumTab = value;
			Log.info(TAG, "Current drum tab changed, now " + value);
			
			updateAvailableDrums();
		}
		private var drums:Vector.<Drum>;
		
		private var actionDrumsTabActivated:Boolean;
		private var targetDrumsTabActivated:Boolean;
		private var detailDrumsTabActivated:Boolean;
		
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
			cm.addListener(actionDrumTab, MouseEvent.ROLL_OVER, onActionDrumTabTouched);
			cm.addListener(actionDrumTab, MouseEvent.MOUSE_DOWN, onActionDrumTabTouched);
			cm.addListener(targetDrumTab, MouseEvent.ROLL_OVER, onTargetDrumTabTouched);
			cm.addListener(targetDrumTab, MouseEvent.MOUSE_DOWN, onTargetDrumTabTouched);
			cm.addListener(detailDrumTab, MouseEvent.ROLL_OVER, onDetailDrumTabTouched);
			cm.addListener(detailDrumTab, MouseEvent.MOUSE_DOWN, onDetailDrumTabTouched);
			
			cm.addListener(actionDrumTab, MouseEvent.MOUSE_UP, onActionDrumTabReleased);
			cm.addListener(actionDrumTab, MouseEvent.RELEASE_OUTSIDE, onActionDrumTabReleased);
			cm.addListener(targetDrumTab, MouseEvent.MOUSE_UP, onTargetDrumTabReleased);
			cm.addListener(targetDrumTab, MouseEvent.RELEASE_OUTSIDE, onTargetDrumTabReleased);
			cm.addListener(detailDrumTab, MouseEvent.MOUSE_UP, onDetailDrumTabReleased);
			cm.addListener(detailDrumTab, MouseEvent.RELEASE_OUTSIDE, onDetailDrumTabReleased);
			
			generateDrums();
			
			super.onPrepare();
		}
		
		override protected function onShow(parent:DisplayObjectContainer, index:int):void {
			
			screen = Display.getVisibleBounds(parent);
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
			var i:int, n:int = drums.length;
			for(i = 0 ; i < n ; i++) 
				drums[i].init(this.drumHandler);
			
			startBeat();
			
			// Debug
			this.registerDebugAssets();
			
			super.onStart();
		}
		
		
		
		// DRUMS :
		private function generateDrums():void {
			Log.info(TAG, "Generating drums ...");
			this.drums = new Vector.<Drum>();
			this.drums.push(actionsDrumBox.moveForwardDrum);
			this.drums.push(actionsDrumBox.moveBackwardsDrum);
			this.drums.push(actionsDrumBox.liftLayDrum);
			this.drums.push(actionsDrumBox.attackDrum);
			this.drums.push(actionsDrumBox.defendDrum);
			
			this.drums.push(targetsDrumBox.itselfDrum);
			this.drums.push(targetsDrumBox.itemDrum);
			this.drums.push(targetsDrumBox.enemyDrum);
			
			this.drums.push(detailsDrumBox.bigDrum);
			this.drums.push(detailsDrumBox.smallDrum);
			this.drums.push(detailsDrumBox.fastDrum);
			
			Log.info(TAG, "Drums generation complete.");
		}
		
		
		// BEAT :
		private function startBeat():void {
			if(beatDisplayerTween != null)
				beatDisplayerTween.kill();
			beatDisplayer.alpha = 1;
			beatDisplayerTween = TweenMax.to(this.beatDisplayer, (BEAT_PERIOD/1000.0)/2.0, {delay:0.09 , alpha:0, repeat:-1, yoyo:true});	// -> the delay is the end of the first beat on the sound track.
			
			this.drumHandler.startTime = getTimer();
			new Sequence(this).playSound(new Beat2())
				.call(startBeat)
				.start();
		}
		
		
		
		
		
		
		
		
		
		// DISPLAY :
		private function updateAvailableDrums():void {
			
			this.actionDrumTab.alpha = this.targetDrumTab.alpha = this.detailDrumTab.alpha = 0.6;
			
			if(_currentDrumTab == Drum.ACTION) {
				this.setChildIndex(actionDrumTab, this.numChildren - 1);
				this.actionDrumTab.alpha = 1;
				TweenLite.fromTo(actionsDrumBox, DRUMS_APPEAR_ANIMATION_DURATION, {x:screen.x + screen.width}, {x:screen.x + screen.width - actionsDrumBox.width});
			}
			else if(_currentDrumTab == Drum.TARGET) {
				this.setChildIndex(targetDrumTab, this.numChildren - 1);
				this.targetDrumTab.alpha = 1;
				TweenLite.fromTo(targetsDrumBox, DRUMS_APPEAR_ANIMATION_DURATION, {x:screen.x + screen.width}, {x:screen.x + screen.width - targetsDrumBox.width});
			}
			else if(_currentDrumTab == Drum.DETAIL) {
				this.setChildIndex(detailDrumTab, this.numChildren - 1);
				this.detailDrumTab.alpha = 1;
				TweenLite.fromTo(detailsDrumBox, DRUMS_APPEAR_ANIMATION_DURATION, {x:screen.x + screen.width}, {x:screen.x + screen.width - detailsDrumBox.width});
			}
		}
		
		private function generateBeatDisplayer():void {
			this.beatDisplayer = new Sprite();
			
			beatDisplayer.graphics.beginFill(0xffffff, 1);
			beatDisplayer.graphics.drawRect(screen.x + BEAT_DISPLAYER_MARGIN, screen.y + BEAT_DISPLAYER_MARGIN, screen.width - (2*BEAT_DISPLAYER_MARGIN), BEAT_DISPLAYER_THICKNESS);
			beatDisplayer.graphics.drawRect(screen.x + BEAT_DISPLAYER_MARGIN, screen.y + BEAT_DISPLAYER_MARGIN + BEAT_DISPLAYER_THICKNESS, BEAT_DISPLAYER_THICKNESS, screen.height - (2 * (BEAT_DISPLAYER_MARGIN + BEAT_DISPLAYER_THICKNESS)));
			beatDisplayer.graphics.drawRect(screen.x + screen.width - BEAT_DISPLAYER_MARGIN - BEAT_DISPLAYER_THICKNESS, screen.y + BEAT_DISPLAYER_MARGIN + BEAT_DISPLAYER_THICKNESS, BEAT_DISPLAYER_THICKNESS, screen.height - (2 * (BEAT_DISPLAYER_MARGIN + BEAT_DISPLAYER_THICKNESS)));
			beatDisplayer.graphics.drawRect(screen.x + BEAT_DISPLAYER_MARGIN, screen.y + screen.height - BEAT_DISPLAYER_MARGIN - BEAT_DISPLAYER_THICKNESS, screen.width - (2*BEAT_DISPLAYER_MARGIN), BEAT_DISPLAYER_THICKNESS);
			beatDisplayer.graphics.endFill();
		}
		
		
		
		
		
		
		// CALLBAKCS :
		private function onActionDrumTabTouched(event:MouseEvent):void {
			if(!event.buttonDown)
				return;
			currentDrumTab = Drum.ACTION;
			actionDrumsTabActivated = true;
			targetDrumsTabActivated = detailDrumsTabActivated = false;
		}
		
		private function onTargetDrumTabTouched(event:MouseEvent):void {
			if(!event.buttonDown)
				return;
			currentDrumTab = Drum.TARGET;
			targetDrumsTabActivated = true;
			actionDrumsTabActivated = detailDrumsTabActivated = false;
		}
		
		private function onDetailDrumTabTouched(event:MouseEvent):void {
			if(!event.buttonDown)
				return;
			currentDrumTab = Drum.DETAIL;
			detailDrumsTabActivated = true;
			actionDrumsTabActivated = targetDrumsTabActivated = false;
		}
		
		private function onActionDrumTabReleased(event:MouseEvent):void {
			actionDrumsTabActivated = false;
			checkTabsActivation();
		}
		
		private function onTargetDrumTabReleased(event:MouseEvent):void {
			targetDrumsTabActivated = false;
			checkTabsActivation();
		}
		
		private function onDetailDrumTabReleased(event:MouseEvent):void {
			detailDrumsTabActivated = false;
			checkTabsActivation();
		}
		
		private function checkTabsActivation():void {
			if(!actionDrumsTabActivated && !targetDrumsTabActivated && !detailDrumsTabActivated)
				currentDrumTab = null;
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