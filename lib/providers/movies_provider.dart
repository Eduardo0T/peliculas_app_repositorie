import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/helpers/debouncer.dart';

import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/search_actor_response.dart';
import 'package:peliculas_app/models/search_response.dart';

class MovieProvider extends ChangeNotifier{
  MovieProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }


  final String _apiKey = 'd0f13e882a5247d6be848af1fbca20f0';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  Map<int,List<Cast>> onCreditsCast = {};
  List<Movie> onPeliculasActor = [];

  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  Future<String> _getJsonData(String endpoint, [int page = 1]) async{
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key' : _apiKey,
      'language': _language,
      'page' : '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async{

    final jsonData = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  Future<List<Movie>>getOnPeliculasActor(actorId) async{

    final jsonData = await _getJsonData('/3/person/$actorId/movie_credits');
    final peliculasActorResponse = PeliculasActor.fromJson(jsonData);

    onPeliculasActor = peliculasActorResponse.cast;

    return onPeliculasActor;
  }

  getPopularMovies() async{
    _popularPage++;

    final jsonData = await _getJsonData('/3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    onPopularMovies = [...onPopularMovies,...popularResponse.results];

    notifyListeners();
  }
  Future<List<Cast>> getCredits(int movieId) async{
    if(onCreditsCast.containsKey(movieId)) return onCreditsCast[movieId]!;

    final jsonData = await _getJsonData('/3/movie/$movieId/credits',);
    final creditsResponse = CredistResponse.fromJson(jsonData);

    onCreditsCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
  Future<Actor> getActors(int actorId) async{
    final jsonData = await _getJsonData('/3/person/$actorId',);
    final actorResponse = Actor.fromJson(jsonData);

    return actorResponse;
  }

  Future<List<Movie>> searchMovies (String query) async {
    var url = Uri.https(_baseUrl, '/3/search/movie', {
      'api_key' : _apiKey,
      'language': _language,
      'query' : query
    });

    final response = await http.get(url);
    final searchResponse = MoviesSearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  Future<List<ActorSearch>> searchActors (String query) async {
    var url = Uri.https(_baseUrl, '/3/search/person', {
      'api_key' : _apiKey,
      'language': _language,
      'query' : query
    });

    final response = await http.get(url);
    final searchActorResponse = SearchActorResponse.fromJson(response.body);
    return searchActorResponse.results;
  }

  void getSuggestionsByQuery( String searchTerm){
    debouncer.value= '';
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);
      //final resul = await searchActors(value);
      _suggestionStreamController.add(results);
     // _suggestionStreamController.add(resul);
    };

    final timer = Timer.periodic( const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
