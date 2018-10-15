//
// Copyright 2018 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Application.Properties as Properties;

var auth;
var serverUrl;
var commandPath = "/json.htm?type=command&param=switchlight&idx=";
var commandPath2 = "/json.htm?type=devices&filter=temp&used=true&order=name";
var commandSwitch = "&switchcmd=";
var devices;
	
// This is delegate for the main page of our application that pushes the menu
// when the onMenu() behavior is received.
class SmartberryWidgetDelegate extends WatchUi.BehaviorDelegate {
	
    function initialize() {
    
        System.println("Starting delegate ...");
        
        BehaviorDelegate.initialize();
        
        auth = Properties.getValue("auth");
        System.println("INFO : " + auth);
        serverUrl = Properties.getValue("serverUrl");
        System.println("INFO : " + serverUrl);
		devices = split(Properties.getValue("devices"), ";");
        System.println("INFO : " + devices);

/*        
        for (var i=0; i < devices.size() ; i+=3) {
        	System.println("INFO : " + devices[i] + serverUrl + commandPath + devices[i+1] + commandSwitch + devices[i+2] );
        }
        */
        
    }

    function onMenu() {
        // Generate a new Menu with a drawable Title
		// WatchUi.pushView(new Rez.Menus.MainMenu(), new MenuSmartberryDelegate(), WatchUi.SLIDE_IMMEDIATE );
		var menu = new WatchUi.Menu2({:title=>"Domoticz"});
        
        for (var i=0; i < devices.size() ; i+=3) {
        	menu.addItem(new WatchUi.MenuItem(devices[i], null, i, null));
        }
        
        //We add an entry to the menu to get Temp sensors values
        menu.addItem(new WatchUi.MenuItem("Temp.", null, devices.size() , null));
        
        // Test Toggle
        //menu.addItem(new WatchUi.ToggleMenuItem("Toggle", {:enabled=>"ON: on", :disabled=>"OFF: off"}, "left", false, {:alignment=>WatchUi.MenuItem.MENU_ITEM_LABEL_ALIGN_LEFT}));
        WatchUi.pushView(menu, new MenuSmartberryDelegate(), WatchUi.SLIDE_LEFT );
        
        return true;
    }
    
    function onBack() {
    	System.println("Delegate onBack");
    	// Plante si on pop la dernière vue ...
    	//WatchUi.popView(SLIDE_RIGHT);
    	//Application.AppBase.exit();
        return true;
    }
      
    function split(s, sep) {
	    var tokens = [];
	
	    var found = s.find(sep);

	    while (found != null) {
	        tokens.add(s.substring(0, found));
	
	        s = s.substring(found + sep.length(), s.length());
	
	        found = s.find(sep);
	    }
	
	    tokens.add(s);
	
	    return tokens;
	}
    
}

