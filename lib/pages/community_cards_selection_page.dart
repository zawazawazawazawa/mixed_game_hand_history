import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';
import '../widgets/cards_input_widget.dart';

const communityCardSelectionRound = ['flop', 'turn', 'river'];

class CommunityCardSelectionPage extends StatefulWidget {
  final String round;

  CommunityCardSelectionPage({required this.round});

  @override
  State<CommunityCardSelectionPage> createState() =>
      _CommunityCardSelectionPageState();
}

class _CommunityCardSelectionPageState
    extends State<CommunityCardSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, child) {
      if (!communityCardSelectionRound.contains(widget.round)) {
        throw Error();
      }

      final int numOfCards = (widget.round == 'flop') ? 3 : 1;

      final String nextBettingRound = (widget.round == 'flop')
          ? 'flopBettingRound'
          : (widget.round == 'turn')
              ? 'turnBettingRound'
              : (widget.round == 'river')
                  ? 'riverBettingRound'
                  : '';

      List<PlayingCard> cards =
          List.filled(numOfCards, PlayingCard(suit: null, rank: null));

      void inputCard({required PlayingCard card, required int index}) {
        setState(() {
          cards[index] = card;
        });
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardsInputWidget(
              numOfCards: numOfCards,
            ),
            ElevatedButton(
              onPressed: () {
                state.updateSelectedIndex(nextBettingRound);
              },
              child: Text('Betting Round'),
            ),
          ],
        ),
      );
    });
  }
}
