import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart' hide Route;

void main() {
  runApp(const GamePage());
}

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GameWidget.controlled(gameFactory: MyGame.new);
  }
}

class MyGame extends FlameGame
  with SingleGameInstance, HasTappableComponents
{
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        routes: {
          'splash': Route(SplashScreen.new),
          'ball': Route(BouncingBall.new),
        },
        initialRoute: 'splash',
      )
    );
  }
}

class SplashScreen extends PositionComponent
  with HasGameRef<MyGame>, TapCallbacks
{
  @override
  Future<void> onLoad() async {
    size = gameRef.canvasSize;
    addAll([
      Background(const Color(0xFF202020)),
      TextBoxComponent(
        text: 'The Oyster is your World',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 60,
          )
        ),
        align: Anchor.center,
        size: gameRef.canvasSize,
      ),
      TextBoxComponent(
        text: 'Click anywhere to start...',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
          )
        ),
        align: Anchor.center,
        size: gameRef.canvasSize,
        position: Vector2(0, 50),
      ),
    ]);
  }

  @override
  void onTapDown(TapDownEvent event) {
    gameRef.router.pushNamed('ball');
  }
}

class BouncingBall extends Component {
  @override
  Future<void> onLoad() async {
    add(Ball());
  }
}

class Ball extends Component {
  late PositionComponent pos;
  late int direction;
  final double speed = 600.0;

  @override
  void update(double dt) {
    pos.position.y += speed * dt * direction;
    if (pos.position.y > 400 || pos.position.y < 100) {
      pos.position.y -= speed * dt * direction;
      direction *= -1;
    }
  }

  @override
  Future<void> onLoad() async {
    direction = -1;
    pos = PositionComponent(position: Vector2(100, 200));
    pos.add(
      CircleComponent(radius: 50, anchor: Anchor.center)
    );
    add(pos);
  }
}

class Background extends Component {
  Background(this.color);
  final Color color;

  @override
  void render(Canvas canvas) {
    canvas.drawColor(color, BlendMode.srcATop);
  }
}
