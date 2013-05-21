package ;

import org.flixel.FlxGroup;

class BulletManager extends FlxGroup
{

    public function new(poolSize:Int = 40)
    {
        super();

        //  Create only a limited poolSize amount of Bullets so we can reuse them
        var i = 0;
        while (i < poolSize) {
            //create the bullet and add it to this FlxGroup
            var bullet = new Bullet();
            add(bullet);
            i++;
        }

    }

    // This lets us have a useful method to FIRE by using bullets available in the Object Pool
    public function fire(bx:Int, by:Int):Void
    {
        //check if there is an available bullet
        if (getFirstAvailable() != null)
        {
            //get an available bullet to fire and let haxe know its a Bullet type with cast
            var bullet = cast ( getFirstAvailable(), Bullet );
            //shoot it at the starting x and y position
            bullet.fire(bx, by);
        }
    }

}