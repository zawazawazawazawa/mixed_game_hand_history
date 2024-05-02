import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app_state.dart';

class UnexpectedPositionError extends Error {
  final String message;
  UnexpectedPositionError(this.message);

  @override
  String toString() => message;
}

class PreflopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, child) {
      List<String> positions = ['BB', 'SB', 'BTN', 'CO', 'HJ', 'LJ', 'UTG'];

      if (state.participants == 8) {
        positions.insert(6, 'UTG+1');
      } else if (state.participants == 9) {
        positions.insertAll(6, ['UTG+2', 'UTG+1']);
      } else {
        positions = positions.sublist(0, state.participants);
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
  late List<String> _positions;

  String? _utgSelectedAction = null;
  String? _utg1SelectedAction = null;
  String? _utg2SelectedAction = null;
  String? _ljSelectedAction = null;
  String? _hjSelectedAction = null;
  String? _coSelectedAction = null;
  String? _btnSelectedAction = null;
  String? _sbSelectedAction = null;
  String? _bbSelectedAction = null;

  int _lastHandled = 0;

  @override
  void initState() {
    super.initState();
    _positions = widget.positions;
  }

  String? getActionStateFromIndex(int index) {
    switch (_positions[_positions.length - index - 1]) {
      case 'BB':
        return _bbSelectedAction;
      case 'SB':
        return _sbSelectedAction;
      case 'BTN':
        return _btnSelectedAction;
      case 'CO':
        return _coSelectedAction;
      case 'HJ':
        return _hjSelectedAction;
      case 'LJ':
        return _ljSelectedAction;
      case 'UTG+2':
        return _utg2SelectedAction;
      case 'UTG+1':
        return _utg1SelectedAction;
      case 'UTG':
        return _utgSelectedAction;
      default:
        throw UnexpectedPositionError(
            'unexpected position name is detected: ${_positions[_positions.length - _lastHandled - 1]}');
    }
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      switch (_positions[_positions.length - _lastHandled - 1]) {
        case 'BB':
          _bbSelectedAction = value;

          break;
        case 'SB':
          _sbSelectedAction = value;

          break;
        case 'BTN':
          _btnSelectedAction = value;

          break;
        case 'CO':
          _coSelectedAction = value;

          break;
        case 'HJ':
          _hjSelectedAction = value;

          break;
        case 'LJ':
          _ljSelectedAction = value;

          break;
        case 'UTG+2':
          _utg2SelectedAction = value;

          break;
        case 'UTG+1':
          _utg1SelectedAction = value;

          break;
        case 'UTG':
          _utgSelectedAction = value;

          break;
        default:
          throw UnexpectedPositionError(
              'unexpected position name is detected: ${_positions[_positions.length - _lastHandled - 1]}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<Widget>.generate(widget.positions.length, (index) {
      return Visibility(
        visible: index <= _lastHandled,
        child: Row(
          children: [
            Text(widget.positions[widget.positions.length - index - 1]),
            Expanded(
              child: ListTile(
                title: Text('Raise'),
                leading: Radio<String>(
                  value: 'raise',
                  groupValue: getActionStateFromIndex(index),
                  onChanged: _handleRadioValueChange,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('Call'),
                leading: Radio<String>(
                  value: 'call',
                  groupValue: getActionStateFromIndex(index),
                  onChanged: _handleRadioValueChange,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('Fold'),
                leading: Radio<String>(
                  value: 'fold',
                  groupValue: getActionStateFromIndex(),
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
