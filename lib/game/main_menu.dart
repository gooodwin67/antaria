import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class MainMenuGame extends FlameGame with HasGameRef, TapDetector {
  MainMenuGame({super.children});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    overlays.add('mainMenuOverlay');
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
