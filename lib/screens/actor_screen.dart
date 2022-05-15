import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/widgets/movie_slider_two.dart';
import 'package:provider/provider.dart';

class ActorScreen extends StatelessWidget {
  const ActorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context,listen: false);
    final Cast actor = ModalRoute.of(context)!.settings.arguments as Cast;
    int actorIds = actor.id;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: movieProvider.getActors(actorIds),
        builder: (_, AsyncSnapshot<Actor> snapshot) {

          if(snapshot.data == null) return const Center(child: CircularProgressIndicator());

          final Actor actores = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(actor.fullProfilePath),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(actores.name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(actores.biography,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),),
              ),
              MovieSliderTwo(actorId: actorIds)
            ],
        ),
          );
        }
      ),
    );
  }
}
