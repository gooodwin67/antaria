import 'package:antaria/game/maps/map.dart';
import 'package:antaria/game/maps/map_provider.dart';
import 'package:antaria/game/player/player.dart';
import 'package:antaria/game/player/tap.dart';
import 'package:antaria/game/providers/test_provider.dart';
import 'package:antaria/game/providers/provider2.dart';
import 'package:antaria/main.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:provider/provider.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

// TextComponent(
//               position = Vector2(j * 50, i * 50),
//               text: '$i---$j',
//               textRenderer: TextPaint(
//                   style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))));
//         }

class MainGame extends FlameGame
    with HasGameRef, TapDetector, HasCollisionDetection {
  MainGame(this.context, {super.children});

  BuildContext context;

  TapComponent _tapComponent = TapComponent();
  PlayerComponent _playerComponent = PlayerComponent();
  var playerProvider;
  var playerProvider2;
  var mapProvider;
  var marks;
  var _mapComponent;
  double _sizeTile = 50;
  List _map = [];

  var testText = TextComponent();

  ////////////////////////////////////////////////////////////////////////////
  ///
  ///

  @override
  Future<void> onLoad() async {
    super.onLoad();

    playerProvider2 = context.read<PlayerProvider2>();
    mapProvider = context.read<MapProvider>();
    _sizeTile = context.read<MapProvider>().sizeTile;
    _map = context.read<MapProvider>().map;
    _mapComponent = MapComponent(context);
    testText = TextComponent(
      text: context.read<TestProvider>().testText,
      position: Vector2(0, 0),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(style: TextStyle(fontSize: 30)),
    );

    await add(_mapComponent);
    await add(testText);

    await add(_playerComponent);
    _playerComponent.position = Vector2(playerProvider2.playerPos.x * _sizeTile,
        playerProvider2.playerPos.y * _sizeTile);

    camera.followComponent(_playerComponent);
    camera.worldBounds =
        Rect.fromLTRB(0, 0, mapProvider.sizeMap.x, mapProvider.sizeMap.y);
  }

  ////////////////////////////////////////////////////////////////////////////

  @override
  bool onTapDown(TapDownInfo info) {
    playerProvider2.tapDown(
        info, _mapComponent, _playerComponent, _map, _sizeTile);

    return true;
  }

  bool onTapUp(TapUpInfo info) {
    playerProvider2.tapUp(_mapComponent, _playerComponent, _map, _sizeTile);

    return true;
  }

  bool onTapCancel() {
    playerProvider2.tapUp(_mapComponent, _playerComponent, _map, _sizeTile);
    return true;
  }

  ////////////////////////////////////////////////////////////////////////////

  @override
  void update(double dt) {
    // _playerComponent.position = Vector2(playerProvider2.playerPos.x * _sizeTile,
    //     playerProvider2.playerPos.y * _sizeTile);

    //_playerComponent.add(effect);
    context.read<TestProvider>().updateText('asdasd');

    super.update(dt);
  }
}
