package org.assetloader.signals
{
	import org.assetloader.core.ILoader;
	import org.osflash.signals.Signal;

	/**
	 * @author Matan Uberstein
	 */
	public class LoaderSignal extends Signal
	{
		/**
		 * @private
		 */
		protected var _loader : ILoader;

		/**
		 * @private
		 */
		protected var _signalType : Class;

		public function LoaderSignal(...valueClasses)
		{
			super();
			
			//trace("Loader signal constructor" );
			
			_signalType ||= LoaderSignal;

			//trace("Loader signal weird thing" );
			
			if(valueClasses.length == 1 && valueClasses[0] is Array)
				valueClasses = valueClasses[0];

			//trace("Loader signal 2" );
		
			//this.valueClasses = [_signalType].concat.apply(null, valueClasses);
			this.valueClasses = [_signalType].concat(valueClasses);
			
			//trace("Loader signal 3", this.valueClasses );
		}

		/**
		 * First argument must be the loader to which this signal belongs.
		 */
		override public function dispatch(...args) : void
		{
			_loader = args.shift();
			
			//trace( "before apply" );
			
			//super.dispatch.apply(null, [this].concat.apply(null, args));
			super.dispatch.apply(null, [this].concat( args ) );
			
			//trace( "after apply" );
		}

		/**
		 * Gets the loader that dispatched this signal.
		 * 
		 * @return ILoader
		 */
		public function get loader() : ILoader
		{
			return _loader;
		}
	}
}
