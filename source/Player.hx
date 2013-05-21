package ;

import nme.Lib;
import nme.Assets;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class Player extends FlxSprite {
    //We want to shoot bullets in a sequential delayed order over time rather than all at once
    private var bulletDelay:Int = 75;
    //Store the time of the last fired bullet so that we know when to shoot
    private var lastFired:Int;
    //the x axis movement speed
    private var xSpeed:Float = 200;
    //the y axis movement speed
    private var ySpeed:Float = 100;
    //the current fire type for the player
    public var fireType:Int = 1;
    private var singlejump = false;
    private var doublejump = false;

    public function new() {
        // Set the player location to the center and automatically load it's bitmap image :)
        super(FlxG.width / 2, 0);
        makeGraphic(16,16,0xffffffff);
        maxVelocity.x = 100;
        maxVelocity.y = 400;
        drag.x = maxVelocity.x * 4;
        acceleration.y = 400;
    }

    override public function update():Void {

        #if !FLX_NO_KEYBOARD

        if (FlxG.keys.LEFT) {
            moveLeft();
        }

        if (FlxG.keys.RIGHT) {
            moveRight();
        }

        if (FlxG.keys.justPressed("UP")) {
            jump();
        }
        #end

        super.update();
        if (x < 0) {
            x = 0;
            velocity.x = 0;
        }
        else if (x > FlxG.width - width) {
            x = FlxG.width - width;
            velocity.x = 0;
        }

        if (this.isTouching(FlxObject.FLOOR)) {
            singlejump = false;
        }

    }

    public function moveLeft():Bool {
        acceleration.x = -maxVelocity.x * 4;
        facing = FlxObject.LEFT;
        return true;
    }

    public function moveRight():Bool {
        acceleration.x = maxVelocity.x * 4;
        facing = FlxObject.RIGHT;
        return true;
    }

    public function jump() {
        if (!singlejump && this.isTouching(FlxObject.FLOOR)) {
            singlejump = true;
            doublejump = false;
            velocity.y = -maxVelocity.y / 2;
            FlxG.log("jump 1");
        }
        else if (!doublejump && !this.isTouching(FlxObject.FLOOR)) {
            velocity.y = -maxVelocity.y / 2;
            doublejump = true;
            singlejump = false;
            FlxG.log("jump 2");
        }
        else {
            FlxG.log("couldn't jump");
        }
    }

}