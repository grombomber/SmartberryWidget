//
// Copyright 2018 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Communications;
using Toybox.Application.Properties as Properties;

// This is the menu input delegate for the main menu of the application
class MenuSmartberryDelegate extends WatchUi.Menu2InputDelegate {
	var tView;
	
    function initialize() {
        Menu2InputDelegate.initialize();
      

    }

    function onSelect(item) {
    	System.println(item.getId());
    	var i = item.getId();
    	// Si switch alors on passe la commande correspondant à la position du toggle bouton, si temp alors on affiche les temp
    	if (i < devices.size() - 1) {
			if (devices[i+2].equals("switch")) {
	    		// run command
	    		var commandValue="";
	    		if (item.isEnabled()) {
	    			commandValue="On";
	    		} else {
	    			commandValue="Off";
	    		}
	    		var url = serverUrl + commandPath + devices[i+1] + commandSwitch + commandValue;
	    		makeRequest(url);
	    		//WatchUi.popView(WatchUi.SLIDE_RIGHT);
	    	} else {
	    	}
	    } else {
  	       // On va afficher les temp
  	        tView = new TempSmartberryWidgetView();
            WatchUi.pushView(tView, new TempSmartberryDelegate(tView.method(:onReceive)), WatchUi.SLIDE_LEFT );
  	
	    }
	    
    	
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
    
    
    
    function makeRequest(url) {
		var headers = {
         "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON ,
         "Authorization" => "Basic " + auth
        };
        var options = {
          :method => Communications.HTTP_REQUEST_METHOD_GET,
          :headers => headers,
          :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };
        
        Communications.makeWebRequest(
            url,
			{},
			options,
            method(:onReceive)
        );
    }

    // Receive the data from the web request
    function onReceive(responseCode, data) {
    	
       if (responseCode == 200) {
            //System.println("OK");
        } else {
            //System.println("KO\nError: " + responseCode.toString());
        }
    }
}
