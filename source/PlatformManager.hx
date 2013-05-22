package;

import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;

class PlatformManager extends FlxGroup {

  // 1
  //private var releaseRate:Float = 1.25;
  // 2
  //private var releaseRate:Float = 1.1;
  // 3
  private var releaseRate:Float = 1.8;
  private var releaseTimer:Float;

  public function new() {
    super();
    releaseTimer = releaseRate;

    var poolSize = 11;
    var i = 0;
    while (i < poolSize) {
      var p = new Platform();
      add(p);
      i++;
    }
  }

  public function release():Void {
    var pp = cast(getFirstAvailable(), Platform);

    if (pp!=null) {
      pp.launch();
    }
  }

  override public function update():Void {
    super.update();
    if (releaseTimer <= 0) {
      release();
      releaseTimer = releaseRate;
    }
    else {
      releaseTimer -= FlxG.elapsed;
    }
  }
}