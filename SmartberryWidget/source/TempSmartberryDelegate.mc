//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;

class TempSmartberryDelegate extends Ui.BehaviorDelegate {
    var notify;
    // Handle menu button press
    function onMenu() {
	    var url = serverUrl + commandPath2;
	    System.println("Target url " + url);
        makeRequest(url);
        return true;
    }

    function onSelect() {
	    var url = serverUrl + commandPath2;
	    System.println("Target url " + url);
        makeRequest(url);
        return true;
    }

    function makeRequest(url) {
    
        notify.invoke("Gathering data");
        // We want to get temperatures
	            
		
		
			Comm.makeWebRequest(
            url, //url
            {
            },
            {                                             // set the options
           :method => Comm.HTTP_REQUEST_METHOD_GET,      // set HTTP method
                                                                   // set response type
           :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
       },
           method(:onReceive)
        );
    }

    // Set up the callback to the view
    function initialize(handler) {
        Ui.BehaviorDelegate.initialize();
        notify = handler;
	    var url = serverUrl + commandPath2;
	    System.println("Target url " + url);
        makeRequest(url); //added to run just after initialization
    }

    // Receive the data from the web request
    function onReceive(responseCode, data) {
    	//System.println(data);
    	//System.println(results);
    	
        if (responseCode == 200) {
       
        	var receivedData = data.get("result");
        	var nbValeurs = receivedData.size();
        	var chaineComplete = "\n";
        	//System.println(receivedData);
        	//System.println(nbValeurs);
            // Bureau, Cave, Garage, Salon, Piscine (Sonde Temp. Piscine)
            while (nbValeurs > 0) { 
            	chaineComplete = chaineComplete + receivedData[nbValeurs-1]["Name"] + ": " + receivedData[nbValeurs-1]["Temp"].format("%.1f") +" C\n";
		        nbValeurs--;
            }
            notify.invoke(chaineComplete);
        } else {
            notify.invoke("Failed to load\nError: " + responseCode.toString());
        }
    }
}