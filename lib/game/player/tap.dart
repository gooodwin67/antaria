import 'package:flame/components.dart';

class TapComponent extends SpriteComponent with HasGameRef {
  TapComponent({Vector2? position, Vector2? size})
      : super(position: position, size: size);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('tap.png');

    anchor = Anchor.center;
  }
}
