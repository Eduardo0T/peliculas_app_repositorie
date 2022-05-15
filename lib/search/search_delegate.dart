import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/search_actor_response.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.close),
        onPressed: () => query = '',)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () => close(context, null),);
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Results');
  }

  Widget _emptyContainer() {
    return const Center(child: Icon(Icons.movie, size: 130,),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      builder: (_, AsyncSnapshot<List<Movie>> snaphot) {
        if (!snaphot.hasData) {
          return _emptyContainer();
        }
        final movies = snaphot.data!;

        return ListView.builder(
          itemBuilder: (_, index) => _MovieItem(movie: movies[index],),
          itemCount: movies.length,
        );
      },
      stream: moviesProvider.suggestionStream,
    );
  }
}
class _MovieItem extends StatelessWidget {
  const _MovieItem({Key? key, required this.movie}) : super(key: key);

  final Movie movie;


  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';
    return ListTile(

      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage(movie.fullPosterImg),
        placeholder: const AssetImage('assets/no-image.jpg'),
        width: 50,
        fit: BoxFit.contain,),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: ()=> Navigator.pushNamed(context, 'DetailsScreen',arguments: movie),
    );
  }
}
class _ActorItem extends StatelessWidget {
  const _ActorItem({Key? key, required this.actor}) : super(key: key);

  final ActorSearch actor;


  @override
  Widget build(BuildContext context) {

   // movie.heroId = 'search-${actor.id}';
    return ListTile(

      leading: FadeInImage(
        image: NetworkImage(actor.fullProfilePath),
        placeholder: const AssetImage('assets/no-image.jpg'),
        width: 50,
        fit: BoxFit.contain,),
      title: Text(actor.name),
      //onTap: ()=> Navigator.pushNamed(context, 'DetailsScreen',arguments: movie),
    );
  }
}
