import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';
import '../utils/show_card_input_dialog.dart';

class HeroPage extends StatefulWidget {
  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  List<PlayingCard> cards = List.filled(4, PlayingCard(suit: null, rank: null));

  void inputCard({required PlayingCard card, required int index}) {
    setState(() {
      cards[index] = card;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, children) {
      List<String> positions = state.getPreflopActiveUserPositions();

      return Column(
        children: [
          Column(
            children: List<Widget>.generate(positions.length, (int index) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      state.updateHeroPosition(position: positions[index]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (state.heroPosition == positions[index])
                          ? Colors.orange
                          : Colors.blue,
                    ),
                    child: Text(positions[index]),
                  ),
                ],
              );
            }).reversed.toList(),
          ),
          if (state.heroPosition != '')
            Column(
              children: [
                SizedBox(height: 20),
                Text("Hand"),
                Column(
                  children: List.generate(4, (index) {
                    return (cards[index].suit == null &&
                            cards[index].rank == null)
                        ? InkWell(
                            child: Card(
                              child: Column(
                                children: [
                                  Text("Card$index"),
                                ],
                              ),
                            ),
                            onTap: () {
                              showCardInputDialog(
                                  context: context,
                                  onSubmit: ({required PlayingCard card}) {
                                    inputCard(card: card, index: index);
                                  });
                            },
                          )
                        : Column(children: [
                            Text("suit: ${cards[index].suit}"),
                            SizedBox(width: 20),
                            Text("card: ${cards[index].rank}"),
                          ]);
                  }),
                ),
              ],
            ),
        ],
      );
    });
  }
}
