import 'package:flutter/material.dart';
import 'package:movies_bloc/src/blocs/movie_detail_bloc_provider.dart';
import 'package:movies_bloc/src/blocs/movies_bloc.dart';
import 'package:movies_bloc/src/models/item_model.dart';
import 'package:movies_bloc/src/ui/movie_detail.dart';

class MoviesList extends StatefulWidget {
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context , AsyncSnapshot<ItemModel> snapshot){
          if(snapshot.hasData){
            return buildList(snapshot);
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot){
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context , int index){
        return GridTile(
          child: InkResponse(
            enableFeedback: true,
             child: Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
            fit: BoxFit.cover,
          
          ),
          onTap: () => openDetailPage(snapshot.data ,index),
          ),
         
        );
      },
    );
  }
  openDetailPage(ItemModel data , int index){
    Navigator.push(
      context,
       MaterialPageRoute(
         builder: (context){
          return MovieDetailBlocProvider(
                      child: MovieDetail(
              title: data.results[index].title,
              posterUrl: data.results[index].backdrop_path,
              description: data.results[index].overview,
              releaseDate: data.results[index].release_date,
              voteAverage: data.results[index].vote_average.toString(),
              movieId: data.results[index].id,

            ),
          );
         }
       ));
  }
}