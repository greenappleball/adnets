(function () {
    var mraid = window.mraid = {};
    
    // constant definitions
    var STATES = mraid.STATES = {
        LOADING : "loading",
        DEFAULT : "default",
        EXPANDED : "expanded",
        HIDDEN : "hidden"
    };
    
    var EVENTS = mraid.EVENTS = {
        ERROR : "error",
        READY : "ready",
        STATECHANGE : "stateChange",
        VIEWABLECHANGE : "viewableChange",
    };
    
    
     
 	/** The set of listeners for Events */
 	var listeners = { };
 	
 	/** holds the ads current viewable state controlled by the SDK **/
 	var viewable = true;
 	
 	/** holds the current placement type controlled by the SDK **/
 	var placementType = 'inline';
 
    // local variables for the current state of things
    var expandable_props = mraid.expandable_props = {
        width:300,
        height:50,
        useCustomClose:false,
        isModal:true,
    };
    
    var state = STATES.LOADING;
    
    var expandPropertyValidators = {
        useCustomClose:function(value) { return (value === true || value === false); },
        width:function(value) { return !isNaN(value) && value >= 0},
        height:function(value) { return !isNaN(value) && value >= 0}
    };

    // MRAID 1.0 methods.
    
    // expand properties
    mraid.getExpandProperties = function () {
        return expandable_props;
    };
    
    mraid.setExpandProperties = function (properties){
    	if (properties['isModal'] != undefined) {
       		mraid.fireErrorEvent('tried to set isModal property. This is read only.','setExpandProperties');
    	}
        if (valid(properties, expandPropertyValidators, 'setExpandProperties')) {
            for (var i in properties) {
            	mraid.log('changing expand property '+i+' from '+expandable_props[i]+' to '+properties[i],'setExpandProperties');
                expandable_props[i] = properties[i];
            }       
        }
    };
    
    mraid.useCustomClose = function (value) {
		if (value === true || value === false) {
            mraid.log('changing expand property useCustomClose from '+expandable_props.useCustomClose+' to '+value,'useCustomClose');
        	expandable_props.useCustomClose = value;
        }
        else {
       		mraid.fireErrorEvent('useCustomClose called with invalid value: '+custom,'useCustomClose');
        }
    };

    // getters
    mraid.getState = function () {
        return state;
    };
    
    mraid.getVersion = function () {
        return "1.0";
    };
    
    mraid.isViewable = function () {
        return viewable;
    };
    
    mraid.getPlacementType = function () {
        return placementType;
    }
    
    // event listeners

 	mraid.addEventListener = function( event, listener ) {
   		var handlers = listeners[event];
		if ( handlers == null ) {
        	// no handlers defined yet, set it up
        	listeners[event] = [];
        	handlers = listeners[event];
    	}
 
    	// see if the listener is already present
    	for ( var handler in handlers ) {
       		if ( listener == handler ) {
            	// listener already present, nothing to do
            	return;
        	}
    	}
 
        mraid.log('added new '+event+' listener','addEventListener');
    	// not present yet, go ahead and add it
    	handlers.push( listener );
 	};
 
	mraid.removeEventListener = function( event, listener ) {
    	var handlers = listeners[event];
    	if ( handlers != null ) {
    		// if listener is null, all listeners are removed.
    		if (listener == null) {
    		    mraid.log('removing all listeners for event '+event,'removeEventListener');
    			listeners[event]=null;
    		}
    		else {
				var i = handlers.indexOf(listener);
				if(i != -1) 
				{
    		    	mraid.log('removing listener for '+event,'removeEventListener');
					handlers.splice(i, 1);    
				}
				else
				{
    		    	mraid.fireErrorEvent('attempted to remove listener for '+event+' but did not find it registered.','removeEventListener');
				}
			}
		}
	};
 
    // window management
    mraid.close = function () {
		if (state == STATES.EXPANDED) {
    		mraid.log('executing bridge CLOSE','close');
			// expanded ads will return to normal size.
			psm_mraid_bridge.close();

		}
		else if (state == STATES.DEFAULT) {
    		mraid.log('executing bridge HIDE','close');
			// default ads change to hidden.
			psm_mraid_bridge.hide();
		}
		else if (state == STATES.LOADING || 
				state == STATES.HIDDEN) {
			mraid.fireErrorEvent('close failed because current state prevents closing.','close');
		}
    };
    
    mraid.expand = function (url) {
    	if (placementType != 'inline') {
			mraid.fireErrorEvent('expand not allowed because placement type is not inline.','expand');
    		return;
    	}
		if (state == STATES.DEFAULT) {
    		mraid.log('executing bridge EXPAND','expand');
			// default ads change to hidden.
			psm_mraid_bridge.expand(url, mraid.expandable_props);
		}
		else if (state == STATES.LOADING || 
				state == STATES.HIDDEN ||
				state == STATES.EXPANDED)
		{
			mraid.fireErrorEvent('expand failed because current state prevents expanding.','expand');
		}	
    };
    
    mraid.open = function (url) {
        if (!url) {
            mraid.fireErrorEvent( 'URL is required.', 'open');
        }
        else {
    		mraid.log('opening '+url,'open');
 
            //For iOS, this technique is required for the "click" to make it out of the UIWebView into Safari
            var a = document.createElement('a');
            a.setAttribute("href", url);
            a.setAttribute("target", "_blank");

            var dispatch = document.createEvent("HTMLEvents");
            dispatch.initEvent("click", true, false);
            a.dispatchEvent(dispatch);

		}
    };
 
    
    //
    // private helper methods.
	//
	
	var valid = function(obj, validators, action, full) {
        if (full) {
            if (obj === undefined) {
                mraid.fireErrorEvent('Required object missing.', action);
                return false;
            } else {
                for (var i in validators) {
                    if (obj[i] === undefined) {
                        mraid.fireErrorEvent('Object missing required property ' + i, action);
                        return false;
                    }
                }
            }
        }
        for (var i in obj) {
            if (!validators[i]) {
                mraid.fireErrorEvent('Invalid property specified - ' + i + '.', action);
                return false;
            } else if (!validators[i](obj[i])) {
                mraid.fireErrorEvent('Value of property ' + i + ' is not valid type.', action);
                return false;
            }
        }
        return true;
    };

	mraid.setViewable = function (shown)
	{
		if (shown != viewable)
		{
			// there is a change in the viewable state.
			viewable = shown;
			mraid.fireViewableChangeEvent();
		} else {
	    	mraid.log('setViewable called with no change to view state','setViewable');
		}
	};

	mraid.setState = function(newState) {
		if (state == STATES.LOADING &&
			newState == STATES.DEFAULT)
		{
			mraid.fireReadyEvent();
		}
 		state = newState;
		mraid.fireStateChangeEvent();
	};

	mraid.setPlacementType = function(newPlacement) {
    	mraid.log('changing placement type to:'+newPlacement,'setPlacementType');
		placementType=newPlacement;
	};

	mraid.fireReadyEvent = function() {
		var handlers = listeners["ready"];
		if ( handlers != null ) {
			for ( var i = 0; i < handlers.length; i++ ) {
	    		mraid.log('executing ready event handler','fireReadyEvent');
				handlers[i]();
			}
		}
	
		return "OK";
	};
	
	mraid.fireErrorEvent = function( message, action ) {
		var handlers = listeners["error"];
		if ( handlers != null ) {
			for ( var i = 0; i < handlers.length; i++ ) {
	    		mraid.log('executing error event handler','fireErrorEvent');
				handlers[i]( message, action );
			}
		}
	
		return "OK";
	};
	
	// triggers the viewableChange event with the current viewable value
	mraid.fireViewableChangeEvent = function() {
		var handlers = listeners["viewableChange"];
		if ( handlers != null ) {
			for ( var i = 0; i < handlers.length; i++ ) {
	    		mraid.log('executing viewChange event handler','fireViewChangeEvent');
				handlers[i]( viewable );
			}
		}
	
		return "OK";
	};
	
	// triggers the stateChange event with the current state value.
	mraid.fireStateChangeEvent = function() {
		var handlers = listeners["stateChange"];
		if ( handlers != null ) {
			for ( var i = 0; i < handlers.length; i++ ) {
	    		mraid.log('executing stateChange event handler','fireStateChangeEvent');
				handlers[i]( state );
			}
		}
	
		return "OK";
	};

	mraid.log = function(logtext,method) {
        psm_mraid_bridge.log('DEBUG','MRAID.log:'+logtext,method);	
	}

	// initialization		
	// add an event listener to the error event so we can log errors
	// to the device console.
	mraid.addEventListener('error', function(error, method) {
        psm_mraid_bridge.error('DEBUG',error,method);
    });

	mraid.addEventListener('stateChange', function(state) {
        psm_mraid_bridge.log('DEBUG','State changed to '+state,'State change');
    });
    
    mraid.addEventListener('viewableChange', function(viewable) {
        psm_mraid_bridge.log('DEBUG','Viewable changed to '+viewable,'Viewable change');
    });
    
    psm_mraid_bridge.log('DEBUG','initialized', 'init');
    
})();