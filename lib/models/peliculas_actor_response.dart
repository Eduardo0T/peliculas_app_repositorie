// To parse this JSON data, do
//
//     final peliculasActor = peliculasActorFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_app/models/models.dart';

class PeliculasActor {
  PeliculasActor({
    required this.cast,
    required this.crew,
    required this.id,
  });

  List<Movie> cast;
  List<Movie> crew;
  int id;

  factory PeliculasActor.fromJson(String str) => PeliculasActor.fromMap(json.decode(str));

  factory PeliculasActor.fromMap(Map<String, dynamic> json) => PeliculasActor(
    cast: List<Movie>.from(json["cast"].map((x) => Movie.fromMap(x))),
    crew: List<Movie>.from(json["crew"].map((x) => Movie.fromMap(x))),
    id: json["id"],
  );
}
