package io.voodoo.game {
	import com.deboutludo.core.CruftManager;
	import com.deboutludo.core.MovieClipModule;
	import com.deboutludo.core.Sequence;
	import com.deboutludo.events.AppEvent;
	
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
		// TODO
		private static const moveItselfForward:Vector.<String> = new <String>[ActionDrum.MOVE_FORWARD, TargetDrum.ITSELF];
		private static const moveItselfBackwards:Vector.<String> = new <String>[ActionDrum.MOVE_BAKCWARDS, TargetDrum.ITSELF];
		private static const attackEnemy:Vector.<String> = new <String>[ActionDrum.ATTACK, TargetDrum.ENEMY];
		
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
			if(commandDrums[0].subType == moveItselfForward[0] && commandDrums[1].subType == moveItselfForward[1]) {
				Log.info(TAG, "Performing a move foward command.");
				AppEvent.dispatch(new Event(MOVE_FORWARD_EVENT));
				replayCommand();
				resetCommand();
			}
			else if(commandDrums[0].subType == moveItselfBackwards[0] && commandDrums[1].subType == moveItselfBackwards[1]) {
				Log.info(TAG, "Performiung a move backwards command.");
				AppEvent.dispatch(new Event(MOVE_BACKWARDS_EVENT));
				replayCommand();
				resetCommand();
			}
			else if(commandDrums[0].subType == attackEnemy[0] && commandDrums[1].subType == attackEnemy[1]) {
				Log.info(TAG, "Performing an attack command.");
				AppEvent.dispatch(new Event(ATTACK_EVENT));
				replayCommand();
				resetCommand();
			}
			else {
				Log.info(TAG, "Invlaid or unregistered command.");
				soundCM.playSound(new FailSound());
				resetCommand();
			}
		}
		
		private function replayCommand():void {
			// TODO play a sound while performing the action
		}
		
		public function resetCommand():void {
			this.commandDrums = new Vector.<Drum>();
		}
	}
}