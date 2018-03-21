using Toybox.Application as App;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;
using Toybox.Attention;

class TempoTrainerView extends WatchUi.SimpleDataField {

	hidden var _dataFieldMode; // Values: 0 = Rate; 1 = intervals, 2 = rpm
	hidden var _attentionMode; // Values: 0 = vibrate; 1 = vibrate + tine; 2 = tone;
	
	hidden var _metronome;
	
	hidden var _vibeProfile;

	function initialize() {
        SimpleDataField.initialize();
		label = "Tempo Trainer";
		
		//TODO: add the ability to switch modes in configuration
		
        _dataFieldMode = 0;
        _attentionMode = 1;
        
        if(_dataFieldMode == 1 || _dataFieldMode == 2)
        {
        	_vibeProfile = [new Attention.VibeProfile(50, 250)];
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
        }
	}
	
	function compute(info) {
		
		if(_metronome == 0){
			if (_attentionMode > 0){
				if (Attention has :playTone) {
					if(_dataFieldMode == 0 || _dataFieldMode == 2){
    					Attention.playTone(6);
    				}
    				else{
    					Attention.playTone(4);
    				}
				}
			}
			if (_attentionMode < 2){
				if(Attention has :vibrate) {
					Attention.vibrate(_vibeProfile);
				}
			}
			_metronome = 1;
		}
		else {
			if (_attentionMode > 0){
				if (Attention has :playTone) {
					if(_dataFieldMode == 0 || _dataFieldMode == 2){
    					Attention.playTone(6);
    				}
    				else{
    					Attention.playTone(5);
    				}
				}
			}
			if (_attentionMode < 2){
				if(Attention has :vibrate) {
					Attention.vibrate(_vibeProfile);
				}
			}
			_metronome = 0;
		}
		return _metronome;
	}
}