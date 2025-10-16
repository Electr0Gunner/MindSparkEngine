package backend;

import openfl.media.Sound;
import flixel.graphics.FlxGraphic;

typedef CacheEntry = 
{
    var data:Dynamic;
    var metadata:{
        var permanent:Bool;
        var state:String;
    }
}

class Cache 
{
    private static var _cache:Map<String, CacheEntry>;

    public static function image(path:String):FlxGraphic
    {
        if (!_cache.exists(path))
        {
            var graphic:FlxGraphic = FlxGraphic.fromAssetKey(path, false, path, true);
            graphic.persist = true;
            _cache.set(path, {
                data: graphic, 
                metadata: {permanent: false, state: Type.getClassName(Type.getClass(FlxG.state))}
            });
        }

        return cast(_cache[path].data, FlxGraphic);
    }

    public static function sound(path:String):Sound
    {
        if (!_cache.exists(path))
        {
            var sound:Sound = null;
			#if sys
			if(FileSystem.exists(path))
				sound = Sound.fromFile(path);
			#else
			if(OpenFlAssets.exists(path, SOUND))
				sound = OpenFlAssets.getSound(path);
			#end
            _cache.set(path, {
                data: sound, 
                metadata: {permanent: false, state: Type.getClassName(Type.getClass(FlxG.state))}
            });
        }

        return cast(_cache[path].data, Sound);
    }

    public static function clear():Void 
    {
        for (key in _cache.keys())
        {
            var entry:CacheEntry = _cache.get(key);
            if (!entry.metadata.permanent && entry.metadata.state != Type.getClassName(Type.getClass(FlxG.state)))
            {
                destroyEntry(entry);
                _cache.remove(key);
            }
        }
    }

    //Clear every entry in the cache (used on shutdown really...)
    public static function clearCacheComplete():Void
    {
        for (key in _cache.keys())
        {
            var entry:CacheEntry = _cache.get(key);
            destroyEntry(entry);
            _cache.remove(key);
               
        } 
    }

    private static function destroyEntry(entry:CacheEntry) 
    {
        if (entry == null || entry != null && entry.data == null)
            return;

        var data:Dynamic = entry.data;
        if (Std.isOfType(data, FlxGraphic))
        {                   
            var graphic:FlxGraphic = cast data;
            @:privateAccess {
                if (FlxG.bitmap._cache.exists(graphic.key)) 
                {
                    FlxG.bitmap._cache.remove(graphic.key);
                }
            }

            try
            {
                graphic.destroy();
            }
            catch(e:Dynamic)
            {
                trace("[MINDSPARK]: ERROR DELETING GRAPHIC FROM CACHE: " + e);
            }
        }
    }
}