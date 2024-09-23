import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/blind_page.dart';
import 'pages/hero_page.dart';
import 'pages/participants_page.dart';
import 'pages/betting_round_page.dart';
import 'pages/start_page.dart';
import 'pages/community_cards_selection_page.dart';

import 'my_app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, child) {
      return LayoutBuilder(builder: (context, constraints) {
        var selectedIndex = state.selectedIndex;
        Widget page;
        switch (selectedIndex) {
          case 'home':
            page = StartPage();
            break;
          case 'blind':
            page = BlindPage();
            break;
          case 'participants':
            page = ParticipantsPage();
            break;
          case 'preflop':
            List<String> positions = state.getPreflopActiveUserPositions();

            page = BettingRoundPage(
              bettingRound: 'preflop',
              positions: positions,
            );
            break;
          case 'hero':
            page = HeroPage();
            break;
          case 'flop':
            page = CommunityCardSelectionPage(
              round: 'flop'
              );
            break;
          case 'flopBettingRound':
            List<String> positions = state.getFlopActiveUserPositions();
            page = BettingRoundPage(
              bettingRound: 'flop',
              positions: positions,
            );
            break;
          default:
            throw UnimplementedError('no widget for $selectedIndex');
        }
        return Scaffold(
          body: Row(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
