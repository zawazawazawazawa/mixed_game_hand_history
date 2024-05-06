import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

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
        Text('Small Blind: ${state.smallBlind}'),
        Text('Big Blind: ${state.bigBlind}'),
        Text('Ante: ${state.ante}'),
        Text('${state.participants} handed'),
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
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // TO BE IMPLEMENTED
          },
          child: Text('アクションを最初から登録し直す'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            state.updateSelectedIndex('flop');
          },
          child: Text('Flopを入力'),
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

  int _utgRaisedAmount = 0;
  int _utg1RaisedAmount = 0;
  int _utg2RaisedAmount = 0;
  int _ljRaisedAmount = 0;
  int _hjRaisedAmount = 0;
  int _coRaisedAmount = 0;
  int _btnRaisedAmount = 0;
  int _sbRaisedAmount = 0;
  int _bbRaisedAmount = 0;

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

      int getRaisedAmountFromIndex(int index) {
        switch (_positions[_positions.length - index - 1]) {
          case 'BB':
            return _bbRaisedAmount;
          case 'SB':
            return _sbRaisedAmount;
          case 'BTN':
            return _btnRaisedAmount;
          case 'CO':
            return _coRaisedAmount;
          case 'HJ':
            return _hjRaisedAmount;
          case 'LJ':
            return _ljRaisedAmount;
          case 'UTG+2':
            return _utg2RaisedAmount;
          case 'UTG+1':
            return _utg1RaisedAmount;
          case 'UTG':
            return _utgRaisedAmount;
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
              // RadioButtonがraiseに切り替わったタイミングではpreflopアクションを記録しない
              // Raise額が入力されたタイミングで行なう
              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _bbSelectedAction,
                    amount: _bbRaisedAmount);
              }
              break;

            case 'SB':
              _sbSelectedAction = value;
              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _sbSelectedAction,
                    amount: _sbRaisedAmount);
              }

              break;
            case 'BTN':
              _btnSelectedAction = value;
              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _btnSelectedAction,
                    amount: _btnRaisedAmount);
              }

              break;
            case 'CO':
              _coSelectedAction = value;

              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _coSelectedAction,
                    amount: _coRaisedAmount);
              }

              break;
            case 'HJ':
              _hjSelectedAction = value;
              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _hjSelectedAction,
                    amount: _hjRaisedAmount);
              }

              break;
            case 'LJ':
              _ljSelectedAction = value;
              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _ljSelectedAction,
                    amount: _ljRaisedAmount);
              }

              break;
            case 'UTG+2':
              _utg2SelectedAction = value;
              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _utg2SelectedAction,
                    amount: _utg2RaisedAmount);
              }

              break;
            case 'UTG+1':
              _utg1SelectedAction = value;
              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _utg1SelectedAction,
                    amount: _utg1RaisedAmount);
              }

              break;
            case 'UTG':
              _utgSelectedAction = value;
              if (value != 'raise') {
                state.updatePreflop(
                    round: 1,
                    position: position,
                    action: _utgSelectedAction,
                    amount: _utgRaisedAmount);
              }

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

      void _handleRaisedAmountChange(
          {required int amount, required int index}) {
        String position = _positions[_positions.length - index - 1];

        setState(() {
          switch (position) {
            case 'BB':
              _bbRaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _bbSelectedAction,
                  amount: _bbRaisedAmount);

              break;
            case 'SB':
              _sbRaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _sbSelectedAction,
                  amount: _sbRaisedAmount);

              break;
            case 'BTN':
              _btnRaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _btnSelectedAction,
                  amount: _btnRaisedAmount);

              break;
            case 'CO':
              _coRaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _coSelectedAction,
                  amount: _coRaisedAmount);

              break;
            case 'HJ':
              _hjRaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _hjSelectedAction,
                  amount: _hjRaisedAmount);

              break;
            case 'LJ':
              _ljRaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _ljSelectedAction,
                  amount: _ljRaisedAmount);

              break;
            case 'UTG+2':
              _utg2RaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _utg2SelectedAction,
                  amount: _utg2RaisedAmount);

              break;
            case 'UTG+1':
              _utg1RaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _utg1SelectedAction,
                  amount: _utg1RaisedAmount);

              break;
            case 'UTG':
              _utgRaisedAmount = amount;
              state.updatePreflop(
                  round: 1,
                  position: position,
                  action: _utgSelectedAction,
                  amount: _utgRaisedAmount);

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
          child: Column(
            children: [
              Row(
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
              getActionStateFromIndex(index) == 'raise'
                  ? RaisedAmountInputField(
                      index: index, handler: _handleRaisedAmountChange)
                  : Container()
            ],
          ),
        );
      }));
    });
  }
}

class RaisedAmountInputField extends StatefulWidget {
  final int index;
  final void Function({required int amount, required int index}) handler;

  RaisedAmountInputField({required this.index, required this.handler});

  @override
  _RaisedAmountInputFieldState createState() => _RaisedAmountInputFieldState();
}

class _RaisedAmountInputFieldState extends State<RaisedAmountInputField> {
  final TextEditingController _controller = TextEditingController();
  late int _index;
  late void Function({required int amount, required int index}) _handler;

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _handler = widget.handler;
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        try {
          int amount = int.parse(_controller.text);
          _handler(amount: amount, index: _index);
        } on FormatException {
          print("FormatException: ${_controller.text} が数字じゃない");
        }
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller, // コントローラをTextFieldにセット
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        labelText: 'raise額を入力',
        border: OutlineInputBorder(),
      ),
      focusNode: focusNode,
    );
  }
}
