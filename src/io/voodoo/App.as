package io.voodoo {
	import com.deboutludo.core.ModuleNavigator;
	
	
	/**
	 *
	 */
	public class App extends ModuleNavigator {
		
		// STATIC INSTANCE :
		private static var _instance:App;
		/** A reference to the static App instance, the "main" ModuleNavigator. 
		 * @see ModuleNavigator*/
		public static function get instance():App { return _instance; }
		
		// CONSTRUCTOR :
		public function App() {
			super();
			_instance = this;
		}
	}
}