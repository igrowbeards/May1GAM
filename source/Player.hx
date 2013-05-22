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
    private var singlejump = false;
    private var doublejump = false;
    public var stunned:Bool;
    private var stunTimer:Float;
    private var stunTime:Float = .35;

    public function new() {
        // Set the player location to the center and automatically load it's bitmap image :)
        super(FlxG.width / 2, 0);
        //makeGraphic(16,16,0xffffffff);
        //loadGraphic("assets/player.png",true,false,19,20,true);
        //loadGraphic("assets/player.png");
        maxVelocity.x = 150;
        maxVelocity.y = 600;
        drag.x = maxVelocity.x * 4;
        acceleration.y = 600;
        stunTimer = stunTime;
        loadGraphic("assets/player.png",true,true,15,19,true);
        addAnimation("idle", [0,1], 3, true);
        addAnimation("run", [2,3,4], 10, true);
        addAnimation("jump", [5], 10, true);
        addAnimation("stunned", [6,7,8], 20, true);
        play("idle");
    }

    override public function update():Void {

        #if !FLX_NO_KEYBOARD
        if (!stunned) {

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
        }

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

        //animation manager
        if (stunned) {
            play("stunned");
        }
        else {
            if (!this.isTouching(FlxObject.FLOOR)) {
                play("jump");
            }
            else if (velocity.x != 0) {
                play("run");
            }
            else {
                play("idle");
            }
        }

        // stun handler
        if (stunned) {
            play("stunned");
            if (stunTimer <= 0) {
                stunned = false;
                stunTimer = stunTime;
            }
            else {
                stunTimer -= FlxG.elapsed;
            }
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
            velocity.y = -maxVelocity.y / 2.25;
        }
        else if (!doublejump && !this.isTouching(FlxObject.FLOOR)) {
            velocity.y = -maxVelocity.y / 3.25;
            doublejump = true;
            singlejump = false;
        }
    }

    public function stun() {
        if (!stunned) {
            stunned = true;
        }
    }

}