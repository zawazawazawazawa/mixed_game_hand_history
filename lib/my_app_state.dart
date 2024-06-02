import 'package:flutter/foundation.dart';

class MyAppState extends ChangeNotifier {
  String _selectedIndex = 'home';
  int _bigBlind = 100;
  int _smallBlind = 100;
  int _ante = 100;
  int _participants = 2;
  List<PreFlopAction> _preflop = [];

  String get selectedIndex => _selectedIndex;
  int get bigBlind => _bigBlind;
  int get smallBlind => _smallBlind;
  int get ante => _ante;
  int get participants => _participants;
  List<PreFlopAction> get preflop => _preflop;

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
