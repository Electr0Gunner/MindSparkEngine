package backend.ui.display;

import openfl.display.Shape;
import openfl.system.System;

class PerformanceTab extends MindDebugTab 
{
    public var currentFPS(default, null):Int = 0;

    private var frameTimes:Array<Float> = [];
    private var elapsed:Float = 0;
    private var cacheCount:Int = 0;

    public var memory:Float = 0;
	public var memoryPeak:Float = 0;

    var memGraph:MindDebugGraph;

    public function new() {
        super();
        title.text = '- PERFORMANCE -';
        memGraph = new MindDebugGraph(10, 70, 170, 160);
        memGraph.minValue = 0;
        addChild(memGraph);
        backdropHeightOffset = 90;
    }


    public override function __enterFrame(t:Int) 
    {
        super.__enterFrame(t);
        elapsed += t;
        frameTimes.push(elapsed);

        // Trim frames older than 1 second
        while (frameTimes.length > 0 && frameTimes[0] < elapsed - 1000) {
            frameTimes.shift();
        }

        var currentCount = frameTimes.length;
        currentFPS = Math.round((currentCount + cacheCount) / 2);

        var curMem:Float = Math.round(System.totalMemory);
        if (curMem > memoryPeak)
            memoryPeak = curMem;

        // Update only if changed
        if (currentCount != cacheCount || memory != curMem) {
            var output = "Framerate: " + currentFPS;
            output += "\nMemory Usage: " + CoolUtil.formatBytes(curMem);
            output += " (Peak: " + CoolUtil.formatBytes(memoryPeak) + ") ";

            info.text = output;
        }

        memory = curMem;
        cacheCount = currentCount;

        backdropHeightOffset = 0;
        memGraph.visible = Main.debugDisplay.isAdvancedMode;
        if (Main.debugDisplay.isAdvancedMode)
        {
            backdropHeightOffset = 90;
            memGraph.currentColor = 0xFFFFFFFF;
            if (currentFPS < FlxG.drawFramerate * 0.5)
                memGraph.currentColor = 0xFFFF0000;
            memGraph.maxValue = memoryPeak;
            memGraph.updateGraph(memory);            
        }

    }
}