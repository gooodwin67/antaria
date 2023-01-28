import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MapProvider extends ChangeNotifier {
  final List _map = [
    ['w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w'],
    ['w', 'f', 'f', 'f', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'w', 'w', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'f', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'f', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'f', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'w', 'w', 'w', 'w', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'f', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'w', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'w', 'f', 'w', 'w', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'f', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'f', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'w', 'f', 'f', 'w', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'w'],
    ['w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w'],
  ];

  final double _sizeTile = 50;

  late final Vector2 _sizeMap = Vector2((_map[0].length * _sizeTile).toDouble(),
      (_map.length * _sizeTile).toDouble());

  List get map => _map;
  double get sizeTile => _sizeTile;
  Vector2 get sizeMap => _sizeMap;
}
