import 'package:flame/components.dart';

class PlayerComponent extends SpriteComponent with HasGameRef {
  PlayerComponent({
    Vector2? position,
  }) : super(position: Vector2(100, 100));
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    size = Vector2(40, 40);
  }
}
