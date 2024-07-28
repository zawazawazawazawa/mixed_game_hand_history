import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../my_app_state.dart';

class UnexpectedPositionError extends Error {
  final String message;
  UnexpectedPositionError(this.message);

  @override
  String toString() => message;
}

class BettingRoundPage extends StatelessWidget {
  final bettingRound;
  final positions;

  BettingRoundPage({required this.bettingRound, required this.positions});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, child) {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
            child: RadioAction(
                bettingRound: bettingRound,
                positions: positions,
                bigBlindAmount: state.bigBlind))
      ]);
    });
  }
}

class RadioAction extends StatefulWidget {
  final String bettingRound;
  final List<String> positions;
  final int bigBlindAmount;

  RadioAction(
      {required this.bettingRound,
      required this.positions,
      required this.bigBlindAmount});

  @override
  _RadioActionState createState() => _RadioActionState();
}

class _RadioActionState extends State<RadioAction> {
  late String _bettingRound;
  late List<String> _positions;

  String? _utgSelectedAction;
  String? _utg1SelectedAction;
  String? _utg2SelectedAction;
  String? _ljSelectedAction;
  String? _hjSelectedAction;
  String? _coSelectedAction;
  String? _btnSelectedAction;
  String? _sbSelectedAction;
  String? _bbSelectedAction;

  int? _utgRaisedAmount;
  int? _utg1RaisedAmount;
  int? _utg2RaisedAmount;
  int? _ljRaisedAmount;
  int? _hjRaisedAmount;
  int? _coRaisedAmount;
  int? _btnRaisedAmount;
  int? _sbRaisedAmount;
  int? _bbRaisedAmount;

  int _currentTargetPosition = 0;
  int _round = 1;
  int _callAmount = 0;

  @override
  void initState() {
    super.initState();
    _bettingRound = widget.bettingRound;
    _positions = widget.positions;
    _callAmount = widget.bigBlindAmount;
    _currentTargetPosition = _positions.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, children) {
      void resetLocalState() {
        _utgSelectedAction = null;
        _utg1SelectedAction = null;
        _utg2SelectedAction = null;
        _ljSelectedAction = null;
        _hjSelectedAction = null;
        _coSelectedAction = null;
        _btnSelectedAction = null;
        _sbSelectedAction = null;
        _bbSelectedAction = null;

        _utgRaisedAmount = null;
        _utg1RaisedAmount = null;
        _utg2RaisedAmount = null;
        _ljRaisedAmount = null;
        _hjRaisedAmount = null;
        _coRaisedAmount = null;
        _btnRaisedAmount = null;
        _sbRaisedAmount = null;
        _bbRaisedAmount = null;

        _currentTargetPosition = _positions.length - 1;
        _round = 1;
        _callAmount = state.bigBlind;
      }

      List<PlayerAction> getBetActionState() {
        switch (_bettingRound) {
          case 'preflop':
            return state.preflop;
          case 'flop':
            return state.flop;
          case 'turn':
            return state.turn;
          case 'river':
            return state.river;
          default:
            throw Error();
        }
      }

      List<PlayerAction> betActionState = getBetActionState();

      getActionUpdateMethod() {
        switch (_bettingRound) {
          case 'preflop':
            return state.updatePreflop;
          case 'flop':
            return state.updateFlop;
          case 'turn':
            return state.updateTurn;
          case 'river':
            return state.updateRiver;
          default:
            throw Error();
        }
      }

      var actionUpdateMethod = getActionUpdateMethod();

      getActionResetMethod() {
        switch (_bettingRound) {
          case 'preflop':
            return state.resetPreflop;
          case 'flop':
            return state.resetFlop;
          case 'turn':
            return state.resetTurn;
          case 'river':
            return state.resetRiver;
          default:
            throw Error();
        }
      }

      var actionResetMethod = getActionResetMethod();

      String? getActionStateFromIndex({required int index}) {
        switch (_positions[index]) {
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
                'unexpected position name is detected: ${_positions[_currentTargetPosition]}');
        }
      }

