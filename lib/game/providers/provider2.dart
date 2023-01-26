import 'dart:math';

import 'package:antaria/game/maps/map.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:pathfinding/core/grid.dart';
import 'package:pathfinding/finders/astar.dart';
import 'package:pathfinding/finders/jps.dart';

class RectPaint extends RectangleComponent {
  RectPaint({position}) : super(position: position) {
    size = Vector2(50, 50);
    paint = Paint()..color = Color.fromARGB(146, 54, 244, 63);
  }
}

class RectPaintRed extends RectangleComponent {
  RectPaintRed({position}) : super(position: position) {
    size = Vector2(50, 50);
    paint = Paint()..color = Color.fromARGB(146, 244, 67, 54);
  }
}

class PlayerProvider2 with ChangeNotifier {
  final mark = RectangleComponent(
    size: Vector2(50, 50),
    position: Vector2(100, 200),
    paint: BasicPalette.red.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2,
  );
  List marks = [];

  Vector2 _playerPos = Vector2(2, 2);
  final Vector2 _targetPos = Vector2(3, 3);
  bool isPlayerRun = false;
  bool _isPlayerRunVert = false;
  bool _isPlayerRunHor = false;
  var rectPaint;
  late Component rectPaintRed;
  var targetBlock = Vector2(3, 10);
  late List reachable = [_playerPos];
  bool lookingPath = false;
  Vector2 targetPos = Vector2(0, 0);
  List newMap = [];
  bool playerIsRun = false;
  List path = [];
  int pathLength = 0;
  Vector2 distansePos = Vector2(0, 0);

  Vector2 get playerPos => _playerPos;

////////////////////////////////////////////////////////////////////////

  void tapDown(info, mapComponent, player, myMap, mySizeTile) {
    List map = myMap;
    double sizeTile = mySizeTile;

    if (playerIsRun) {
      print(path);
      path = [];
      print(path);

      playerIsRun = false;
    }

    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (info.eventPosition.game.x < j * sizeTile &&
            info.eventPosition.game.y < i * sizeTile) {
          targetPos = Vector2(j - 1.toDouble(), i - 1.toDouble());
          rectPaint = RectPaint(
              position: Vector2((j - 1) * sizeTile, (i - 1) * sizeTile));
          mapComponent.add(rectPaint);
          i = map.length;
          break;
        }
      }
    }

    pathFind(playerPos, map, mapComponent, sizeTile, player);
  }

  pathFind(playerPos, map, mapComponent, sizeTile, player) {
    //print(playerPos);
    //print(newMap);

    newMap = List.generate(
        map[0].length, (_) => new List.generate(map.length, (index) => 0));

    for (int i = 0; i < map[0].length; i++) {
      for (int j = map.length - 1; j >= 0; j--) {
        if (map[j][i] == 'w') {
          newMap[i][j] = 1;
        } else {
          newMap[i][j] == 0;
        }
      }
    }
    //print(newMap);

    int targetX = (targetPos.x).toInt();
    int targetY = (targetPos.y).toInt();
    int playerX = (_playerPos.x).toInt();
    int playerY = (_playerPos.y).toInt();
    bool isFind = false;

    var grid = Grid(15, 14, newMap);

    path = AStarFinder()
        .findPath(playerY, playerX, targetY, targetX, grid.clone());

    path.forEach((element) {
      rectPaintRed = RectPaintRed(
          position: Vector2((element[1]) * sizeTile, (element[0]) * sizeTile));
      mapComponent.add(rectPaintRed);
    });

    pathLength = path.length;
    path.isNotEmpty ? playerRun(path, map, sizeTile, player) : false;
  }

  void tapUp(Component mapComponent, player, myMap, mySizeTile) async {
    //List map = myMap;
    double sizeTile = mySizeTile;
    //mapComponent.remove(rectPaint);

    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////

  void playerRun(path, map, sizeTile, player) async {
    // int _x = (player.position.x / _sizeTile).toInt();
    // int _y = (player.position.y / _sizeTile).toInt();
    playerIsRun = true;

    int a = 0;

    while (a < pathLength) {
      await Future.delayed(const Duration(milliseconds: 2000), () {})
          .then((value) async {
        _playerPos.x = await path[a][1].toDouble();
        _playerPos.y = await path[a][0].toDouble();

        await player.add(MoveToEffect(
          Vector2(playerPos.x * sizeTile, playerPos.y * sizeTile),
          EffectController(duration: 0.4),
        ));
      });

      a++;
    }
    playerIsRun = false;

    notifyListeners();
  }
}
