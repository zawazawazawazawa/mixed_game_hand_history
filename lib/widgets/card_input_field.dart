import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';
import '../utils/show_card_input_dialog.dart';

class CardInputField extends StatefulWidget {
  final PlayingCard card;
  final void handler;

  CardInputField({required this.card, required this.handler});

  @override
  State<CardInputField> createState() => _CardInputFieldState();
}

class _CardInputFieldState extends State<CardInputField> {
  late PlayingCard card;
  late void handler;

  @override
  void initState() {
    super.initState();
    card = widget.card;
    handler = widget.handler;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, state, child) {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () =>
                showCardInputDialog(context: context, onSubmit: () {}),
            child: Text('Input the Card'),
          ),
        ],
      );
    });
  }
}
