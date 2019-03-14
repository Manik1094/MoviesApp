
import 'package:movies_bloc/src/models/item_model.dart';
import 'package:movies_bloc/src/models/trailer_model.dart';
import 'package:movies_bloc/src/resources/movie_api_provider.dart';

class Repository{

  final moviesApiProvier =MovieApiProvier();

  Future<ItemModel> fetchAllMovies() => moviesApiProvier.fetchMoviesList();

  Future<TrailerModel> fetchTrailers(int movieId){
    return moviesApiProvier.fetchTrailer(movieId);
  }
}