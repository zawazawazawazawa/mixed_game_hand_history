import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../my_app_state.dart';

class CardsInputWidget extends StatefulWidget {
  final int numOfCards;

  CardsInputWidget({required this.numOfCards});

  @override
  _CardsInputWidgetState createState() => _CardsInputWidgetState();
}

class _CardsInputWidgetState extends State<CardsInputWidget> {
  late List<PlayingCard> cards;

  @override
  void initState() {
    super.initState();
    cards = List.filled(widget.numOfCards, PlayingCard(suit: null, rank: null));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, children) {
      void inputCard({required PlayingCard card, required int index}) {
        setState(() {
          cards[index] = card;
        });
      }

      return Column(
        children: [
          SizedBox(height: 21),
          Text("Input Cards"),
          Column(
            children: List.generate(widget.numOfCards, (index) {
              return (cards[index].suit == null && cards[index].rank == null)
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
                      SizedBox(width: 21),
                      Text("card: ${cards[index].rank}"),
                    ]);
            }),
          ),
        ],
      );
    });
  }
}

void showCardInputDialog(
    {required BuildContext context,
    required void Function({required PlayingCard card}) onSubmit}) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height - 40,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: CardInputDialog(onSubmit: onSubmit)));
      });
}

class CardInputDialog extends StatefulWidget {
  final void Function({required PlayingCard card}) onSubmit;

  CardInputDialog({required this.onSubmit});

  @override
  State<CardInputDialog> createState() => _CardInputDialogState();
}

class _CardInputDialogState extends State<CardInputDialog> {
  PlayingCard card = PlayingCard(suit: null, rank: null);

  @override
  void initState() {
    super.initState();
  }

  void onTapSuitOrRank({String? suit, String? rank}) {
    setState(() {
      card = card.copyWith(rank: rank, suit: suit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("suit: ${card.suit}"),
          Text("rank: ${card.rank}"),
          if (card.suit == null)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: InkWell(
                          onTap: () {
                            onTapSuitOrRank(suit: 'spade');
                          },
                          child: SvgPicture.asset(
                            'images/spade.svg',
                            width: 100,
                            height: 100,
                          )),
                    ),
                    Card(
                      child: InkWell(
                          onTap: () {
                            onTapSuitOrRank(suit: 'heart');
                          },
                          child: SvgPicture.asset(
                            'images/heart.svg',
                            width: 100,
                            height: 100,
                          )),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: InkWell(
                          onTap: () {
                            onTapSuitOrRank(suit: 'diamond');
                          },
                          child: SvgPicture.asset(
                            'images/diamond.svg',
                            width: 100,
                            height: 100,
                          )),
                    ),
                    Card(
                      child: InkWell(
                          onTap: () {
                            onTapSuitOrRank(suit: 'club');
                          },
                          child: SvgPicture.asset(
                            'images/club.svg',
                            width: 100,
                            height: 100,
                          )),
                    )
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Card(
                    child: InkWell(
                        onTap: () {
                          onTapSuitOrRank(suit: '?');
                        },
                        child: SvgPicture.asset(
                          'images/question.svg',
                          width: 100,
                          height: 100,
                        )),
                  )
                ])
              ],
            ),
          if (card.suit != null && card.rank == null)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '2');
                      },
                      child: Card(
                        child: Text('2'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '3');
                      },
                      child: Card(
                        child: Text('3'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '4');
                      },
                      child: Card(
                        child: Text('4'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '5');
                      },
                      child: Card(
                        child: Text('5'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '6');
                      },
                      child: Card(
                        child: Text('6'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '7');
                      },
                      child: Card(
                        child: Text('7'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '8');
                      },
                      child: Card(
                        child: Text('8'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '9');
                      },
                      child: Card(
                        child: Text('9'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: 'T');
                      },
                      child: Card(
                        child: Text('T'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: 'J');
                      },
                      child: Card(
                        child: Text('J'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: 'Q');
                      },
                      child: Card(
                        child: Text('Q'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: 'K');
                      },
                      child: Card(
                        child: Text('K'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: 'A');
                      },
                      child: Card(
                        child: Text('A'),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        onTapSuitOrRank(rank: '?');
                      },
                      child: Card(
                        child: Text('?'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onSubmit(card: card);
                  Navigator.of(context).pop();
                },
                child: Text('Confirm'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
