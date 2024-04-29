import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'my_app_state.dart'; // 循環参照になるかも？

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
    return Consumer<MyAppState>(
      builder: (context, state, child) { 
        _controller.value = _controller.value.copyWith(text: state.getProperty(_attribute).toString());
        
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
    );
  }
}
