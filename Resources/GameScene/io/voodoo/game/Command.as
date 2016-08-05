package io.voodoo.game {
	import com.deboutludo.alert.Alert;
	import com.deboutludo.core.CruftManager;
	import com.deboutludo.core.MovieClipModule;
	import com.deboutludo.core.Sequence;
	import com.deboutludo.events.AppEvent;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	
	import io.voodoo.game.drums.ActionDrum;
	import io.voodoo.game.drums.Drum;
	import io.voodoo.game.drums.TargetDrum;
	import io.voodoo.game.sounds.FailSound;
	
	/**
	 *
	 */
	public class Command {
		private static const TAG:String = "Command";
		
		// EVENTS :
		public static const MOVE_FORWARD_EVENT:String = "MoveForward";
		public static const MOVE_BACKWARDS_EVENT:String = "MoveBackwards";
		public static const ATTACK_EVENT:String = "Attack"; 
		
		// REGISTERED COMMANDS :
		private static const moveItselfForward:Vector.<String> = new <String>[ActionDrum.MOVE_FORWARD, TargetDrum.ITSELF];
		private static const moveItselfBackwards:Vector.<String> = new <String>[ActionDrum.MOVE_BAKCWARDS, TargetDrum.ITSELF];
		private static const moveItemForward:Vector.<String> = new <String>[ActionDrum.MOVE_FORWARD, TargetDrum.ITEM];
		private static const moveItemBackwards:Vector.<String> = new <String>[ActionDrum.MOVE_BAKCWARDS, TargetDrum.ITEM];
		
		private static const liftItself:Vector.<String> = new <String>[ActionDrum.LIFT, TargetDrum.ITSELF];
		private static const liftItem:Vector.<String> = new <String>[ActionDrum.LIFT, TargetDrum.ITEM];
		private static const liftEnemy:Vector.<String> = new <String>[ActionDrum.LIFT, TargetDrum.ENEMY];
		
		private static const attackEnemy:Vector.<String> = new <String>[ActionDrum.ATTACK, TargetDrum.ENEMY];
		private static const attackItself:Vector.<String> = new <String>[ActionDrum.ATTACK, TargetDrum.ITSELF];
		private static const attackItem:Vector.<String> = new <String>[ActionDrum.ATTACK, TargetDrum.ITEM];
		
		private static const defendItself:Vector.<String> = new <String>[ActionDrum.DEFEND, TargetDrum.ITSELF];
	
		
		// PROPERTIES :
		private var commandDrums:Vector.<Drum>;
		private var soundCM:CruftManager;
		
		// CONSTRUCTOR :
		public function Command() {
			this.commandDrums = new Vector.<Drum>();
			this.soundCM = new CruftManager();
		}
		
		
		public function addDrum(drum:Drum):void {
			Log.info(TAG, "Adding drum " + drum.subType + " to the current command. (" + commandDrums + ")");
			this.commandDrums.push(drum);
		}
		
		public function checkCommand():void {
			if(commandDrums.length < 2) {
				Log.info(TAG, "The current command is too small. ");
				return;
			}
			
			// TODO more intelligent sort
			if(checkCommandValidity(moveItselfForward)) {
				Log.info(TAG, "Performing a move foward command.");
				AppEvent.dispatch(new Event(MOVE_FORWARD_EVENT));
				replayCommand();
				resetCommand();
			}
			else if(checkCommandValidity(moveItselfBackwards)) {
				Log.info(TAG, "Performiung a move backwards command.");
				AppEvent.dispatch(new Event(MOVE_BACKWARDS_EVENT));
				replayCommand();
				resetCommand();
			}
			else if(checkCommandValidity(attackEnemy)) {
				Log.info(TAG, "Performing an attack command.");
				AppEvent.dispatch(new Event(ATTACK_EVENT));
				replayCommand();
				showMissingCommand("Attack enemy !");
			}
			else if(checkCommandValidity(moveItemForward)) 
				showMissingCommand("Move item forward !");
			else if(checkCommandValidity(moveItemBackwards)) 
				showMissingCommand("Move item backwards !");
			else if(checkCommandValidity(liftItself))
				showMissingCommand("Lift ourselves !");
			else if(checkCommandValidity(liftItem))
				showMissingCommand("Lift nearest item !");
			else if(checkCommandValidity(liftEnemy))
				showMissingCommand("Lift enemy !");
			else if(checkCommandValidity(attackItself))
				showMissingCommand("Attack ourselves !");
			else if(checkCommandValidity(attackItem))
				showMissingCommand("Attack nearest item !");
			else if(checkCommandValidity(defendItself))
				showMissingCommand("Defend ourselves !");
			
			else {
				Log.info(TAG, "Invlaid or unregistered command.");
				soundCM.playSound(new FailSound());
				resetCommand();
			}
		}
		
		private function checkCommandValidity(registeredCommand:Vector.<String>):Boolean {
			var firstDrumIndex:int = registeredCommand.indexOf(commandDrums[0].subType);
			var secondDrumIndex:int = registeredCommand.indexOf(commandDrums[1].subType);
			return commandDrums.length == 2 && firstDrumIndex >= 0 && secondDrumIndex >= 0 && firstDrumIndex != secondDrumIndex;
		}
		
		private function replayCommand():void {
			// TODO play a sound while performing the action
		}
		
		private function showMissingCommand(commandMessage:String):void {
			var alert:Alert = Alert.show(commandMessage, new <String>[]);
			TweenLite.delayedCall(1, alert.hide);
			resetCommand();
		}
		
		public function resetCommand():void {
			this.commandDrums = new Vector.<Drum>();
		}
	}
}