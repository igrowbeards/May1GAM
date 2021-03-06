package ;

import org.flixel.FlxSprite;
import org.flixel.FlxG;

class Registry {

    public static var stars:FlxSprite;
    public static var player:Player;
    public static var bullets:BulletManager;
    public static var enemies:EnemyManager;
    public static var platforms:PlatformManager;
    public static var gameSpeed:Float = 1;
    public static var kidsSaved:Int;
    public static var kidsKilled:Int;

    //Setup the Registry Objects to create your instances
    public static function init() {
        player = new Player();
        bullets = new BulletManager(60);
        enemies = new EnemyManager();
        platforms = new PlatformManager();
    }

}