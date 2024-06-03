import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';

class FlopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, child) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Small Blind: ${state.smallBlind}'),
            Text('Big Blind: ${state.bigBlind}'),
            Text('Ante: ${state.ante}'),
            Text('${state.participants} handed'),
            state.preflop.length > 0
                ? Column(
                    children: state.preflop.map((e) {
                    return Text(
                        "round: ${e.round}, position: ${e.position}, action: ${e.action}, amount: ${e.amount}");
                  }).toList())
                : Container(),
          ],
        ),
      );
    });
  }
}
