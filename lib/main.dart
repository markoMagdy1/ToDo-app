import 'package:flutter/material.dart';
import 'cubit/bloc_observer.dart';
import 'layout_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {

  BlocOverrides.runZoned(

        () {

      runApp(MyApp());

    },

    blocObserver: SimpleBlocObserver(),

  );

}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:  LayoutScreenState(),
    );
  }
}


