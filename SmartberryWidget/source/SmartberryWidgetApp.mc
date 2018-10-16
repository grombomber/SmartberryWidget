using Toybox.Application;

class SmartberryWidgetApp extends Application.AppBase {
	hidden var mView;
	
    function initialize() {
        AppBase.initialize();
        System.println("Starting widget ...");
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	mView = new SmartberryWidgetView();	
    	return [ mView, new SmartberryWidgetDelegate() ];
    }

}