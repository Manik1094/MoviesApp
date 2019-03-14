import 'package:flutter/material.dart';
import 'package:movies_bloc/src/blocs/movie_detail_bloc.dart';

class MovieDetailBlocProvider extends InheritedWidget{

  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({Key key , Widget child}) :bloc =MovieDetailBloc()
  , super(key:key , child:child);


  @override
  bool updateShouldNotify(_) {
   
    return true;
  }
  static MovieDetailBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(MovieDetailBlocProvider)
      as MovieDetailBlocProvider).bloc;
  }

}