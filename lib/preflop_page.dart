import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app_state.dart';

class PreflopPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, child) => Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(state.participants, (index) {
                return RadioAction();
              },
            )
          ),
          ElevatedButton(
            onPressed: () {
              // blindページへ遷移
              state.updateSelectedIndex('participants');
            },
            child: Text('Blindに戻る'),
          ),
        ]
      )
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
