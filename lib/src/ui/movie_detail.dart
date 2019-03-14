import 'package:flutter/material.dart';
import 'package:movies_bloc/src/blocs/movie_detail_bloc.dart';
import 'package:movies_bloc/src/blocs/movie_detail_bloc_provider.dart';
import 'package:movies_bloc/src/models/trailer_model.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetail({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  _MovieDetailState createState() {
    return _MovieDetailState(
      title: title,
      posterUrl: posterUrl,
      description: description,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      movieId: movieId,
    );
  }
}

class _MovieDetailState extends State<MovieDetail> {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetailBloc bloc;

  _MovieDetailState({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchMovieTrailersById(movieId);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    "https://image.tmdb.org/t/p/w500$posterUrl",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.favorite, color: Colors.red),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      voteAverage,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    Text(
                      releaseDate,
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
                Text(description),
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
                Text(
                  "Trailer",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                ),
                StreamBuilder(
                  stream: bloc.movieTrailers,
                  builder:
                      (context, AsyncSnapshot<Future<TrailerModel>> snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.error);
                      return FutureBuilder(
                        future: snapshot.data,
                        builder: (context,
                            AsyncSnapshot<TrailerModel> itemSnapshot) {
                          if (itemSnapshot.hasData) {
                            print(itemSnapshot.error);
                            if (itemSnapshot.data.results.length > 0) {
                              return trailerLayout(itemSnapshot.data);
                            } else {
                              return noTrailer(itemSnapshot.data);
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if(data.results.length > 1){
      return Row(
        children: <Widget>[
         trailerItem(data , 0),
         trailerItem(data , 1)
        ],
      );
    }else{
      return Row(
        children: <Widget>[
          trailerItem(data , 0)
        ],
      );
    }

  }

  Widget trailerItem(TrailerModel data , int index){
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: Center(child: Icon(Icons.play_circle_filled),),
          ),
          Text(
            data.results[index].name,
            maxLines:1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }
}
