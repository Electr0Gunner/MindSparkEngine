package backend.ui.display;

import openfl.events.KeyboardEvent;
import openfl.display.Sprite;

class MindDebugDisplay extends Sprite 
{
    var tabs:Array<MindDebugTab> = [];
    var currentTab:Int = 0;

    public var isAdvancedMode:Bool = false;
    
    public function new() {
        super();

        x = 3;
        y = 3;

        var performance:PerformanceTab = new PerformanceTab();
        addChild(performance);
        tabs.push(performance);

        var stats:StatsTab = new StatsTab();
        addChild(stats);
        tabs.push(stats);

        var build:BuildTab = new BuildTab();
        addChild(build);
        tabs.push(build);

        flixel.FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent) 
		{
			if (e.keyCode == openfl.ui.Keyboard.F3) {
				currentTab = (currentTab + 1) % (tabs.length + 1);
				reloadTabs();
			}
			else if (e.keyCode == openfl.ui.Keyboard.F4) {
				isAdvancedMode = !isAdvancedMode;
			}
		});

        currentTab = tabs.length + 1;
        reloadTabs();
        currentTab = tabs.length;
    }

    function reloadTabs() 
    {
		if (currentTab > tabs.length)
			alpha = alpha == 1.0 ? 1.0 : 0.0;
		for (i in 0...tabs.length)
		{
			tabs[i].alpha = 0.0;
			if (i == currentTab)
				tabs[i].alpha = 1.0;
		} 
    }
}