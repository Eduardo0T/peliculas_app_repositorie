
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas_app/models/models.dart';

class CustomCardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CustomCardSwiper({Key? key,required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(movies.isEmpty){
      return SizedBox(
        width: double.infinity,
        height: size.height * .5,
        child: const CircularProgressIndicator(),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * .5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemHeight: size.height * .4,
        itemWidth: size.width * .6,
        itemBuilder: (context, i){
          final movie = movies[i];

          movie.heroId = 'swiper ${movie.id}';

          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'DetailsScreen',arguments: movie);
            },
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
