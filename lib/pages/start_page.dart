import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, child) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // BigBlindページへ遷移
                    // state.updateSelectedIndex('blind');

                    // TODO: debug用 preflop pageへ遷移
                    state.updateSelectedIndex('preflop');
                  },
                  child: Text('Start'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
