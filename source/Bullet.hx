package ;
import org.flixel.FlxSprite;

class Bullet extends FlxSprite
{
    public var damage:Int = 1;
    public var speed:Int = 300;

    public function new()
    {
        //load your bullet image
        super(0, 0);
        makeGraphic(3,5,0xffffffff);

        //  We do this so it's ready for pool availability straight away
        exists = false;
    }

    //possibly the most important part of the game ;)
    public function fire(bx:Int, by:Int):Void
    {
        //give the bullet its starting x and y position
        x = bx;
        y = by;
        //the speed of the bullet being an negative y value to move up the screen
        velocity.y = -speed;
        //set the exists to true so that it can be drawn to the screen
        exists = true;
    }

    override public function update():Void
    {
        super.update();

        //  Bullet off the top of the screen?
        if (exists && y < -height)
        {
            //set the bullet exists to false so we know its available
            exists = false;
        }
    }

}