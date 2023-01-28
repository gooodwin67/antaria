import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerComponent extends SpriteComponent
    with HasGameRef, CollisionCallbacks {
  late RectangleHitbox hitbox;
  PlayerComponent({
    Vector2? position,
  }) : super();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    size = Vector2(50, 50);

    final defaultPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    hitbox.paint.color = Colors.red;
  }
}
