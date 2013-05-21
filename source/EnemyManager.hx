package;

import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;

class EnemyManager extends FlxGroup {

  private var lastReleased:Int;
  private var releaseRate:Int;

  public function new() {
    super();

    releaseRate = 1000;

    var poolSize = 100;
    var i = 0;
    while (i < poolSize) {
      var enemy = new Enemy();
      add(enemy);
      var enemy2 = new Enemy2();
      add(enemy2);
      i++;
    }
  }

  public function release1():Void {
    var enemy = cast (getFirstAvailable(), Enemy);

    if (enemy!=null) {
      enemy.launch();
    }
  }

  public function release2():Void {
    var enemy2 = cast (getFirstAvailable(), Enemy2);

    if (enemy2!=null) {
      enemy2.launch();
    }
  }

  override public function update():Void {
    super.update();
    if (Lib.getTimer() > lastReleased +  releaseRate) {
      lastReleased = Lib.getTimer();
      //release1();
      //release2();
      if (releaseRate > 300) {
        releaseRate -= 1;
      }
    }
  }

  public function bulletHitEnemy(bullet:FlxObject, enemy:FlxObject):Void {
    bullet.kill();
    enemy.hurt(1);
    //FlxG.score += 1;
  }

}