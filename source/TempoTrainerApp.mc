using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Lang;

class TempoTrainerApp extends App.AppBase {

	hidden var _appVersion;
	hidden var _a;

    function initialize() {
        AppBase.initialize();
        try{
        	if(App has :Properties){
        		_appVersion = App.Properties.getValue("appVersion");
        	} else {
        		_appVersion = Application.getApp().getProperty("appVersion");
        	}
        } catch (e instanceof Lang.Exception) {
        
        }
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
    	_a = new TempoTrainerView();
        return [ _a ];
    }

	function onSettingsChanged() {
        _a.updateSettings();
    }

}