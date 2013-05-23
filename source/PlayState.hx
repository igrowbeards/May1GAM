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
  public var gameOver:Bool;
  public var screenDimmer:FlxSprite;
  private var optionsIndicator:FlxSprite;
  private var gameOverText:FlxText;
  private var optionsText:FlxText;
  public var gameOverOption:Int = 0;
  public var kidsCollected:Int = 0;
  public var children:ChildManager;

  //create all the game state objects, overriding create is the best place
  override public function create():Void {
    FlxG.bgColor = 0xff241600;
    //initialise the game Registry
    Registry.init((FlxG.level + 1) * 5, ((FlxG.level + 1) * 3) - 1);

    speedUpTimer = speedUpTime;

    //create your text
    score = new FlxText(0, 0, 360, "0");

    //add your objects to the game stage to be drawn
    add(Registry.bullets);
    add(Registry.player);
    add(Registry.platforms);
    children = new ChildManager((FlxG.level + 1) * 5);
    add(children);
    add(score);

    floor = new FlxSprite(50,20);
    floor.makeGraphic(FlxG.width -100,10,0xffff00ff);
    floor.velocity.y = 20;
    floor.immovable = true;
    add(floor);
    add(Registry.enemies);

    lava = new FlxSprite(0,FlxG.height - 30);
    lava.makeGraphic(FlxG.width,30,0xffff0000);
    lava.immovable = true;
    add(lava);

    screenDimmer = new FlxSprite(0,0);
    screenDimmer.makeGraphic(FlxG.width,FlxG.height,0x99000000);
    screenDimmer.exists = false;
    add(screenDimmer);

    gameOverText = new FlxText(0, 60, FlxG.width, "Level Failed");
    gameOverText.alignment = 'center';
    gameOverText.size = 40;
    gameOverText.exists = false;
    add(gameOverText);

    optionsText = new FlxText(0,140,FlxG.width, "");
    optionsText.alignment = 'center';
    optionsText.size = 16;
    optionsText.exists = false;
    optionsText.text = "Retry\n\nMenu\n\nCredits";
    add(optionsText);

    optionsIndicator = new FlxSprite(133,256);
    optionsIndicator.loadGraphic("assets/indicator.png");
    add(optionsIndicator);
    optionsIndicator.exists = false;
  }

  override public function update():Void {
    if (!gameOver) {
      FlxG.collide(floor,Registry.player);
      FlxG.collide(Registry.platforms,Registry.player);
      FlxG.collide(children,Registry.platforms);
      FlxG.collide(children,floor);
      FlxG.collide(lava,Registry.player,levelOver);
      FlxG.overlap(Registry.platforms,Registry.enemies,enemyHitLevel);
      FlxG.overlap(floor,Registry.enemies,enemyHitLevel);
      FlxG.overlap(Registry.player,Registry.enemies,playerHitEnemy);
      FlxG.overlap(Registry.player,children,playerHitChild);

      score.text = Std.string(kidsCollected) + " out of " + Std.string(Registry.totalKids) + " kids saved (" + Std.string(Registry.targetKids) + " needed)";

      super.update();
      Registry.player.acceleration.x = 0;

      if (Registry.gameSpeed < speedUpTime) {
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
    else if (gameOver) {

      switch (gameOverOption) {
        case 0:
          optionsIndicator.x = 115;
          optionsIndicator.y = 142;
      }

      if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER")) {
        switch (gameOverOption) {
          case 0:
            fadeOutToPlayState();
        }
      }
    }
  }

  public function levelOver(l:FlxObject,p:FlxObject) {
    gameOver = true;
    screenDimmer.exists = true;
    if (kidsCollected >= Registry.targetKids) {
      gameOverText.text = "Level Clear!";
      optionsText.text = "Next Level\n\nMenu\n\nCredits";
      FlxG.level++;
    }
    else {
      gameOverText.text = "Level Failed";
      optionsText.text = "Retry\n\nMenu\n\nCredits";
    }
    gameOverText.exists = true;
    optionsText.exists = true;
    optionsIndicator.exists = true;
  }

  public function fadeOutToPlayState() {
    FlxG.fade(0xff000000,.5,resetLevel);
  }

  public function resetLevel():Void {
    Registry.gameSpeed = 1;
    FlxG.resetState();
  }

  public function enemyHitLevel(plat:FlxObject,e:FlxObject) {
    e.kill();
  }

  public function playerHitEnemy(p:FlxObject,e:FlxObject) {
    e.kill();
    var playerRef = cast(p, Player);
    playerRef.stun();
  }

  public function playerHitChild(p:FlxObject,c:FlxObject) {
    c.kill();
    kidsCollected++;
    var playerRef = cast(p, Player);
    FlxG.score += 10000;
  }

}