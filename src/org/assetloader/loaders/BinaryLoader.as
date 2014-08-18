package org.assetloader.loaders
{
	import flash.net.URLLoader;
	import org.assetloader.base.AssetType;
	import org.assetloader.signals.LoaderSignal;

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.net.URLLoaderDataFormat;

	/**
	 * @author Matan Uberstein
	 */
	public class BinaryLoader extends BaseLoader
	{
		/**
		 * @private
		 */
		protected var _bytes : ByteArray;

		/**
		 * @private
		 */
		protected var _loader : URLLoader;

		public function BinaryLoader(request : URLRequest, id : String = null)
		{
			super(request, AssetType.BINARY, id);
		}

		override public function start() : void
		{
			super.start();
		}
		
		/**
		 * @private
		 */
		override protected function initSignals() : void
		{
			super.initSignals();
			_onComplete = new LoaderSignal(ByteArray);
		}

		/**
		 * @private
		 */
		override protected function constructLoader() : IEventDispatcher
		{
			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			return _loader;
		}

		/**
		 * @private
		 */
		override protected function invokeLoading() : void
		{
			_loader.load(request);
		}

		/**
		 * @inheritDoc
		 */
		override public function stop() : void
		{
			if(_invoked)
			{
				try
				{
					_loader.close();
				}
				catch(error : Error)
				{
				}
			}

			super.stop();
		}

		/**
		 * @inheritDoc
		 */
		override public function destroy() : void
		{
			ByteArray(_data).clear();
			super.destroy();
			ByteArray(_loader.data).clear();
			_loader.data = null;
			_loader = null;
			_data = null;
			_bytes.clear();
			_bytes = null;
		}

		/**
		 * @private
		 */
		override protected function complete_handler(event : Event) : void
		{
			trace ("BinaryLoader complete handler" );
			//_bytes = new ByteArray();
			//_loader.readBytes(_bytes);
			_bytes = _loader.data;
			_data = _loader.data; //_bytes;

			super.complete_handler(event);
		}

		/**
		 * Gets the resulting ByteArray after loading is complete.
		 * 
		 * @return ByteArray 
		 */
		public function get bytes() : ByteArray
		{
			return _bytes;
		}
	}
}
