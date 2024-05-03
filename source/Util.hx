package;

import lime.utils.Assets;
import openfl.utils.Assets;
import flixel.graphics.frames.FlxAtlasFrames;

class Util
{
	static var file:String;

	inline public static function image(image:String, folder:String = 'images')
	{
		return file = 'assets/$folder/$image.png';
	}

	inline public static function sound(sound:String, folder:String = 'sounds')
	{
		return file = 'assets/$folder/$sound.ogg';
	}

	inline public static function music(music:String, folder:String = 'music')
	{
		return file = 'assets/$folder/$music.ogg';
	}

	inline public static function IntToString(i:Int):String
	{
		var strbuf:StringBuf = new StringBuf();
		strbuf.add(i);
		return strbuf.toString();
	}

	inline public static function FloatToString(i:Float):String
	{
		var strbuf:StringBuf = new StringBuf();
		strbuf.add(i);
		return strbuf.toString();
	}

	inline public static function convertFloatToInt(f:Float):Int
	{
		return Std.int(f);
	}

	inline public static function convertIntToFloat(i:Int):Float
	{
		return i;
	}

	inline public static function txt(path:String)
	{
		return file = 'assets/$path.txt';
	}

	inline public static function read(path:String):String
	{
		return Assets.getText('assets/' + path);
	}

	inline public static function json(path:String)
	{
		return file = 'assets/$path.json';
	}

	inline public static function capitalize(text:String)
		return text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();

	public static function floorDecimal(value:Float, decimals:Int):Float
	{
		if (decimals < 1)
			return Math.floor(value);

		var tempMult:Float = 1;
		for (i in 0...decimals)
			tempMult *= 10;

		var newValue:Float = Math.floor(value * tempMult);
		return newValue / tempMult;
	}

	inline public static function openURL(site:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	inline public static function getURL(site:String):String // grabs the text, like a github raw file
	{
		var request = new haxe.Http(site);
		var response = "";
		request.onData = function(data)
		{
			response = data;
		}
		request.onError = function(error)
		{
			trace('Error: $error');
			response = '';
		}
		request.request(false);

		return (response);
	}

	inline public static function round(value:Float, decimals:Int):Float
	{
		if (decimals < 1)
			return Math.round(value);

		var tempMult:Float = 1;
		for (i in 0...decimals)
			tempMult *= 10;

		var newValue:Float = Math.round(value * tempMult);
		return newValue / tempMult;
	}

	inline public static function roundDown(value:Float, decimals:Int):Float
	{
		if (decimals < 1)
			return Math.floor(value);

		var tempMult:Float = 1;
		for (i in 0...decimals)
			tempMult *= 10;

		var newValue:Float = Math.floor(value * tempMult);
		return newValue / tempMult;
	}

	inline public static function roundToInterval(value:Float, interval:Float):Float
	{
		return Math.round(value / interval) * interval;
	}

	#if desktop
	inline public static function error(error:String, name:String):Void
	{
		FlxG.stage.window.alert(error, name);
	}
	#end

	inline public static function readFile(path:String):Array<String> // read each line as an element in an array
	{
		var file = Assets.getText(path);
		return file.split('\n');
	}

	inline public static function video(video:String, folder:String = 'videos')
	{
		return file = 'assets/$folder/$video.mp4';
	}

	inline public static function sparrowAtlas(path:String, folder:String = 'images')
	{
		return FlxAtlasFrames.fromSparrow('assets/$folder/$path.png', 'assets/$folder/$path.xml');
	}
}
