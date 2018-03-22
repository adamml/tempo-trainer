using Toybox.WatchUi as Ui;
class TempoTrainerMenu extends Ui.BehaviorDelegate {
	function initialize(){
		BehaviorDelegate.initialize();
	}
	
	function onMenu() {
		Ui.pushView( new Rez.Menus.MainMenu(), new TempoTrainerMenuDelegate(), Ui.SLIDE_UP );
		return true;
	}
}

class TempoTrainerMenuDelegate extends Ui.MenuInputDelegate {
	function initialize(){
		MenuInputDelegate.initialize();
	}
	
    function onMenuItem(item) {
        if ( item == :mode ) {
            // Do something here
        } else if ( item == :notify ) {
            // Do something else here
        }
        else if ( item == :rate ) {
            // Do something else here
        }
    }
}