import 'package:flutter/material.dart';

class Counter extends StatefulWidget {

  @override
  State<Counter> createState() => _CounterState();
}
class _CounterState extends State<Counter> {
  int result=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('counter'),
      ),
      body: Center(
        child: Row(
          children: [
            TextButton(
              child: Text(
                'PlUS',

              ),
              onPressed: (){
                setState(() {
                  result++;
                });
              },
            ),
            SizedBox(width: 10,),
            Text(
              '$result',
            ),
            SizedBox(width: 10,),
            TextButton(
              child: Text(
                'MINUS',

              ),
              onPressed: (){
                setState(() {
                  result--;
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
