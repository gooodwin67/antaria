import 'dart:math';

import 'package:antaria/game/maps/map.dart';
import 'package:antaria/game/maps/map_provider.dart';
import 'package:antaria/game/player/player.dart';
import 'package:antaria/game/player/tap.dart';
import 'package:antaria/game/providers/provider.dart';
import 'package:antaria/game/providers/provider2.dart';
import 'package:antaria/main.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:provider/provider.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class MainGame extends FlameGame with HasGameRef, TapDetector {
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

  ////////////////////////////////////////////////////////////////////////////
  ///
  ///

  @override
  Future<void> onLoad() async {
    super.onLoad();

    playerProvider = context.read<PlayerProvider>();
    playerProvider2 = context.read<PlayerProvider2>();
    mapProvider = context.read<MapProvider>();
    _sizeTile = context.read<MapProvider>().sizeTile;
    _map = context.read<MapProvider>().map;
    _mapComponent = MapComponent(context);

    await add(_mapComponent);
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
    //playerProvider2.playerRun(info, _playerComponent, _map, _sizeTile);
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

    super.update(dt);
  }
}
