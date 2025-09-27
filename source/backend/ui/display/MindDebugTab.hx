package backend.ui.display;

import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.display.Shape;
import openfl.display.Sprite;

class MindDebugTab extends Sprite {
    public var backdrop:Shape;
    public var backdropWidthOffset:Int;
    public var backdropHeightOffset:Int;
    
    var title:TextField;
    var info:TextField;

    public function new() {
        super();

        backdrop = new Shape();
        backdrop.graphics.beginFill(0xFF505050, 0.5);
        backdrop.graphics.drawRect(0, 0, 50, 70);
        backdrop.graphics.endFill();
		addChild(backdrop);

		title = new TextField();
        title.x = 3;
        title.y = 4;
        title.text = "coolswag";
        title.defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFFFF);
        title.autoSize = LEFT;
        title.selectable = false;
        title.mouseEnabled = false;
        addChild(title);
        
		info = new TextField();
        info.x = 4;
        info.y = title.y + title.height + 3;
        info.text = "lololololol\ncool indeed";
        info.defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFFFF);
        info.autoSize = LEFT;
        info.selectable = false;
        info.mouseEnabled = false;
        addChild(info);
    }

    public override function __enterFrame(t:Int) 
    {
        super.__enterFrame(t);

		backdrop.width = Math.max(title.width, info.width) + 9 + backdropWidthOffset;
		backdrop.height = title.height + info.height + 9 + backdropHeightOffset;
    }
}