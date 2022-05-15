// To parse this JSON data, do
//
//     final searchActorResponse = searchActorResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_app/models/models.dart';

class SearchActorResponse {
  SearchActorResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<ActorSearch> results;
  int totalPages;
  int totalResults;

  factory SearchActorResponse.fromJson(String str) => SearchActorResponse.fromMap(json.decode(str));


  factory SearchActorResponse.fromMap(Map<String, dynamic> json) => SearchActorResponse(
    page: json["page"],
    results: List<ActorSearch>.from(json["results"].map((x) => ActorSearch.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}

class ActorSearch {
  ActorSearch({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    this.profilePath,
  });

  bool adult;
  int gender;
  int id;
  List<Movie> knownFor;
  String knownForDepartment;
  String name;
  double popularity;
  String? profilePath;

  factory ActorSearch.fromJson(String str) => ActorSearch.fromMap(json.decode(str));

  factory ActorSearch.fromMap(Map<String, dynamic> json) => ActorSearch(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownFor: List<Movie>.from(json["known_for"].map((x) => Movie.fromMap(x))),
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"],
  );

  get fullProfilePath{
    if(profilePath != null)return 'https://image.tmdb.org/t/p/w500$profilePath';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }
}