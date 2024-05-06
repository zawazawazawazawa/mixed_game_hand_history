import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app_state.dart';
import 'number_input_field.dart';

class ParticipantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
        builder: (context, state, children) => Column(children: [
              Text('Small Blind: ${state.smallBlind}'),
              Text('Big Blind: ${state.bigBlind}'),
              Text('Ante: ${state.ante}'),
              Text('参加人数'),
              NumberInputField(
                  label: '参加人数',
                  attribute: 'participants',
                  handler: state.updateParticipants),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      state.updateParticipants(state.participants - 1);
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1'),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {
                      state.updateParticipants(state.participants + 1);
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // preflopページへ遷移
                  state.updateSelectedIndex('preflop');
                },
                child: Text('preflopを入力'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // blindページへ遷移
                  state.updateSelectedIndex('blind');
                },
                child: Text('Blindに戻る'),
              ),
            ]));
  }
}
