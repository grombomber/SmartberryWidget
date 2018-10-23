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
	hidden var tView;
	
    function initialize() {
        Menu2InputDelegate.initialize();
      

    }

    function onSelect(item) {
    	System.println(item.getId());
    	var i = item.getId();
    	
    	if (i < devices.size() - 1) {
	    	// run command
	    	var url = serverUrl + commandPath + devices[i+1] + commandSwitch + devices[i+2];
	    	makeRequest(url);
	    	WatchUi.popView(WatchUi.SLIDE_RIGHT);
	    } else {
  	       // On va afficher les temp
  	        tView = new TempSmartberryWidgetView();
            WatchUi.pushView(tView, new TempSmartberryDelegate(), WatchUi.SLIDE_LEFT );
  	
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
       // 	var receivedData = data.get("result");
       // 	var nbValeurs = receivedData.size();
       // 	var chaineComplete = "\n";
        	//System.println(receivedData);
        	//System.println(nbValeurs);
            // Bureau, Cave, Garage, Salon, Piscine (Sonde Temp. Piscine)
       //     while (nbValeurs > 0) { 
       //     	chaineComplete = chaineComplete + receivedData[nbValeurs-1]["Name"] + ": " + receivedData[nbValeurs-1]["Temp"].format("%.1f") +" C\n";
		//        nbValeurs--;
        //    }
            System.println("OK");
        } else {
            System.println("KO\nError: " + responseCode.toString());
        }
    }
}
