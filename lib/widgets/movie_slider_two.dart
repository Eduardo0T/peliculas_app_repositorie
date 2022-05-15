import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSliderTwo extends StatelessWidget {
   MovieSliderTwo({Key? key, required this.actorId}) : super(key: key);

  int actorId;

  @override
  Widget build(BuildContext context) {

    final movieProvider = Provider.of<MovieProvider>(context);
    return FutureBuilder(
      future: movieProvider.getOnPeliculasActor(actorId),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot){
        if(snapshot.data == null) return Center(child: CircularProgressIndicator(),);

        final pelicula = snapshot.data;
        return SizedBox(
        width: double.infinity,
        height: 280,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Peliculas del Actor',),),
            Expanded(child: ListView.builder(
              itemCount: pelicula!.length,
              itemBuilder: (_, i) {

                final movies = pelicula[i];

                //movie.heroId = '${movie.title}-$i-${widget.movie[i].id}';
                return Container(
                  width: 130,
                  height: 190,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:  FadeInImage(placeholder: const AssetImage('assets/no-image.jpg'), image: NetworkImage(movies.fullPosterImg),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 190,),
                      ),
                      Text(movies.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
              scrollDirection: Axis.horizontal,),)
          ],
        ),
      );}
    );
  }
}
