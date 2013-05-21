package;

import org.flixel.plugin.photonstorm.FlxDisplay;
import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;

class MenuState extends FlxState {
	override public function create():Void {
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
    var startButton = new FlxButton(0, 0, "Start", onStartClick);
    add(startButton);
    FlxDisplay.screenCenter(startButton,true,true);
	}

	private function onStartClick( ):Void {
	  FlxG.switchState( new PlayState( ) );
	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();
	}
}