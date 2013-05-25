package ;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxText;
import org.flixel.FlxState;
import org.flixel.FlxObject;
import org.flixel.addons.FlxBackdrop;

class PlayState extends FlxState {
  private var floor:FlxSprite;
  private var lava:FlxSprite;
  private var speedUpTimer:Float;
  private var speedUpTime:Float = 8;
  public var gameOver:Bool;
  public var screenDimmer:FlxSprite;
  private var optionsIndicator:FlxSprite;
  private var scoreText:FlxText;
  private var multiplier:Int = 1;
  private var streak:Int;
  private var multiplierText:FlxText;
  private var gameOverText:FlxText;
  private var gameOverStats:FlxText;
  private var optionsText:FlxText;
  public var gameOverOption:Int = 0;
  public var kidsCollected:Int = 0;
  public var kidsKilled:Int = 0;
  public var children:ChildManager;
  public var scanlines:FlxBackdrop;
  public var vignette:FlxBackdrop;
  public var bg:BG;

  //create all the game state objects, overriding create is the best place
  override public function create():Void {
    FlxG.bgColor = 0xff241600;
    //initialise the game Registry
    Registry.init();

    speedUpTimer = speedUpTime;

    bg = new BG();
    add(bg);

    //add your objects to the game stage to be drawn
    add(Registry.bullets);
    add(Registry.player);
    add(Registry.platforms);
    children = new ChildManager(10);
    add(children);

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

    scoreText = new FlxText(10,10,FlxG.width - 20,"0");
    scoreText.size = 14;
    add(scoreText);

    multiplierText = new FlxText(10,10,FlxG.width - 20,"");
    multiplierText.size = 14;
    multiplierText.alignment = 'right';
    add(multiplierText);

    gameOverText = new FlxText(0, 60, FlxG.width, "Level Failed");
    gameOverText.alignment = 'center';
    gameOverText.size = 40;
    gameOverText.exists = false;
    add(gameOverText);

    gameOverStats = new FlxText(10, 150, FlxG.width - 20, "");
    gameOverStats.alignment = 'center';
    gameOverStats.size = 14;
    gameOverStats.exists = false;
    add(gameOverStats);

    optionsText = new FlxText(0,290,FlxG.width, "");
    optionsText.alignment = 'center';
    optionsText.size = 16;
    optionsText.exists = false;
    optionsText.text = "Retry\n\nMenu\n\nCredits";
    add(optionsText);

    optionsIndicator = new FlxSprite(133,256);
    optionsIndicator.loadGraphic("assets/indicator.png");
    add(optionsIndicator);
    optionsIndicator.exists = false;

    scanlines = new FlxBackdrop("assets/scanlines2.png", 0, 0, true, true);
    //add(scanlines);

    vignette = new FlxBackdrop("assets/vignette.png", 0, 0, false, false);
    add(vignette);

  }

  override public function update():Void {
    if (!gameOver) {
      FlxG.collide(floor,Registry.player);
      FlxG.collide(Registry.platforms,Registry.player);
      FlxG.collide(children,Registry.platforms);
      FlxG.collide(children,floor);
      FlxG.collide(lava,Registry.player,levelOver);
      FlxG.collide(children,lava, childHitLava);
      FlxG.overlap(Registry.platforms,Registry.enemies,enemyHitLevel);
      FlxG.overlap(floor,Registry.enemies,enemyHitLevel);
      FlxG.overlap(Registry.player,Registry.enemies,playerHitEnemy);
      FlxG.overlap(Registry.player,children,playerHitChild);


      super.update();
      Registry.player.acceleration.x = 0;

      if (Registry.gameSpeed < speedUpTime) {
        if (speedUpTimer >= 0) {
          speedUpTimer -= FlxG.elapsed;
        }
        else {
          speedUpTimer = speedUpTime;
          Registry.gameSpeed += .1;
        }
      }

      floor.velocity.y = 20 * Registry.gameSpeed;
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

    // calculate multiplier
    if (streak >= 15) {
      multiplier = 5;
    }
    else if (streak >= 10) {
      multiplier = 4;
    }
    else if (streak >= 7) {
      multiplier = 3;
    }
    else if (streak >= 3) {
      multiplier = 2;
    }
    else {
      multiplier = 1;
    }

    // update score text
    scoreText.text = Std.string(FlxG.score);

    if (multiplier > 1) {
      multiplierText.text = Std.string("x" + multiplier);
    }
    else {
      multiplierText.text = Std.string("");
    }

  }

  public function levelOver(l:FlxObject,p:FlxObject) {
    var pref = cast(p, Player);
    pref.stun();
    screenDimmer.exists = true;
    gameOverText.text = "GAME OVER";
    gameOverStats.text = "Score: " + FlxG.score + "\n\nYou rescued " + Std.string(Registry.kidsSaved) + " children. \n\nYou let " + Std.string(Registry.kidsKilled) + " children to plummet to their deaths";
    optionsText.text = "Try Again\n\nMenu\n\nCredits";
    gameOverText.exists = true;
    optionsText.exists = true;
    gameOverStats.exists = true;
    optionsIndicator.exists = true;
    gameOver = true;
  }

  public function fadeOutToPlayState() {
    FlxG.fade(0xff000000,.5,resetLevel);
  }

  public function resetLevel():Void {
    Registry.kidsKilled = 0;
    Registry.kidsSaved = 0;
    Registry.gameSpeed = 1;
    FlxG.score = 0;
    FlxG.resetState();
  }

  public function enemyHitLevel(plat:FlxObject,e:FlxObject) {
    e.kill();
  }

  public function playerHitEnemy(p:FlxObject,e:FlxObject) {
    e.kill();
    var playerRef = cast(p, Player);
    playerRef.stun();
    FlxG.log("hit enemy");
  }

  public function playerHitChild(p:FlxObject,c:FlxObject) {
    c.kill();
    Registry.kidsSaved += 1;
    var playerRef = cast(p, Player);
    FlxG.score += 500 * multiplier;
    streak += 1;
  }

  public function childHitLava(child:FlxObject,lava:FlxObject) {
    child.kill();
    Registry.kidsKilled += 1;
    streak = 0;
  }

}