package ;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxText;
import org.flixel.FlxState;
import org.flixel.FlxObject;

class PlayState extends FlxState {
  private var score:FlxText;
  private var floor:FlxSprite;
  private var lava:FlxSprite;
  private var speedUpTimer:Float;
  private var speedUpTime:Float = 5;

  //create all the game state objects, overriding create is the best place
  override public function create():Void {
    FlxG.bgColor = 0xff241600;
    //initialise the game Registry
    Registry.init();

    speedUpTimer = speedUpTime;

    //create your text
    score = new FlxText(0, 0, 360, "0");

    //add your objects to the game stage to be drawn
    add(Registry.bullets);
    add(Registry.player);
    add(Registry.platforms);
    add(score);

    floor = new FlxSprite(0,20);
    floor.makeGraphic(FlxG.width,10,0xffff00ff);
    floor.velocity.y = 20;
    floor.immovable = true;
    add(floor);
    add(Registry.enemies);

    lava = new FlxSprite(0,FlxG.height - 30);
    lava.makeGraphic(FlxG.width,30,0xffff0000);
    lava.immovable = true;
    add(lava);
  }

  override public function update():Void {

    FlxG.collide(floor,Registry.player);
    FlxG.collide(Registry.platforms,Registry.player);
    FlxG.collide(lava,Registry.player,gameOver);
    FlxG.collide(Registry.platforms,Registry.enemies,enemyHitLevel);
    FlxG.collide(floor,Registry.enemies,enemyHitLevel);
    FlxG.overlap(Registry.player,Registry.enemies,playerHitEnemy);

    score.text = Std.string(FlxG.score);

    super.update();
    Registry.player.acceleration.x = 0;

    if (Registry.gameSpeed < 3.25) {
      if (speedUpTimer >= 0) {
        speedUpTimer -= FlxG.elapsed;
      }
      else {
        speedUpTimer = speedUpTime;
        Registry.gameSpeed += .1;
        FlxG.log(Registry.gameSpeed);
      }
    }

    floor.velocity.y = 20 * Registry.gameSpeed;
    FlxG.score += Std.int(FlxG.elapsed);
  }

  public function gameOver(l:FlxObject,p:FlxObject) {
    FlxG.resetGame();
    Registry.gameSpeed = 1;
  }

  public function enemyHitLevel(plat:FlxObject,e:FlxObject) {
    e.kill();
  }

  public function playerHitEnemy(p:FlxObject,e:FlxObject) {
    e.kill();
    var playerRef = cast(p, Player);
    playerRef.stun();
  }


}