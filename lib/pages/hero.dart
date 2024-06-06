import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';
import '../utils/get_active_user_positions.dart';

class HeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, children) {
      List<String> positions =
          getActiveUserPositions(participants: state.participants);

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
            // To be implemented
            // ハンドの選択widgetを出す
            Text('not yet'),
        ],
      );
    });
  }
}
