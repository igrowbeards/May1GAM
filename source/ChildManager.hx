package;

import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;

class ChildManager extends FlxGroup {

  private var releaseRate:Float = 5;
  private var releaseTimer:Float;

  public function new(poolSize:Int = 5) {
    super();
    releaseTimer = releaseRate;

    var i = 0;
    while (i < poolSize) {
      var child = new Child();
      add(child);
      i++;
    }
  }

  public function release():Void {
    var c = cast(getFirstAvailable(), Child);

    if (c!=null) {
      c.launch();
    }
  }

  override public function update():Void {
    super.update();
    if (releaseTimer <= 0) {
      release();
      releaseTimer = releaseRate;
      releaseTimer += Std.random(10);
    }
    else {
      releaseTimer -= FlxG.elapsed;
    }
  }
}