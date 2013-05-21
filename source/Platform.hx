package ;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

class Platform extends FlxSprite {

    public var speed:Int = 10;
    private var platformStartX:Int;
    private var platformWidth:Int;

    public function new() {
        super(platformStartX, 0);
        switch(Std.random(5)) {
          case 0:
            makeGraphic(32,10,0xffff00ff);
          case 1:
            makeGraphic(64,10,0xffff00ff);
          case 2:
            makeGraphic(96,10,0xffff00ff);
          case 3:
            makeGraphic(138,10,0xffff00ff);
          case 4:
            makeGraphic(160,10,0xffff00ff);
        }
        immovable = true;
        velocity.y = speed;
        exists = false;
    }

    public function launch():Void {
      exists = true;
      //x = 64 + Std.int(Math.random() * (FlxG.width - 128));
      switch(Std.random(5)) {
        case 0:
          x = 0;
        case 1:
          x = 64;
        case 2:
          x = 128;
        case 3:
          x = 160;
        case 4:
          x = 96;
      }
    }

    override public function update():Void {
      super.update();
      if (x > FlxG.width - width) {
        x = FlxG.width - width;
      }

      if (exists && y < 0 - height) {
        exists = false;
      }

    }

}