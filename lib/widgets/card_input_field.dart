import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../my_app_state.dart';

class CardInputField extends StatefulWidget {
  final PlayingCard card;
  final void handler;

  CardInputField({required this.card, required this.handler});

  @override
  State<CardInputField> createState() => _CardInputFieldState();
}

class _CardInputFieldState extends State<CardInputField> {
  late PlayingCard card;
  late void handler;

  @override
  void initState() {
    super.initState();
    card = widget.card;
    handler = widget.handler;
  }

  @override
  Widget build(BuildContext context) {
    void onSpadeImageTap() {
      setState(() {
        print(card.suit);
        print(card.rank);
        card = card.copyWith(suit: 'spade');
      });
    }

    void onHeartImageTap({required PlayingCard card}) {
      setState(() {
        card.suit = 'heart';
        print(card.suit);
        print(card.rank);
      });
    }

    void onDiamondImageTap({required PlayingCard card}) {
      setState(() {
        card.suit = 'diamond';
        print(card.suit);
        print(card.rank);
      });
    }

    void onClubImageTap({required PlayingCard card}) {
      setState(() {
        card.suit = 'club';
        print(card.suit);
        print(card.rank);
      });
    }

    void onUndefinedImageTap({required PlayingCard card}) {
      setState(() {
        card.suit = 'undefined';
        print(card.suit);
        print(card.rank);
      });
    }

    void onRankTap({required String rank}) {
      setState(() {
        print(card.suit);
        print(card.rank);
        card = card.copyWith(rank: rank);
      });
    }

    void showCardInputDialog(BuildContext context) {
      showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(card.suit ?? 'suit is null'),
                          Text(card.rank ?? 'rank is null'),
                          if (card.suit == null)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      child: InkWell(
                                          onTap: () {
                                            onSpadeImageTap();
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
                                            onHeartImageTap(card: widget.card);
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
                                            onDiamondImageTap(
                                                card: widget.card);
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
                                            onClubImageTap(card: widget.card);
                                          },
                                          child: SvgPicture.asset(
                                            'images/club.svg',
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
                                              onUndefinedImageTap(
                                                  card: widget.card);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: '2');
                                      },
                                      child: Card(
                                        child: Text('2'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: '3');
                                      },
                                      child: Card(
                                        child: Text('3'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: '4');
                                      },
                                      child: Card(
                                        child: Text('4'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: '5');
                                      },
                                      child: Card(
                                        child: Text('5'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: '6');
                                      },
                                      child: Card(
                                        child: Text('6'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: '7');
                                      },
                                      child: Card(
                                        child: Text('7'),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: '8');
                                      },
                                      child: Card(
                                        child: Text('8'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: '9');
                                      },
                                      child: Card(
                                        child: Text('9'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: 'T');
                                      },
                                      child: Card(
                                        child: Text('T'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: 'J');
                                      },
                                      child: Card(
                                        child: Text('J'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: 'Q');
                                      },
                                      child: Card(
                                        child: Text('Q'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: 'K');
                                      },
                                      child: Card(
                                        child: Text('K'),
                                      ),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        onRankTap(rank: 'A');
                                      },
                                      child: Card(
                                        child: Text('A'),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    )));
          });
    }

    return Consumer<MyAppState>(builder: (context, state, child) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () => showCardInputDialog(context),
            child: Text('Input the Card'),
          ),
          //if (card.suit == null)
          //  Column(
          //    children: [
          //      Row(
          //        mainAxisAlignment: MainAxisAlignment.center,
          //        children: [
          //          InkWell(
          //              onTap: () {
          //                onSpadeImageTap();
          //              },
          //              child: SvgPicture.asset(
          //                'images/spade.svg',
          //                width: 150,
          //                height: 150,
          //              )),
          //          InkWell(
          //              onTap: () {
          //                onHeartImageTap(card: widget.card);
          //              },
          //              child: SvgPicture.asset(
          //                'images/heart.svg',
          //                width: 150,
          //                height: 150,
          //              ))
          //        ],
          //      ),
          //      Row(
          //        mainAxisAlignment: MainAxisAlignment.center,
          //        children: [
          //          InkWell(
          //              onTap: () {
          //                onDiamondImageTap(card: widget.card);
          //              },
          //              child: SvgPicture.asset(
          //                'images/diamond.svg',
          //                width: 150,
          //                height: 150,
          //              )),
          //          InkWell(
          //              onTap: () {
          //                onClubImageTap(card: widget.card);
          //              },
          //              child: SvgPicture.asset(
          //                'images/club.svg',
          //                width: 150,
          //                height: 150,
          //              ))
          //        ],
          //      ),
          //      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //        InkWell(
          //            onTap: () {
          //              onUndefinedImageTap(card: widget.card);
          //            },
          //            child: SvgPicture.asset(
          //              'images/question.svg',
          //              width: 150,
          //              height: 150,
          //            ))
          //      ])
          //    ],
          //  ),
          //if (card.suit != null && card.rank == null)
          //  Column(
          //    children: [
          //      Row(
          //        mainAxisAlignment: MainAxisAlignment.spaceAround,
          //        children: [
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: '2');
          //            },
          //            child: Card(
          //              child: Text('2'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: '3');
          //            },
          //            child: Card(
          //              child: Text('3'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: '4');
          //            },
          //            child: Card(
          //              child: Text('4'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: '5');
          //            },
          //            child: Card(
          //              child: Text('5'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: '6');
          //            },
          //            child: Card(
          //              child: Text('6'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: '7');
          //            },
          //            child: Card(
          //              child: Text('7'),
          //            ),
          //          ),
          //        ],
          //      ),
          //      Row(
          //        children: [
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: '8');
          //            },
          //            child: Card(
          //              child: Text('8'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: '9');
          //            },
          //            child: Card(
          //              child: Text('9'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: 'T');
          //            },
          //            child: Card(
          //              child: Text('T'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: 'J');
          //            },
          //            child: Card(
          //              child: Text('J'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: 'Q');
          //            },
          //            child: Card(
          //              child: Text('Q'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: 'K');
          //            },
          //            child: Card(
          //              child: Text('K'),
          //            ),
          //          ),
          //          FloatingActionButton(
          //            onPressed: () {
          //              onRankTap(rank: 'A');
          //            },
          //            child: Card(
          //              child: Text('A'),
          //            ),
          //          ),
          //        ],
          //      )
          //    ],
          //  )
        ],
      );
    });
  }
}
