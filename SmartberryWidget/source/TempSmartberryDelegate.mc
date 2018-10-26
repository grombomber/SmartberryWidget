//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.System;

class TempSmartberryDelegate extends Ui.BehaviorDelegate {
    var notify;
    // Handle menu button press
    function onMenu() {
    }

    function onSelect() {
    }

    function makeRequest(url) {
    	//notify.invoke("Recuperation infos");
    
        // We want to get temperatures
        var headers = {
         "Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON ,
         "Authorization" => "Basic " + auth
        };
        
	      var options = {
          :method => Comm.HTTP_REQUEST_METHOD_GET,
          :headers => headers,
          :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };
 			Comm.makeWebRequest(
            url, //url
            {},
           	options,
           	method(:onReceive)
        );
    }

    // Set up the callback to the view
    function initialize(handler) {
        BehaviorDelegate.initialize();
        notify = handler;
	    var url = serverUrl + commandPath2;
	    //System.println(url);
        makeRequest(url); //added to run just after initialization
    }

    // Receive the data from the web request
    function onReceive(responseCode, data) {
    
    	    	    	
       if (responseCode == 200) {

        	var receivedData = data.get("result");
        	var nbValeurs = receivedData.size();
        	var chaineComplete = "\n";
            // Bureau, Cave, Garage, Salon, Piscine (Sonde Temp. Piscine)
            while (nbValeurs > 0) { 
            	chaineComplete = chaineComplete + receivedData[nbValeurs-1]["Name"] + ": " + receivedData[nbValeurs-1]["Temp"].format("%.1f") +" C\n";
		        nbValeurs--;
            }
            //System.println(chaineComplete);
            notify.invoke(chaineComplete);
        } else {
            //notify.invoke("Failed to load\nError: " + responseCode.toString());
            //System.println(responseCode.toString());
        }
    }
}