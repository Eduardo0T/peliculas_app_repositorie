import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';

class MovieSlidere extends StatefulWidget {
  const MovieSlidere({Key? key,required this.movie,required this.onNextPage}) : super(key: key);

  final List<Movie> movie;
  final Function onNextPage;

  @override
  State<MovieSlidere> createState() => _MovieSlidereState();
}

class _MovieSlidereState extends State<MovieSlidere> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Populares',),),
          Expanded(child: ListView.builder(
            controller: scrollController,
            itemCount: widget.movie.length,
            itemBuilder: (_, i) {

              final movies = widget.movie[i];

              movies.heroId = '${movies.title}-$i-${widget.movie[i].id}';
              return Container(
                width: 130,
                height: 190,
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, 'DetailsScreen', arguments: movies);
                      },
                      child: Hero(
                        tag: movies.heroId!,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:  FadeInImage(placeholder: const AssetImage('assets/no-image.jpg'), image: NetworkImage(movies.fullPosterImg),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 190,),
                        ),
                      ),
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
    );
  }
}
