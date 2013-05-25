package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Enemy extends FlxSprite {

    public function new() {
        super(0,0);
        //makeGraphic(16,16,0xff00ffff);
        loadGraphic("assets/danger_candy1.png",true,true,16,14,false);
        addAnimation("idle", [0,1], 3, true);
        play("idle");

        exists = false;
    }

    public function launch():Void {
        x = Std.random(Std.int(FlxG.width - width));
        y = -26;
        velocity.y = 100;
        exists = true;
    }

    override public function kill():Void {
        super.kill();
    }

    override public function update():Void {
        super.update();

        if (y > FlxG.height) {
            exists = false;
        }
    }

}