      String? getActionStateFromPosition({required String position}) {
        switch (position) {
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
                'unexpected position name is detected: ${_positions[_currentTargetPosition]}');
        }
      }

      int? getRaisedAmountFromPosition({required String position}) {
        switch (position) {
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
                'unexpected position name is detected: ${_positions[_currentTargetPosition]}');
        }
      }

      bool isRemainingAction() {
        // RaiseAmountに一つでもnullがあればまだactionしてない人がいる
        List<int?> amounts = [
          _bbRaisedAmount,
          _sbRaisedAmount,
          _btnRaisedAmount,
          _coRaisedAmount,
          _hjRaisedAmount,
          _ljRaisedAmount,
          _utg2RaisedAmount,
          _utg1RaisedAmount,
          _utgRaisedAmount
        ];

        List<int?> actualPlayersAmounts = amounts.sublist(0, _positions.length);

        var isIncludedNullAction =
            actualPlayersAmounts.any((element) => element == null);

        if (isIncludedNullAction) {
          return true;
        }

        // RaiseAmountにnullがなく、0ではない人のamountがすべて等しければこのroundは終了している
        List<int?> rasedOrCalledPalyersAmounts = [];
        rasedOrCalledPalyersAmounts =
            actualPlayersAmounts.where((e) => e != 0).toList();
        var allActivePlayerRaisedSameAmount = rasedOrCalledPalyersAmounts
            .every((element) => element == rasedOrCalledPalyersAmounts[0]);

        // 全員の金額が揃っているなら、Actionは残っていない
        return !allActivePlayerRaisedSameAmount;
      }

      int? nextTargetPositionIndex() {
        String nextUnactionedPosition = _positions.reversed.firstWhere(
            (position) =>
                getActionStateFromPosition(position: position) == null,
            orElse: () => 'none');

        if (nextUnactionedPosition != 'none') {
          return _positions.indexOf(nextUnactionedPosition);
        } else {
          String nextActionedPosition =
              _positions.reversed.firstWhere((position) {
            var amount = getRaisedAmountFromPosition(position: position);
            return amount != null && amount > 0 && amount < _callAmount;
          }, orElse: () => 'none');

          if (nextActionedPosition != 'none') {
            return _positions.indexOf(nextActionedPosition);
          }
        }
      }

      void _handleRadioValueChange({String? value}) {
        String position = _positions[_currentTargetPosition];

        setState(() {
          switch (position) {
            case 'BB':
              _bbSelectedAction = value;
              if (value == 'call') {
                _bbRaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _bbSelectedAction,
                    amount: _bbRaisedAmount);
              } else if (value == 'fold') {
                _bbRaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _bbSelectedAction,
                    amount: _bbRaisedAmount);
              }
              break;
            case 'SB':
              _sbSelectedAction = value;
              if (value == 'call') {
                _sbRaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _sbSelectedAction,
                    amount: _sbRaisedAmount);
              } else if (value == 'fold') {
                _sbRaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _sbSelectedAction,
                    amount: _sbRaisedAmount);
              }
              break;
            case 'BTN':
              _btnSelectedAction = value;
              if (value == 'call') {
                _btnRaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _btnSelectedAction,
                    amount: _btnRaisedAmount);
              } else if (value == 'fold') {
                _btnRaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _btnSelectedAction,
                    amount: _btnRaisedAmount);
              }
              break;
            case 'CO':
              _coSelectedAction = value;
              if (value == 'call') {
                _coRaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _coSelectedAction,
                    amount: _coRaisedAmount);
              } else if (value == 'fold') {
                _coRaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _coSelectedAction,
                    amount: _coRaisedAmount);
              }
              break;
            case 'HJ':
              _hjSelectedAction = value;
              if (value == 'call') {
                _hjRaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _hjSelectedAction,
                    amount: _hjRaisedAmount);
              } else if (value == 'fold') {
                _hjRaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _hjSelectedAction,
                    amount: _hjRaisedAmount);
              }
              break;
            case 'LJ':
              _ljSelectedAction = value;
              if (value == 'call') {
                _ljRaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _ljSelectedAction,
                    amount: _ljRaisedAmount);
              } else if (value == 'fold') {
                _ljRaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _ljSelectedAction,
                    amount: _ljRaisedAmount);
              }
              break;
            case 'UTG+2':
              _utg2SelectedAction = value;
              if (value == 'call') {
                _utg2RaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _utg2SelectedAction,
                    amount: _utg2RaisedAmount);
              } else if (value == 'fold') {
                _utg2RaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _utg2SelectedAction,
                    amount: _utg2RaisedAmount);
              }
              break;
            case 'UTG+1':
              _utg1SelectedAction = value;
              if (value == 'call') {
                _utg1RaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _utg1SelectedAction,
                    amount: _utg1RaisedAmount);
              } else if (value == 'fold') {
                _utg1RaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _utg1SelectedAction,
                    amount: _utg1RaisedAmount);
              }
              break;
            case 'UTG':
              _utgSelectedAction = value;
              if (value == 'call') {
                _utgRaisedAmount = _callAmount;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _utgSelectedAction,
                    amount: _utgRaisedAmount);
              } else if (value == 'fold') {
                _utgRaisedAmount = 0;
                actionUpdateMethod(
                    round: _round,
                    position: position,
                    action: _utgSelectedAction,
                    amount: _utgRaisedAmount);
              }
              break;
            default:
              throw UnexpectedPositionError(
                  'unexpected position name is detected: $position');
          }

          if (!isRemainingAction()) {
            // hero pageへ
            state.updateSelectedIndex('hero');
          }

          if (value != 'raise') {
            // TODO: int?の型エラー回避してるが、良い方法を考える
            if (_currentTargetPosition > 0) {
              _currentTargetPosition = nextTargetPositionIndex() ?? 0;
            } else if (_currentTargetPosition == 0) {
              _currentTargetPosition = nextTargetPositionIndex() ?? 0;
              _round += 1;
            }
          }
        });
      }

      void _handleRaisedAmountChange({required int amount}) {
        String position = _positions[_currentTargetPosition];

        setState(() {
          switch (position) {
            case 'BB':
              _bbRaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _bbSelectedAction,
                  amount: _bbRaisedAmount);

              break;
            case 'SB':
              _sbRaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _sbSelectedAction,
                  amount: _sbRaisedAmount);

              break;
            case 'BTN':
              _btnRaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _btnSelectedAction,
                  amount: _btnRaisedAmount);

              break;
            case 'CO':
              _coRaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _coSelectedAction,
                  amount: _coRaisedAmount);

              break;
            case 'HJ':
              _hjRaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _hjSelectedAction,
                  amount: _hjRaisedAmount);

              break;
            case 'LJ':
              _ljRaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _ljSelectedAction,
                  amount: _ljRaisedAmount);

              break;
            case 'UTG+2':
              _utg2RaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _utg2SelectedAction,
                  amount: _utg2RaisedAmount);

              break;
            case 'UTG+1':
              _utg1RaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _utg1SelectedAction,
                  amount: _utg1RaisedAmount);

              break;
            case 'UTG':
              _utgRaisedAmount = amount;
              actionUpdateMethod(
                  round: _round,
                  position: position,
                  action: _utgSelectedAction,
                  amount: _utgRaisedAmount);

              break;
            default:
              throw UnexpectedPositionError(
                  'unexpected position name is detected: $position');
          }

          _callAmount = amount;

          if (!isRemainingAction()) {
            // hero pageへ
            state.updateSelectedIndex('hero');
          }

          // TODO: int?の型エラー回避してるが、良い方法を考える

          if (_currentTargetPosition > 0) {
            _currentTargetPosition = nextTargetPositionIndex() ?? 0;
          } else if (_currentTargetPosition == 0) {
            _currentTargetPosition = nextTargetPositionIndex() ?? 0;
            _round += 1;
          }
        });
      }

      List<Widget> _widgets =
          List<Widget>.generate(betActionState.length, (int index) {
        return Column(
          children: [
            SizedBox(height: 20),
            Text(betActionState[index].position),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Raise'),
                    leading: Radio<String>(
                      value: 'raise',
                      groupValue: betActionState[index].action,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Call'),
                    leading: Radio<String>(
                      value: 'call',
                      groupValue: betActionState[index].action,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Fold'),
                    leading: Radio<String>(
                      value: 'fold',
                      groupValue: betActionState[index].action,
                      onChanged: (value) {},
                    ),
                  ),
                )
              ],
            ),
            betActionState[index].action == 'raise'
                ? Text("amount: ${betActionState[index].amount}")
                : Container()
          ],
        );
      });

      _widgets.add(Column(
        children: [
          SizedBox(height: 20),
          Text(_positions[_currentTargetPosition]),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text('Raise'),
                  leading: Radio<String>(
                      value: 'raise',
                      groupValue: _round > 1
                          ? null
                          : getActionStateFromIndex(
                              index: _currentTargetPosition),
                      onChanged: (value) {
                        _handleRadioValueChange(value: value);
                      }),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Call'),
                  leading: Radio<String>(
                      value: 'call',
                      groupValue: _round > 1
                          ? null
                          : getActionStateFromIndex(
                              index: _currentTargetPosition),
                      onChanged: (value) {
                        _handleRadioValueChange(value: value);
                      }),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Fold'),
                  leading: Radio<String>(
                      value: 'fold',
                      groupValue: _round > 1
                          ? null
                          : getActionStateFromIndex(
                              index: _currentTargetPosition),
                      onChanged: (value) {
                        _handleRadioValueChange(value: value);
                      }),
                ),
              ),
            ],
          ),
          getActionStateFromIndex(index: _currentTargetPosition) == 'raise'
              ? RaisedAmountInputField(handler: _handleRaisedAmountChange)
              : Container()
        ],
      ));

      return SingleChildScrollView(
        child: Column(children: [
          Text('Small Blind: ${state.smallBlind}'),
          Text('Big Blind: ${state.bigBlind}'),
          Text('Ante: ${state.ante}'),
          Text('${state.participants} handed'),
          Text(
              'Preflop Active Player: ${state.getPreflopActiveUserPositions()}'),
          Text('Flop Active Player: ${state.getFlopActiveUserPositions()}'),
          Column(children: _widgets),
          ElevatedButton(
            onPressed: () {
              resetLocalState();
              state.resetPreflop();
              // blindページへ遷移
              state.updateSelectedIndex('participants');
            },
            child: Text('Blindに戻る'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              resetLocalState();
              state.resetPreflop();
            },
            child: Text('アクションを最初から登録し直す'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              state.updateSelectedIndex('hero');
            },
            child: Text('Heroを入力'),
          ),
        ]),
      );
    });
  }
}

class RaisedAmountInputField extends StatefulWidget {
  final void Function({required int amount}) handler;

  RaisedAmountInputField({required this.handler});

  @override
  _RaisedAmountInputFieldState createState() => _RaisedAmountInputFieldState();
}

class _RaisedAmountInputFieldState extends State<RaisedAmountInputField> {
  final TextEditingController _controller = TextEditingController();
  late void Function({required int amount}) _handler;

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _handler = widget.handler;
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        try {
          int amount = int.parse(_controller.text);
          _handler(amount: amount);
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
