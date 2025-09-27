package backend.ui.display;

class StatsTab extends MindDebugTab 
{
    public function new() {
        super();
        title.text = '- STATS -';
    }

    override function __enterFrame(t:Int) {
        super.__enterFrame(t);

        info.text = 'Current State: ' + Type.getClassName(Type.getClass(FlxG.state));
        info.text += '\nCurrent Sub-State: ' + (Type.getClassName(Type.getClass(FlxG.state.subState)) ?? "None");
        @:privateAccess
        {
            if (Main.debugDisplay.isAdvancedMode)
            {
                info.text += '\nBitmaps: ' + Lambda.count(FlxG.bitmap._cache);
                var soundsPlaying:Int = 0;
                for (sound in FlxG.sound.list.members)
                {
                    if (sound.playing)
                        soundsPlaying++;
                }
                info.text += '\nSounds: ' + soundsPlaying;
            }
        }

    }


}