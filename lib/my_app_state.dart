import 'package:fastest_hand_history/main.dart';
import 'package:flutter/foundation.dart';

class MyAppState extends ChangeNotifier {
  String _selectedIndex = 'home';
  int _bigBlind = 100;
  int _smallBlind = 100;
  int _ante = 100;
  int _participants = 2;

  String get selectedIndex => _selectedIndex;
  int get bigBlind => _bigBlind;
  int get smallBlind => _smallBlind;
  int get ante => _ante;
  int get participants => _participants;

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
