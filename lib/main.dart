import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String selectedIndex = 'home';

  int bigBlind = 100;
  int smallBlind = 100;
  int ante = 100;
  int participants = 2;

  void updateSelectedIndex(String inputValue) {
    selectedIndex = inputValue;
    notifyListeners();
  }

  void updateBigBlind(int inputValue) {
    bigBlind = inputValue;
    notifyListeners();
  }

  void updateSmallBlind(int inputValue) {
    smallBlind = inputValue;
    notifyListeners();
  }


  void updateAnte(int inputValue) {
    ante = inputValue;
    notifyListeners();
  }

  void updateParticipants(int inputValue) {
    const int maxParticipants = 9;
    const int minParticipants = 2;

    if (inputValue >= minParticipants && inputValue <= maxParticipants) {
      participants = inputValue;
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

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    var selectedIndex = appState.selectedIndex;
    Widget page;
    switch (selectedIndex) {
      case 'home':
        page = StartPage();
        break;
      case 'blind':
        page = BlindPage();
        break;
      case 'participants':
        page = ParticipantPage();
        break;
      case 'preflop':
        page = PreflopPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

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
                  appState.updateSelectedIndex('blind');
                },
                child: Text('Start'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BlindPage extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Blind'),
          NumberInputField(label: 'BigBlind', attribute: 'bigBlind', handler: appState.updateBigBlind),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateBigBlind(appState.bigBlind - 100);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('100'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateBigBlind(appState.bigBlind + 100);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateBigBlind(appState.bigBlind - 1000);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('1000'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateBigBlind(appState.bigBlind + 1000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateBigBlind(appState.bigBlind - 10000);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('10000'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateBigBlind(appState.bigBlind + 10000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 40),
          NumberInputField(label: 'SmallBlind', attribute: 'smallBlind', handler: appState.updateSmallBlind),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateSmallBlind(appState.smallBlind - 100);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('100'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateSmallBlind(appState.smallBlind + 100);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateSmallBlind(appState.smallBlind - 1000);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('1000'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateSmallBlind(appState.smallBlind + 1000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateSmallBlind(appState.smallBlind - 10000);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('10000'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateSmallBlind(appState.smallBlind + 10000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 40),
          NumberInputField(label: 'Ante', attribute: 'ante', handler: appState.updateAnte),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateAnte(appState.ante - 100);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('100'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateAnte(appState.ante + 100);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateAnte(appState.ante - 1000);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('1000'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateAnte(appState.ante + 1000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateAnte(appState.ante - 10000);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('10000'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateAnte(appState.ante + 10000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),

          ElevatedButton(
            onPressed: () {
              // participantsページへ遷移
              appState.updateSelectedIndex('participants');
            },
            child: Text('参加人数を入力'),
           ),
        ],
      )
    );
  }
}

class ParticipantPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    return Column(
        children: [
          Text('参加人数'),
          NumberInputField(label: '参加人数', attribute: 'participants', handler: appState.updateParticipants),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateParticipants(appState.participants - 1);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('1'),
                  ],
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateParticipants(appState.participants + 1);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // preflopページへ遷移
              appState.updateSelectedIndex('preflop');
            },
            child: Text('preflopを入力'),
           ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // blindページへ遷移
              appState.updateSelectedIndex('blind');
            },
            child: Text('Blindに戻る'),
           ),
        ]
      );
  }
}

class PreflopPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('TO BE IMPLEMENTED')
        ],
      ),
    );
  }
}

class NumberInputField extends StatefulWidget {
  final String label;
  final String attribute;
  final void Function(int) handler;

  NumberInputField({required this.label, required this.attribute, required this.handler});

  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  final TextEditingController _controller = TextEditingController();
  late String _label;
  late String _attribute;
  late void Function(int) _handler;

  @override
  void initState() {
    super.initState();
    _label = widget.label;
    _attribute = widget.attribute;
    _handler = widget.handler;
    _controller.addListener(() {
      final String text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    _controller.value = _controller.value.copyWith(text: appState.getProperty(_attribute).toString());

    return TextFormField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: _label
          ),
        onChanged: (value) {
          int inputNumber = int.tryParse(value) ?? 0;
          _handler(inputNumber);
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );
  }
}
