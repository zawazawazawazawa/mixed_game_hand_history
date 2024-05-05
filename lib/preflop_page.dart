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

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, children) {
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

      void _handleRadioValueChange({String? value, required int index}) {
        String position = _positions[_positions.length - index - 1];

        setState(() {
          switch (position) {
            case 'BB':
              _bbSelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _bbSelectedAction,
                  amount: 0);

              break;
            case 'SB':
              _sbSelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _sbSelectedAction,
                  amount: 0);

              break;
            case 'BTN':
              _btnSelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _btnSelectedAction,
                  amount: 0);

              break;
            case 'CO':
              _coSelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _coSelectedAction,
                  amount: 0);

              break;
            case 'HJ':
              _hjSelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _hjSelectedAction,
                  amount: 0);

              break;
            case 'LJ':
              _ljSelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _ljSelectedAction,
                  amount: 0);

              break;
            case 'UTG+2':
              _utg2SelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _utg2SelectedAction,
                  amount: 0);

              break;
            case 'UTG+1':
              _utg1SelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _utg1SelectedAction,
                  amount: 0);

              break;
            case 'UTG':
              _utgSelectedAction = value;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _utgSelectedAction,
                  amount: 0);

              break;
            default:
              throw UnexpectedPositionError(
                  'unexpected position name is detected: $position');
          }

          if (_positions.length > _lastHandled + 1) {
            _lastHandled += 1;
          }
        });
      }

      return Column(
          children: List<Widget>.generate(_positions.length, (int index) {
        return Visibility(
          visible: index <= _lastHandled,
          child: Row(
            children: [
              Text(widget.positions[_positions.length - index - 1]),
              Expanded(
                child: ListTile(
                  title: Text('Raise'),
                  leading: Radio<String>(
                    value: 'raise',
                    groupValue: getActionStateFromIndex(index),
                    onChanged: (String? value) {
                      if (index == _lastHandled && value != null) {
                        _handleRadioValueChange(value: value, index: index);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Call'),
                  leading: Radio<String>(
                    value: 'call',
                    groupValue: getActionStateFromIndex(index),
                    onChanged: (String? value) {
                      if (index == _lastHandled && value != null) {
                        _handleRadioValueChange(value: value, index: index);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Fold'),
                  leading: Radio<String>(
                    value: 'fold',
                    groupValue: getActionStateFromIndex(index),
                    onChanged: (String? value) {
                      if (index == _lastHandled && value != null) {
                        _handleRadioValueChange(value: value, index: index);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        );
      }));
    });
  }
}
