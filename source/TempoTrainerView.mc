using Toybox.Application as App;
using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Attention;
using Toybox.Lang;

class TempoTrainerView extends WatchUi.SimpleDataField {

	enum
    {
        NOT_RUNNING,
        RUNNING
    }

	hidden var _dataFieldMode; // Values: 0 = Rate; 1 = rpm
	hidden var _attentionMode; // Values: 0 = vibrate; 1 = vibrate + tone; 2 = tone; 3 = visual only
	
	hidden var _metronome;
	
	hidden var _vibeProfile;
	hidden var _toneProfile;

	hidden var _message;
	hidden var _messageCounter;
	
	hidden var _rate;
	hidden var _nextRate;
	
	hidden var _timerState = NOT_RUNNING;
	
	hidden var _isHidden = false;
	hidden var _noShowMode;

	function initialize() {
        SimpleDataField.initialize();
		label = "Tempo Trainer";
		
		//TODO: add the ability to switch modes in configuration
		try{
			if(App has :Properties)
			{
        		_dataFieldMode = App.Properties.getValue("mode");
        		_attentionMode = App.Properties.getValue("notify");
        		_rate = App.Properties.getValue("rate");
        		_noShowMode = App.Properties.getValue("onViewOnly");
        	}
        	else
        	{
        		_dataFieldMode = Application.getApp().getProperty("mode");
        		_attentionMode = Application.getApp().getProperty("notify");
        		_rate = Application.getApp().getProperty("rate");
        		_noShowMode = Application.getApp().getProperty("onViewOnly");
        	}
        } catch (e instanceof Lang.Exception) {
        
        }
        _metronome = 0;
        
        _message = ["X _ _ _", "_ X _ _", "_ _ X _", "_ _ _ X", "_ _ X _", "_ X _ _"];
        _messageCounter = 0;
        _nextRate = 0;
        
        computeRateAndAlertProfile();
	}
	
	function compute(info) {
		if(_timerState == RUNNING){
			if(_nextRate <= info.timerTime){
				if (_attentionMode < 3){
					if(!_isHidden){	
						if (_attentionMode > 0){
							if (Attention has :playTone) {
								Attention.playTone(_toneProfile[_metronome]);
							}
						}
						if (_attentionMode < 2){
							if(Attention has :vibrate) {
								Attention.vibrate(_vibeProfile);
							}
						}
					}
					if(_metronome == 0){
						_metronome = 1;
					} 
					else {
						_metronome = 0;
					}
				}
				_messageCounter++;
				if(_messageCounter > 5) {
					_messageCounter = 0;
				}
				_nextRate = info.timerTime + _rate;
			}
		}
		return _message[_messageCounter];
	}
	
	function onTimerStart() {
		_timerState = RUNNING;
	}
	
	function onTimerStop() {
		_timerState = NOT_RUNNING;
	}
	
	function onTimerPause() {
		_timerState = NOT_RUNNING;
	}
	
	function onTimerResume() {
		_timerState = RUNNING;
	}
	
	function onTimerReset() {
		_timerState = NOT_RUNNING;
		_nextRate = 0 + _rate;
	}
	
	function onHide() {
		if(_noShowMode == 1){
			_isHidden = true;
		}
	}
	
	function onShow() {
		_isHidden = false;
	}
	
	function updateSettings() {
		try{
			if(App has :Properties)
			{
        		_dataFieldMode = App.Properties.getValue("mode");
        		_attentionMode = App.Properties.getValue("notify");
        		_rate = App.Properties.getValue("rate");
        	}
        	else
        	{
        		_dataFieldMode = Application.getApp().getProperty("mode");
        		_attentionMode = Application.getApp().getProperty("notify");
        		_rate = Application.getApp().getProperty("rate");
        	}
        } catch (e instanceof Lang.Exception) {
        
        }
        computeRateAndAlertProfile();
	}
	
	function computeRateAndAlertProfile(){
	
		if(_dataFieldMode == 1){
			if(_rate < 1){
				_rate = 1;
			}
			else if(_rate > 60){
				_rate = 60;
			}
			_rate = (60 / _rate) * 1000;
		}
		else
		{
			_rate = _rate * 1000;
		}
	
		if(_rate < 30000)
        {
        	_vibeProfile = [new Attention.VibeProfile(50, 250)];
        	_toneProfile = [6,6];
        }
        else
        {
        	_vibeProfile = [
        		new Attention.VibeProfile(50, 200),
        		new Attention.VibeProfile(0, 200),
        		new Attention.VibeProfile(50, 200),
        		new Attention.VibeProfile(0, 200),
        		new Attention.VibeProfile(50, 200)
        	];
        	_toneProfile = [4,5];
        }
        _nextRate = _nextRate + _rate;
	}
}