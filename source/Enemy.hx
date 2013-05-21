package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Enemy extends FlxSprite {

    public function new() {
        super(0,0);
        makeGraphic(16,16,0xffffffff);

        exists = false;
    }

    public function launch():Void {
        x = 64 + Std.int(Math.random() * (FlxG.width - 128));
        y = -16;
        velocity.y = 60;

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