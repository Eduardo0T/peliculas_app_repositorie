import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/search/search_delegate.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas'),
        actions: [
          IconButton(icon: const Icon(Icons.search),onPressed: (){
            showSearch(delegate: MovieSearchDelegate(),context: context);
          },)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCardSwiper(movies: moviesProvider.onDisplayMovies),
            MovieSlidere(movie: moviesProvider.onPopularMovies, onNextPage:() => moviesProvider.getPopularMovies()),
          ],
        ),
      ),
    );
  }
}
