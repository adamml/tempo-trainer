using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class TempoTrainerApp extends App.AppBase {

	hidden var _appVersion;

    function initialize() {
        AppBase.initialize();
        if(App has :Properties){
        	_appVersion = App.Properties.getValue("appVersion");
        } else {
        	_appVersion = Application.getApp().getProperty("appVersion");
        }
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        return [ new TempoTrainerView() ];
    }

	function onSettingsChanged() {
        Ui.requestUpdate();
    }

}