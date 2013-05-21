package;

import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;

class PlatformManager extends FlxGroup {

  private var lastReleased:Int;
  private var releaseRate:Int;

  public function new() {
    super();

    releaseRate = 3500;

    var poolSize = 100;
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
    if (Lib.getTimer() > lastReleased +  releaseRate) {
      lastReleased = Lib.getTimer();
      release();
    }
  }
}