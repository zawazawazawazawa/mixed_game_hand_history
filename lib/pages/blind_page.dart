import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';
import '../widgets/number_input_field.dart';

class BlindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, state, children) => SingleChildScrollView(
          child: Column(
        children: [
          Text('Blind'),
          NumberInputField(
              label: 'BigBlind',
              attribute: 'bigBlind',
              handler: state.updateBigBlind),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  state.updateBigBlind(state.bigBlind - 100);
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
                  state.updateBigBlind(state.bigBlind + 100);
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
                  state.updateBigBlind(state.bigBlind - 1000);
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
                  state.updateBigBlind(state.bigBlind + 1000);
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
                  state.updateBigBlind(state.bigBlind - 10000);
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
                  state.updateBigBlind(state.bigBlind + 10000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 40),
          NumberInputField(
              label: 'SmallBlind',
              attribute: 'smallBlind',
              handler: state.updateSmallBlind),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  state.updateSmallBlind(state.smallBlind - 100);
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
                  state.updateSmallBlind(state.smallBlind + 100);
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
                  state.updateSmallBlind(state.smallBlind - 1000);
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
                  state.updateSmallBlind(state.smallBlind + 1000);
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
                  state.updateSmallBlind(state.smallBlind - 10000);
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
                  state.updateSmallBlind(state.smallBlind + 10000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 40),
          NumberInputField(
              label: 'Ante', attribute: 'ante', handler: state.updateAnte),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  state.updateAnte(state.ante - 100);
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
                  state.updateAnte(state.ante + 100);
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
                  state.updateAnte(state.ante - 1000);
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
                  state.updateAnte(state.ante + 1000);
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
                  state.updateAnte(state.ante - 10000);
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
                  state.updateAnte(state.ante + 10000);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // participantsページへ遷移
              state.updateSelectedIndex('participants');
            },
            child: Text('参加人数を入力'),
          ),
          SizedBox(height: 20)
        ],
      )),
    );
  }
}
