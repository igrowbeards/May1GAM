package ;

import nme.Lib;
import nme.Assets;
import org.flixel.FlxG;
import org.flixel.FlxSprite;

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

    public function new() {
        // Set the player location to the center and automatically load it's bitmap image :)
        super(FlxG.width / 2, FlxG.height - 16);
        makeGraphic(16,16,0xffffffff);
    }

    override public function update():Void {
        super.update();

        //Make sure the ships movement is under control
        velocity.x = 0;
        velocity.y = 0;

        //Move the player left with the velocity value in a negative value
        if (FlxG.keys.LEFT && x > 0) {
            velocity.x -= xSpeed;
        }
        //Move the player right with the velocity x value in a positive value
        if (FlxG.keys.RIGHT && x < FlxG.width - width) {
            velocity.x += xSpeed;
        }
        //Move the player up with the velocity y axis value in a positive value
        if (FlxG.keys.UP && y >= 100) {
            velocity.y -= ySpeed;
            if (y < 100) {
                y = 100;
            }
        }
        //Move the player up with the velocity y axis value in a negative value
        if (FlxG.keys.DOWN && y < FlxG.height - height) {
            velocity.y += ySpeed;
        }
        //Keep the ship on the screen at all times
        if (x < 0) {
            x = 0;
        }
        else if (x > FlxG.width - width) {
            x = FlxG.width - width;
        }
        //Logic to Fire!
        // We dont want to fire too much at once, this lets the bulletDelay emulate an interval based on the timer and delay
        if (FlxG.keys.pressed("X") && Lib.getTimer() > lastFired + bulletDelay) {
           switch (fireType) {
                case 1:
                // Lame Single fire
                    Registry.bullets.fire(Std.int(x + 5), Std.int(y) );

                case 2:
                //  Double fire!
                    Registry.bullets.fire(Std.int(x), Std.int(y));
                    Registry.bullets.fire(Std.int(x + 10), Std.int(y));

                case 3:
                //  Insane Quad fire!
                //Notice how a 40 limit on the Bullet manager now isnt enough!! :)
                    Registry.bullets.fire(Std.int(x - 8), Std.int(y - 5));
                    Registry.bullets.fire(Std.int(x), Std.int(y - 10));
                    Registry.bullets.fire(Std.int(x + 10), Std.int(y - 10));
                    Registry.bullets.fire(Std.int(x + 18), Std.int(y - 5));
            }
            //Use the awsome nme get timer that will work on all supported runtimes
            lastFired = Lib.getTimer();
        }

    }

}