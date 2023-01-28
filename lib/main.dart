import 'package:antaria/game/game.dart';
import 'package:antaria/game/maps/levels/level1.dart';
import 'package:antaria/game/maps/map_provider.dart';
import 'package:antaria/game/providers/test_provider.dart';
import 'package:antaria/game/providers/provider2.dart';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => {
      WidgetsFlutterBinding.ensureInitialized(),
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PlayerProvider2()),
          ChangeNotifierProvider(create: (_) => MapProvider()),
          ChangeNotifierProvider(create: (_) => Level1Provider()),
          ChangeNotifierProvider(create: (_) => TestProvider()),
        ],
        child: MyHomePage(),
      ))
    };

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final game = MainGame(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GameWidget(
                game: game,
                overlayBuilderMap: <String,
                    Widget Function(BuildContext, Game)>{
                  'mainMenuOverlay': (context, game) =>
                      MainMenuOverlay(context, game)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainMenuOverlay extends StatelessWidget {
  const MainMenuOverlay(this.context, this.game, {super.key});

  final Game game;
  final context;

  @override
  Widget build(BuildContext context) {
    //(game as MainGame).startGame(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {},
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
