import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app_state.dart';

class PreflopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, child) {
      List<String> positions = ['BB', 'SB', 'BTN', 'CO', 'HJ', 'LJ', 'UTG'];

      if (state.participants == 8) {
        positions.insert(6, 'UTG+1');
      } else if (state.participants == 9) {
        positions.insertAll(6, ['UTG+2', 'UTG+1']);
      }

      return Column(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //children: List.generate(state.participants, (index) {
          //    return RadioAction(positionName: positions[index]);
          //  },
          //).reversed.toList()
          children: <Widget>[RadioAction(positions: positions)],
        ),
        ElevatedButton(
          onPressed: () {
            // blindページへ遷移
            state.updateSelectedIndex('participants');
          },
          child: Text('Blindに戻る'),
        ),
      ]);
    });
  }
}

class RadioAction extends StatefulWidget {
  final List<String> positions;

  RadioAction({required this.positions});

  @override
  _RadioActionState createState() => _RadioActionState();
}

class _RadioActionState extends State<RadioAction> {
  String? _selectedAction = null;
  int _lastHandled = 0;

  @override
  void initState() {
    super.initState();
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedAction = value;
      _lastHandled = _lastHandled + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<Widget>.generate(widget.positions.length, (index) {
      return Visibility(
        //mainAxisAlignment: MainAxisAlignment.center,
        visible: index <= _lastHandled,
        child: Row(
          children: [
            Text(widget.positions[widget.positions.length - index - 1]),
            Expanded(
              child: ListTile(
                title: Text('Raise'),
                leading: Radio<String>(
                  value: 'raise',
                  groupValue: _selectedAction,
                  onChanged: _handleRadioValueChange,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('Call'),
                leading: Radio<String>(
                  value: 'call',
                  groupValue: _selectedAction,
                  onChanged: _handleRadioValueChange,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('Fold'),
                leading: Radio<String>(
                  value: 'fold',
                  groupValue: _selectedAction,
                  onChanged: _handleRadioValueChange,
                ),
              ),
            )
          ],
        ),
      );
    }));
  }
}
