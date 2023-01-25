import 'package:antaria/game/maps/map_provider.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapComponent extends PositionComponent with HasGameRef {
  MapComponent(this.context, {super.children});

  BuildContext context;

  @override
  Future<void> onLoad() async {
    List map = context.read<MapProvider>().map;

    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (map[i][j] == 'w') {
          await add(StoneComponent(position: Vector2(j * 50, i * 50)));
        } else if (map[i][j] == 'f') {
          await add(GrassComponent(position: Vector2(j * 50, i * 50)));
          await add(TextComponent(
              position: Vector2(j * 50, i * 50),
              text: '$i---$j',
              textRenderer: TextPaint(
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))));
        }
      }
    }
  }
}

class GrassComponent extends SpriteComponent with HasGameRef {
  GrassComponent({Vector2? position, int}) : super(position: position);
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
