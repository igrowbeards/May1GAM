package ;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxText;
import org.flixel.FlxState;

class PlayState extends FlxState {
  private var score:FlxText;
  private var floor:FlxSprite;

  //create all the game state objects, overriding create is the best place
  override public function create():Void {
    //initialise the game Registry
    Registry.init();

    //create your text
    score = new FlxText(0, 0, 360, "0");

    //add your objects to the game stage to be drawn
    add(Registry.bullets);
    add(Registry.player);
    add(Registry.platforms);
    add(score);

    floor = new FlxSprite(0,20);
    floor.makeGraphic(FlxG.width,10,0xffff00ff);
    floor.velocity.y = 10;
    floor.immovable = true;
    add(floor);
    add(Registry.enemies);
  }

  override public function update():Void {

    FlxG.overlap(Registry.bullets, Registry.enemies, Registry.enemies.bulletHitEnemy);
    FlxG.collide(floor,Registry.player);
    FlxG.collide(Registry.platforms,Registry.player);

    //setup the logic to change fire modes
    if (FlxG.keys.justPressed("ONE")) {
      Registry.player.fireType = 1;
    }

    if (FlxG.keys.justPressed("TWO")) {
      Registry.player.fireType = 2;
    }

    if (FlxG.keys.justPressed("THREE")) {
      Registry.player.fireType = 3;
    }

    score.text = Std.string(FlxG.score);

    //dont forget to update the rest of the core state and everything in it
    super.update();
    Registry.player.acceleration.x = 0;

  }

}