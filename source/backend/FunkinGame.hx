package backend;

import states.TitleState;
import flixel.FlxGame;

class FunkinGame extends FlxGame {
    public static final ENGINE_VERSION:String = '0.1.0';
    public static var LATEST_ENGINE_VERSION:String = '';
    public static var CAN_UPDATE:Bool;

	public function new(gameWidth = 0, gameHeight = 0, updateFramerate = 60, drawFramerate = 60, skipSplash = false, startFullscreen = false)
	{

		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if LUA_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		var initialState:flixel.util.typeLimit.NextState.InitialState = TitleState;

		#if CHECK_FOR_UPDATES 
		if (ClientPrefs.data.checkForUpdates && states.OutdatedState.updateVersion != FunkinGame.ENGINE_VERSION) {
			initialState = states.OutdatedState;
		}
		#end

		FlxG.save.bind('funkin', CoolUtil.getSavePath());
		Highscore.load();

        Controls.instance = new Controls();
		ClientPrefs.loadDefaultKeys();


		super(gameWidth, gameHeight, initialState, updateFramerate, drawFramerate, skipSplash, startFullscreen);

		#if ACHIEVEMENTS_ALLOWED Achievements.load(); #end

		ClientPrefs.loadPrefs();
		Language.reloadPhrases();

		#if DISCORD_ALLOWED
		DiscordClient.prepare();
		#end


       	#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end

		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];
	}
}