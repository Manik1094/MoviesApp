import 'package:flutter/material.dart';
import 'package:movies_bloc/src/ui/movie_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: MoviesList(),
      ),
      
    );
  }
}