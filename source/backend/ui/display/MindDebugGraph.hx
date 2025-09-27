package backend.ui.display;

import openfl.display.Shape;
import openfl.display.Sprite;

class MindDebugGraph extends Sprite
{

    var history:Array<Float> = [];
    var historyMAX:Int = 100;

    public var minValue:Float = FlxMath.MAX_VALUE_FLOAT;

    public var maxValue:Float = FlxMath.MIN_VALUE_FLOAT;

    var axis:Shape;

    public var currentColor:FlxColor = FlxColor.WHITE;
        
    var axisWidth:Float = 140;
    var axisHeight:Float = 60;


    public function new(X:Float = 0, Y:Float = 0, Width:Float, Height:Float) {
        super();

        this.x = X;
        this.y = Y;
        axisWidth = Width;
        axisWidth = Height;
        axis = new Shape();
        addChild(axis);
        createAxis();
    }

    function createAxis()
    {
        axis.graphics.clear();
        axis.graphics.lineStyle(1, FlxColor.WHITE);
        axis.graphics.moveTo(0, 0);
        axis.graphics.lineTo(0, axisHeight);
        axis.graphics.moveTo(0, axisHeight);
        axis.graphics.lineTo(axisWidth, axisHeight);
    }

    function drawGraph() 
    {
        graphics.clear();

        graphics.lineStyle(1, currentColor, 1, false, null, null, MITER, 255);

        if (history.length == 0)
            return;

        var increment:Float = (axisWidth - 2) / (historyMAX - 1);
        var range:Float = Math.max(maxValue - minValue, maxValue * 0.1);
        var scale:Float = axisHeight / range;
        
        for (i in 0...history.length)
        {
            final pointY:Float = axisHeight - ((history[i] - minValue) * scale) - 1;

            if (i == 0) graphics.moveTo(axis.x, pointY);

            graphics.lineTo(axis.x + 1 + (i * increment), pointY);
        }
    }

    public function updateGraph(value:Float) 
    {
        history.push(value);
        if (history.length > historyMAX)
            history.shift();

        maxValue = Math.max(maxValue, value);
        minValue = Math.min(minValue, value);

        drawGraph();
    }
}