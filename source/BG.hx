package ;

import nme.Lib;
import nme.Assets;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class BG extends FlxSprite {

    public function new() {
        super(0,0);
        loadGraphic("assets/background.png",true,true,320,480,true);
        addAnimation("default", [0,1,2,3,4], 10, true);
        play("default");
    }

}