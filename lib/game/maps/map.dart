import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List map = [
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
];

Vector2 sizeMap =
    Vector2((map[0].length * 50).toDouble(), (map.length * 50).toDouble());

class MapComponent extends PositionComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (map[i][j] == 1) {
          await add(StoneComponent(position: Vector2(j * 50, i * 50)));
        } else if (map[i][j] == 0) {
          await add(GrassComponent(position: Vector2(j * 50, i * 50)));
        }
      }
    }
  }
}

class GrassComponent extends SpriteComponent with HasGameRef {
  GrassComponent({Vector2? position}) : super(position: position);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('grass.png');
    size = Vector2(50, 50);
  }
}

class StoneComponent extends SpriteComponent with HasGameRef {
  StoneComponent({Vector2? position}) : super(position: position);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('stone.png');
    size = Vector2(50, 50);
  }
}
