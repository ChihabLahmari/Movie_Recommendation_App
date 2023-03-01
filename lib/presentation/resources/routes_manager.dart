import 'package:flutter/material.dart';
import 'package:movies_clean_architecture_mvvm/domain/model/movie_object.dart';
import 'package:movies_clean_architecture_mvvm/presentation/all_movies/all_movies.dart';
import 'package:movies_clean_architecture_mvvm/presentation/main/view/main_view.dart';
import 'package:movies_clean_architecture_mvvm/presentation/movie_details/movie_details.dart';
import 'package:movies_clean_architecture_mvvm/presentation/splash/splash_view.dart';

import '../../app/di.dart';
import 'app_strings.dart';

class Routes {
  static const String splashRoute = "/";
  static const String mainRoute = "/main";
  static const String allMovies = "/allMovies";
  static const String movieDetails = "/movieDetail";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.mainRoute:
        initMainModel();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.allMovies:
        // List<MovieObject> moviesList = settings.arguments as List<MovieObject>;
        // String title = settings.name as String;
        SeeMoreArguments parameters = settings.arguments as SeeMoreArguments;
        return MaterialPageRoute(
          builder: (_) => AllMoviesView(
            list: parameters.list,
            titel: parameters.title,
          ),
        );
      case Routes.movieDetails:
        MovieDetailsArguments movieDetailsArguments =
            settings.arguments as MovieDetailsArguments;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsView(
            movieObject: movieDetailsArguments.movie,
            moviesList: movieDetailsArguments.moviesList,
          ),
        );
      default:
        return unDefindRoute();
    }
  }

  static Route<dynamic> unDefindRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}

class SeeMoreArguments {
  List<MovieObject> list;
  String title;

  SeeMoreArguments(
    this.list,
    this.title,
  );
}

class MovieDetailsArguments {
  MovieObject movie;
  List<MovieObject> moviesList;

  MovieDetailsArguments(
    this.movie,
    this.moviesList,
  );
}
