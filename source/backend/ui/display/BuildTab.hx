package backend.ui.display;

import haxe.macro.Compiler;

class BuildTab extends MindDebugTab 
{
    public function new() {
        super();
        title.text = '- BUILD -';
        info.text = 'MindSpark v' + FunkinGame.ENGINE_VERSION;
        info.text += '\nHaxe: ' + Compiler.getDefine('haxe');
        info.text += '\nHaxeflixel: ' + Std.string(FlxG.VERSION);
        info.text += '\nOpenFL: ' + Compiler.getDefine('openfl');
        #if VIDEOS_ALLOWED
        info.text += '\nhxvlc: ' + Compiler.getDefine('hxvlc');
        #end
    }


}