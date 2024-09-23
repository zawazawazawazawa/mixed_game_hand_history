import 'package:flutter/foundation.dart';

class MyAppState extends ChangeNotifier {
  String _selectedIndex = 'home';
  int _bigBlind = 100;
  int _smallBlind = 100;
  int _ante = 100;
  int _participants = 2;
  // TODO: debug用 3人プレイ
  // int _participants = 3;
  List<PlayerAction> _preflop = [];
  // TODO: debug用 preflopのアクションを追加
  //List<PlayerAction> _preflop = [
  //  PlayerAction(round: 1, position: 'BTN', action: 'raise', amount: 300),
  //  PlayerAction(round: 1, position: 'SB', action: 'fold', amount: 0),
  //  PlayerAction(round: 1, position: 'BB', action: 'call', amount: 300),
  //];
  List<PlayerAction> _flop = [];
  List<PlayerAction> _turn = [];
  List<PlayerAction> _river = [];

  String _heroPosition = '';

  String get selectedIndex => _selectedIndex;
  int get bigBlind => _bigBlind;
  int get smallBlind => _smallBlind;
  int get ante => _ante;
  int get participants => _participants;
  List<PlayerAction> get preflop => _preflop;
  List<PlayerAction> get flop => _flop;
  List<PlayerAction> get turn => _turn;
  List<PlayerAction> get river => _river;

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
    List<String> defaultPositions = [
      'BTN',
      'CO',
      'HJ',
      'LJ',
      'UTG+2',
      'UTG+1',
      'UTG',
      'SB',
      'BB',
    ];

    PlayerAction? lastRaisePlayerAction;
    List<String> positions = [];

    // preflopのアクションを逆順にloopし最初のraiseを探す
    for (var action in preflop.reversed.toList()) {
      if (action.action == 'raise') {
        lastRaisePlayerAction = action;
        break;
      }
    }

    if (lastRaisePlayerAction != null) {
      positions.add(lastRaisePlayerAction.position);

      // 最後のraiseアクションの後にcallがあるかどうかを確認
      for (var action in preflop.reversed.toList()) {
        if (preflop.indexWhere((preflopPlayerAction) =>
                    preflopPlayerAction == lastRaisePlayerAction) <
                preflop.indexWhere(
                    (preflopPlayerAction) => preflopPlayerAction == action) &&
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

    positions.sort((x, y) =>
        defaultPositions.indexOf(x).compareTo(defaultPositions.indexOf(y)));

    return positions;
  }

  void updatePreflop(
      {required int round,
      required String position,
      required String? action,
      required int? amount}) {
    _preflop.add(PlayerAction(
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

  void resetFlop() {
    _flop = [];
    notifyListeners();
  }

  void resetTurn() {
    _turn = [];
    notifyListeners();
  }

  void resetRiver() {
    _river = [];
    notifyListeners();
  }

  void updateFlop(
      {required int round,
      required String position,
      required String? action,
      required int? amount}) {
    _flop.add(PlayerAction(
      round: round,
      position: position,
      action: action,
      amount: amount,
    ));
    notifyListeners();
  }

  void updateTurn() {}

  void updateRiver() {}

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

class PlayerAction {
  int round;
  String position;
  String? action;
  int? amount;

  PlayerAction(
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
