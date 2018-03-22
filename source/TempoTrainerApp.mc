using Toybox.Application as App;

class TempoTrainerApp extends App.AppBase {

	hidden var _appVersion;

    function initialize() {
        AppBase.initialize();
        if(Toybox.Application has :Storage){
        	_appVersion = App.Properties.getValue("appVersion");
        } else {
        	_appVersion = App.getApp().getProperty("appVersion");
        }
        System.println(_appVersion);
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

	function onSettingsChanged() {
		if(Toybox.Application has :Storage){
			
		}
		else{
		
		}
	}

    function getInitialView() {
        return [ new TempoTrainerView() ];
    }

}