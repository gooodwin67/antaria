import 'package:antaria/game/game.dart';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyHomePage());
}

final game = MainGame();

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Stack(
          children: [
            GameWidget(
              game: game,
              overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                'mainMenuOverlay': (context, game) => MainMenuOverlay(game)
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenuOverlay extends StatelessWidget {
  const MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                (game as MainGame).startGame();
              },
              child: Text('Start Game'),
            ),
          ),
        ],
      ),
    );
  }
}

class GameOverlay extends StatelessWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [],
      ),
    );
  }
}
