(function () {
    var psm_mraid_bridge = window.psm_mraid_bridge = {};

    /** Identifies if a native call is currently in progress */
    var nativeCallInFlight = true;
	/** A Queue of Calls to the Native SDK that still need execution */
	var nativeCallQueue = [ ];

	var logLevel = 'DEBUG';
	var platform = 'none';
    
   	psm_mraid_bridge.setLogLevel = function(level) {
		logLevel=level;
	};

   	psm_mraid_bridge.setPlatform = function(value) {
		platform=value;
	};


	// there is a method for each command. The implementation of that command can differ
    
    psm_mraid_bridge.close = function () {
		psm_mraid_bridge.executeNativeCall('CLOSE');
    };

    psm_mraid_bridge.hide = function () {
		psm_mraid_bridge.executeNativeCall('HIDE');
    };
    
    psm_mraid_bridge.open = function () {
        psm_mraid_bridge.executeNativeCall('OPEN');
    };

    psm_mraid_bridge.expand = function (url, properties) {
		psm_mraid_bridge.executeNativeCall('EXPAND','url',url, 'width',properties.width, 'height',properties.height, 'useCustom',properties.useCustomClose);
    };
 
	psm_mraid_bridge.log = function (logLevel, log, method) {
        if(logLevel != 'NONE') {
			psm_mraid_bridge.executeNativeCall('LOG','method',method,'error',log);
		}
	};
	
	psm_mraid_bridge.error = function (level,error, method) {
        if(logLevel != 'NONE') {
			psm_mraid_bridge.executeNativeCall('LOG','method',method,'error',error);
		}
	};  

    
    /**
	  * nativeCallComplete notifies the abstraction layer that a native call has
	  * been completed..
	  *
	  * NOTE: This function is called by the native code and is not intended to be
	  *       used by anything else.
	  *
	  * @returns string, "OK"
	  */
	 psm_mraid_bridge.nativeCallComplete = function( cmd ) {
	 
		// anything left to do?
		if ( nativeCallQueue.length == 0 ) {
			nativeCallInFlight = false;
			return;
		}
	 
		// still have something to do
		var bridgeCall = nativeCallQueue.shift();
		psm_mraid_bridge.execBridgeCall(bridgeCall);
	 
		return "OK";
	 };
	 
	 /**
	  *
	  */
	 psm_mraid_bridge.executeNativeCall = function( command ) {
		// build command
		var bridgeCall = "psm://" + command;
		var value;
		var firstArg = true;
		for ( var i = 1; i < arguments.length; i += 2 ) {
			value = arguments[i + 1];
			if ( value == null ) {
				// no value, ignore the property
				continue;
			}
	 
			// add the correct separator to the name/value pairs
			if ( firstArg ) {
				bridgeCall += "?";
				firstArg = false;
			}
			else {
				bridgeCall += "&";
			}
			bridgeCall += arguments[i] + "=" + escape( value );
		}
	 
		// add call to queue
		if ( nativeCallInFlight ) {
			// call pending, queue up request
			nativeCallQueue.push( bridgeCall );
		}
		else {
			// no call currently in process, execute it directly
			nativeCallInFlight = true;
			psm_mraid_bridge.execBridgeCall(bridgeCall);
		}
	 };
	 
	 psm_mraid_bridge.execBridgeCall = function(url) {
        if (platform == "android")
        {
            psm_mraid_bridge.execUnWrapped(url);
            return;
        }
        psm_mraid_bridge.execWrapped(url);
	 };
	 
	 psm_mraid_bridge.execWrapped = function(url) {
	 	var iframe = document.createElement("IFRAME");
		iframe.setAttribute("src", url);
		document.documentElement.appendChild(iframe);
		iframe.parentNode.removeChild(iframe);
		iframe = null;
	 }

	 psm_mraid_bridge.execUnWrapped = function(url) {
	 	window.location=url;
	 }
	 
	 psm_mraid_bridge.log('DEBUG','initialized', 'bridge init');
})();