import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'blind_page.dart';
import 'my_app_state.dart';
import 'participants_page.dart';
import 'start_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            var selectedIndex = state.selectedIndex;
            Widget page;
            switch (selectedIndex) {
              case 'home':
                page = StartPage();
                break;
              case 'blind':
                page = BlindPage();
                break;
              case 'participants':
                page = ParticipantsPage();
                break;
              case 'preflop':
                page = PreflopPage();
                break;
              default:
                throw UnimplementedError('no widget for $selectedIndex');
            }
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
    );
  }
}

class PreflopPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(appState.participants, (index) {
              return RadioAction();
            },
          )
        ),
        ElevatedButton(
          onPressed: () {
            // blindページへ遷移
            appState.updateSelectedIndex('participants');
          },
          child: Text('Blindに戻る'),
        ),
      ]
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

class RadioAction extends StatefulWidget {
  @override
  _RadioActionState createState() => _RadioActionState();
}

class _RadioActionState extends State<RadioAction> {
  String? _selectedAction = 'fold';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedAction = value;
      print(_selectedAction);  // デバッグ目的で選択値をコンソールに表示
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: Text('Raise'),
            leading: Radio<String>(
              value: 'raise',
              groupValue: _selectedAction,
              onChanged: _handleRadioValueChange,
            ),
          ),
        ),
        Expanded(
          child:
            ListTile(
              title: Text('Call'),
              leading: Radio<String>(
                value: 'call',
                groupValue: _selectedAction,
                onChanged: _handleRadioValueChange,
              ),
            ),
        ),
        Expanded(
          child: 
            ListTile(
              title: Text('Fold'),
              leading: Radio<String>(
                value: 'fold',
                groupValue: _selectedAction,
                onChanged: _handleRadioValueChange,
              ),
            ),
        )
      ] 
    );
  }
}
