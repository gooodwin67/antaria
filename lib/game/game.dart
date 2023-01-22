import 'dart:math';

import 'package:antaria/game/maps/map.dart';
import 'package:antaria/game/maps/map_provider.dart';
import 'package:antaria/game/player/player.dart';
import 'package:antaria/game/player/tap.dart';
import 'package:antaria/game/providers/provider.dart';
import 'package:antaria/game/providers/provider2.dart';
import 'package:antaria/main.dart';
import 'package:flame/components.dart';
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

  ////////////////////////////////////////////////////////////////////////////
  ///
  ///

  @override
  Future<void> onLoad() async {
    super.onLoad();

    playerProvider = context.read<PlayerProvider>();
    playerProvider2 = context.read<PlayerProvider2>();
    mapProvider = context.read<MapProvider>();

    await add(MapComponent(context));
    await add(_playerComponent);
    _playerComponent.position = playerProvider2.playerPos;
    await add(_tapComponent);

    camera.followComponent(_playerComponent);
    camera.worldBounds =
        Rect.fromLTRB(0, 0, mapProvider.sizeMap.x, mapProvider.sizeMap.y);
  }

  ////////////////////////////////////////////////////////////////////////////

  @override
  bool onTapDown(TapDownInfo info) {
    //playerProvider.tapDown(info, _playerComponent, _tapComponent);
    marks =
        playerProvider2.addMark(info, mapProvider.map, mapProvider.sizeTile);
    // marks.forEach((e) {
    //   add(e);
    // });
    //add(mark);

    // playerProvider2.playerStartRun(
    //     info, _playerComponent, mapProvider.map, mapProvider.sizeTile);

    playerProvider2.findPath(
        info, _playerComponent, mapProvider.map, mapProvider.sizeTile);

    return true;
  }

  bool onTapUp(TapUpInfo info) {
    //remove(mark);
    return true;
  }

  bool onTapCancel() {
    //remove(mark);
    return true;
  }

  ////////////////////////////////////////////////////////////////////////////

  @override
  void update(double dt) {
    super.update(dt);

    _playerComponent.position += context.read<PlayerProvider2>().playerSpeed;
    context.read<PlayerProvider2>().playerMove(_playerComponent);

    //playerProvider.playerGoToTap(_playerComponent);
  }
}
