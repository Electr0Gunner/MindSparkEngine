package scripting;

import rulescript.parsers.HxParser;
import rulescript.scriptedClass.RuleScriptedClassUtil;
import sys.FileSystem;

class ScriptRegistry
{
	public static function registerCharacters()
	{
		for (script in FileSystem.readDirectory('assets/shared/scripts'))
		{
			var splitResult = script.split('.');
			var parser:HxParser = new HxParser();
			parser.allowAll();
			parser.mode = MODULE;
			var stuff:String = sys.io.File.getContent('assets/shared/scripts/$script');
			try
			{
				RuleScriptedClassUtil.registerRuleScriptedClass(splitResult[0], parser.parse(stuff));
			}
			catch (err)
			{
				trace("Error with script:" + script + " " + err.details());
			}

			trace("Processed script:" + script);
		}
	}
}
