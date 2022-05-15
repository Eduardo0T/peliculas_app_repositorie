import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/theme/theme.dart';
import 'package:provider/provider.dart';
void main(){
  runApp( const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> MovieProvider(),lazy: false,)
    ],
    child: const MyApp(),);
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'HomeScreen',
      routes: {
        'HomeScreen' : (_) => const HomeScreen(),
        'DetailsScreen' : (_) => const DetailsScreen(),
        'ActorScreen' : (_) => const ActorScreen()
      },
      theme: MyAppThemes.customLightTheme,
    );
  }
}


