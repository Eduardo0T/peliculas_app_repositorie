import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body:CustomScrollView(
        slivers:[
          _CustomAppBar(movies: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterandTitle(movies: movie),
              _Overview(movies: movie),
              _CarruselActores(movieId: movie.id,)

            ])
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key, required this.movies}) : super(key: key);

  final Movie movies;

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
            width: double.infinity,
            child: Text(movies.title,style: const TextStyle(fontSize: 16,),textAlign: TextAlign.center,)),
        background:  FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage('${movies.fullBackdropPath}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterandTitle extends StatelessWidget {
  const _PosterandTitle({Key? key, required this.movies}) : super(key: key);
  final Movie movies;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
           Hero(
             tag: movies.heroId!,
             child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
          placeholder: const AssetImage('no-image.jpg'),
          image:  NetworkImage('${movies.fullPosterImg}'),
          height: 100,),
        ),
           ),
          const SizedBox(width: 20,),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movies.title,style: textTheme.headline5,overflow: TextOverflow.ellipsis,maxLines: 2,),
                Text(movies.originalTitle,style: textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                Row(children: [
                  const Icon(Icons.star_outline,size: 15,),
                  const SizedBox(width: 5,),
                  Text(movies.voteAverage.toString(),style: Theme.of(context).textTheme.caption,)
                ],)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key, required this.movies}) : super(key: key);

  final Movie movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(movies.overview,
        textAlign: TextAlign.justify,
      style: const TextStyle(fontSize: 16),),
    );
  }
}

class _CarruselActores extends StatelessWidget {
  const _CarruselActores({Key? key,required this.movieId}) : super(key: key);

  final int movieId;



  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context,listen: false);

    return FutureBuilder(builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

      if(snapshot.data == null){
        return const Center(child: CircularProgressIndicator());
      }

      final List<Cast> cast = snapshot.data!;
      return SizedBox(
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (_, i) {

              final Cast actor = cast[i];
              return  Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, 'ActorScreen',arguments: actor);
                            },
                            child: FadeInImage(
                              height: 150,
                              fit: BoxFit.cover,
                              placeholder: const AssetImage('assets/no-image.jpg'),
                              image: NetworkImage(actor.fullProfilePath),
                            ),
                          ),
                        ),
                        Text(actor.name,overflow: TextOverflow.ellipsis,)
                      ],
                    ),
                  )
                ],
              );
            },)
      );
    },
    future: movieProvider.getCredits(movieId),);


  }
}


