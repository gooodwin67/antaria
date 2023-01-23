import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class PlayerComponent extends SpriteComponent with HasGameRef {
  PlayerComponent({
    Vector2? position,
  }) : super();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    size = Vector2(50, 50);
  }
}
