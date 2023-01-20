import 'dart:math';

import 'package:antaria/game/maps/map.dart';
import 'package:antaria/game/player/player.dart';
import 'package:antaria/game/player/tap.dart';
import 'package:flame/components.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flutter/material.dart';

double speed = 0.1;
double sinus = 0;
double cosinus = 0;
var targetPos = Vector2(0, 0);
double distanceToPos = 0;
double x1 = 0;
double x2 = 0;
double y1 = 0;
double y2 = 0;

enum GameState { intro, playing }

class MainGame extends FlameGame with HasGameRef, TapDetector {
  MainGame({super.children});

  GameState state = GameState.intro;

  TapComponent _tapComponent = TapComponent();
  PlayerComponent _playerComponent = PlayerComponent();

  bool get isPlaying => state == GameState.playing;
  bool get isIntro => state == GameState.intro;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(MapComponent());
    await add(_playerComponent);
    await add(_tapComponent);

    camera.followComponent(_playerComponent);
    camera.worldBounds = Rect.fromLTRB(0, 0, sizeMap.x, sizeMap.y);

    overlays.add('mainMenuOverlay');
  }

  @override
  bool onTapDown(TapDownInfo info) {
    x1 = _playerComponent.position.x + _playerComponent.size.x / 2;
    y1 = _playerComponent.position.y + _playerComponent.size.y / 2;
    x2 = info.eventPosition.game.x;
    y2 = info.eventPosition.game.y;
    _tapComponent.position = Vector2(x2, y2);
    _tapComponent.size = Vector2.all(30);

    var playerPos = Vector2(x1, y1);
    targetPos = Vector2(x2, y2);

    var angle = atan2(targetPos.y - playerPos.y, targetPos.x - playerPos.x);

    var per_Frame_Distance = 2;
    sinus = sin(angle) * per_Frame_Distance;
    cosinus = cos(angle) * per_Frame_Distance;

    return true;
  }

  bool onTapUp(TapUpInfo info) {
    _tapComponent.size = Vector2.all(0);
    return true;
  }

  bool onTapCancel() {
    _tapComponent.size = Vector2.all(0);
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    x1 = _playerComponent.position.x + _playerComponent.size.x / 2;
    y1 = _playerComponent.position.y + _playerComponent.size.y / 2;
    distanceToPos = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    if (distanceToPos > 10) {
      _playerComponent.position.x += cosinus;
      _playerComponent.position.y += sinus;
      print(distanceToPos);
    }
  }

  void startGame() {
    state = GameState.playing;

    overlays.remove('mainMenuOverlay');
  }
}
