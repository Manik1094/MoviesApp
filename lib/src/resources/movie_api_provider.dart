import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_bloc/src/models/item_model.dart';
import 'dart:async';

import 'package:movies_bloc/src/models/trailer_model.dart';

class MovieApiProvier{

http.Client client =http.Client();
final _apiKey = '7ab058bc26b2da9fc1a3d2772ebf9139';
final _baseUrl = 'http://api.themoviedb.org/3/movie';

Future<ItemModel> fetchMoviesList() async{

  final response = await client.get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
  print(response.body.toString());
  if(response.statusCode == 200){
    //If call was successfull
    return ItemModel.fromJson(json.decode(response.body));
  }else{
    throw Exception('Failed to load post');
  }
}

Future<TrailerModel> fetchTrailer(int movieId) async{
  final response = await client.get("${_baseUrl}/${movieId}/videos?api_key=${_apiKey}");
  if(response.statusCode == 200){
    return TrailerModel.fromJson(json.decode(response.body));
  }else{
    throw Exception('Failed to load trailers');
  }
  
}

}