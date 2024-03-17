import 'package:english_words/english_words.dart';
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
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  int bigBlind = 100;
  int smallBlind = 100;
  int ante = 100;

  void updateBigBlind(int inputValue) {
    bigBlind = inputValue;
    print('bigBlind: $bigBlind');
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = StartPage();
        break;
      case 1:
        page = BlindPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }



    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
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
                  print(Text('Click')); 
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

    return Column(
      
        children: [
          Text('Blind'),
          NumberInputField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  appState.updateBigBlind(appState.bigBlind + 100);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: () {
                  appState.updateBigBlind(appState.bigBlind - 100);
                },
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
            ],
          ),
        ],
      );
  }
}

class NumberInputField extends StatefulWidget {
  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
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

    _controller.value = _controller.value.copyWith(text: appState.bigBlind.toString());

    print('value: $_controller');
    
    return TextFormField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'BigBlindを入力'
          ),
        onChanged: (value) {
          int inputNumber = int.tryParse(value) ?? 0;
          appState.updateBigBlind(inputNumber);
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );
  }
}
