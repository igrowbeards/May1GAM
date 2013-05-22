package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Enemy extends FlxSprite {

    public function new() {
        super(0,0);
        makeGraphic(16,16,0xff00ffff);

        exists = false;
    }

    public function launch():Void {
        x = Std.random(Std.int(FlxG.width - width));
        y = -16;
        velocity.y = 100;

        health = 4;
        exists = true;
    }

    override public function kill():Void {
        super.kill();
        FlxG.score += 20;
    }

    override public function update():Void {
        super.update();

        if (y > FlxG.height) {
            exists = false;
        }
    }

}