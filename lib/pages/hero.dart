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
        children: List<Widget>.generate(positions.length, (int index) {
          return Text(positions[index]);
        }).reversed.toList(),
      );
    });
  }
}
