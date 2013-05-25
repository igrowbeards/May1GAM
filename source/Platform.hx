package ;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

class Platform extends FlxSprite {

    public var speed:Int = 20;
    private var platformStartX:Int;
    private var platformWidth:Int;

    public function new() {
        super(platformStartX, 0);
        switch(Std.random(3)) {
          case 0:
            //makeGraphic(64,10,0xffff00ff);
            loadGraphic("assets/candy-64.png");
          case 1:
            //makeGraphic(32,10,0xffff00ff);
            loadGraphic("assets/candy-32.png");
          case 2:
            //makeGraphic(48,10,0xffff00ff);
            loadGraphic("assets/candy-48.png");
        }
        immovable = true;
        velocity.y = speed;
        exists = false;
    }

    public function launch():Void {
      exists = true;
      //x = 64 + Std.int(Math.random() * (FlxG.width - 128));
      y = -10;
      switch(Std.random(10)) {
        case 0:
          x = 0;
        case 1,  2:
          switch(Std.random(3)) {
            case 0:
              x = 64 + Std.random(33);
            case 1:
              x = 64 - Std.random(33);
            case 2:
              x = 64;
          }
        case 3, 4:
          switch(Std.random(3)) {
            case 0:
              x = 128 + Std.random(33);
            case 1:
              x = 128 - Std.random(33);
            case 2:
              x = 128;
          }
        case 5, 6:
          switch(Std.random(3)) {
            case 0:
              x = 160 + Std.random(33);
            case 1:
              x = 160 - Std.random(33);
            case 2:
              x = 160;
          }
        case 7, 8:
          switch(Std.random(3)) {
            case 0:
              x = 96 + Std.random(33);
            case 1:
              x = 96 - Std.random(33);
            case 2:
              x = 96;
          }
        case 9:
          x = FlxG.width - width;
      }
    }

    override public function update():Void {
      velocity.y = speed * Registry.gameSpeed;
      super.update();
      if (x > FlxG.width - width) {
        x = FlxG.width - width;
      }

      if (exists && y > FlxG.height) {
        launch();
      }

    }

}