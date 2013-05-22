package ;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

class Child extends FlxSprite {

    public var speed:Int = 80;
    private var platformStartX:Int;
    private var platformWidth:Int;

    public function new() {
        super(0, 0);
        switch(Std.random(0)) {
          case 0:
            makeGraphic(32,32,0xffffffff);
          case 1:
            //makeGraphic(32,10,0xffff00ff);
          case 2:
            //makeGraphic(48,10,0xffff00ff);
        }
        velocity.y = speed;
        exists = false;
    }

    public function launch():Void {
      exists = true;
      y = 0;
      x = Std.random(Std.int(FlxG.width - width));
    }

    override public function update():Void {
      velocity.y = speed * Registry.gameSpeed;
      super.update();
      if (x > FlxG.width - width) {
        x = FlxG.width - width;
      }

      if (exists && y > FlxG.height) {
        exists = false;
      }

    }

}