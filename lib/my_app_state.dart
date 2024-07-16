import 'package:flutter/foundation.dart';

class MyAppState extends ChangeNotifier {
  String _selectedIndex = 'home';
  int _bigBlind = 100;
  int _smallBlind = 100;
  int _ante = 100;
  int _participants = 2;
  List<PreFlopAction> _preflop = [];
  String _heroPosition = '';

  String get selectedIndex => _selectedIndex;
  int get bigBlind => _bigBlind;
  int get smallBlind => _smallBlind;
  int get ante => _ante;
  int get participants => _participants;
  List<PreFlopAction> get preflop => _preflop;
  String get heroPosition => _heroPosition;

  void updateSelectedIndex(String inputValue) {
    _selectedIndex = inputValue;
    notifyListeners();
  }

  void updateBigBlind(int inputValue) {
    _bigBlind = inputValue;
    notifyListeners();
  }

  void updateSmallBlind(int inputValue) {
    _smallBlind = inputValue;
    notifyListeners();
  }

  void updateAnte(int inputValue) {
    _ante = inputValue;
    notifyListeners();
  }

  void updateParticipants(int inputValue) {
    const int maxParticipants = 9;
    const int minParticipants = 2;

    if (inputValue >= minParticipants && inputValue <= maxParticipants) {
      _participants = inputValue;
      notifyListeners();
    }
  }

  List<String> getPreflopActiveUserPositions() {
    List<String> positions = ['BB', 'SB', 'BTN', 'CO', 'HJ', 'LJ', 'UTG'];

    if (_participants == 8) {
      positions.insert(6, 'UTG+1');
    } else if (_participants == 9) {
      positions.insertAll(6, ['UTG+2', 'UTG+1']);
    } else {
      positions = positions.sublist(0, _participants);
    }

    return positions;
  }

  List<String> getFlopActiveUserPositions() {
    PreFlopAction? lastRaiseAction;
    List<String> positions = [];

    // preflopのアクションを逆順にloopし最初のraiseを探す
    for (var action in preflop.reversed.toList()) {
      if (action.action == 'raise') {
        lastRaiseAction = action;
        break;
      }
    }

    if (lastRaiseAction != null) {
      print('last raise actionはある');
      positions.add(lastRaiseAction.position);

      // 最後のraiseアクションの後にcallがあるかどうかを確認
      for (var action in preflop.reversed.toList()) {
        if (preflop.indexWhere(
                    (preflopAction) => preflopAction == lastRaiseAction) <
                preflop
                    .indexWhere((preflopAction) => preflopAction == action) &&
            action.action == 'call') {
          positions.add(action.position);
        }
      }

      if (positions.length == 1) {
        // To be implemented
        // 誰もcallしていないので終わり
      }
    } else {
      // 誰もraiseしていない場合、callしたプレイヤーのpositionを返す
      for (var action in preflop) {
        // To be implemented
        // check around
      }
    }

    return positions;
  }

  void updatePreflop(
      {required int round,
      required String position,
      required String? action,
      required int? amount}) {
    _preflop.add(PreFlopAction(
      round: round,
      position: position,
      action: action,
      amount: amount,
    ));
    notifyListeners();
  }

  void resetPreflop() {
    _preflop = [];
    notifyListeners();
  }

  void updateHeroPosition({required String position}) {
    _heroPosition = position;
    notifyListeners();
  }

  getProperty(String key) {
    switch (key) {
      case 'bigBlind':
        return bigBlind;
      case 'smallBlind':
        return smallBlind;
      case 'ante':
        return ante;
      case 'participants':
        return participants;
      default:
        throw UnimplementedError('oh my god');
    }
  }
}

class PreFlopAction {
  int round;
  String position;
  String? action;
  int? amount;

  PreFlopAction(
      {required this.round,
      required this.position,
      required this.action,
      this.amount});

  Map<String, dynamic> toJson() {
    var data = {
      'round': round,
      'position': position,
      'action': action,
      'amount': amount,
    };

    return data;
  }
}

class PlayingCard {
  String? suit;
  String? rank;

  PlayingCard({required this.suit, required this.rank});

  PlayingCard copyWith({String? suit, String? rank}) {
    return PlayingCard(
      suit: suit ?? this.suit,
      rank: rank ?? this.rank,
    );
  }
}
