package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Enemy2 extends Enemy {

    public function new() {
        super();
        makeGraphic(10,10,0xffffff00);

        exists = false;
    }

    override public function launch():Void {
        x = 64 + Std.int(Math.random() * (FlxG.width - 128));
        y = -10;
        velocity.y = 140;

        health = 2;
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