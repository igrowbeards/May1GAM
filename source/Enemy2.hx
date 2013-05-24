package;

import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;

class Enemy2 extends Enemy {

    public function new() {
        super();
        makeGraphic(10,10,0xffffff00);

        exists = false;
    }

    override public function launch():Void {
        //x = Std.int(Math.random() xG.width - 128));
        x = Std.random(FlxG.width - 20) + 10;
        y = -10;
        velocity.y = 140;

        exists = true;
        solid = true;
    }

    override public function kill():Void {
        super.kill();
    }

    override public function update():Void {
        super.update();

        if (y > FlxG.height) {
            exists = false;
            solid = false;
        }
    }

}