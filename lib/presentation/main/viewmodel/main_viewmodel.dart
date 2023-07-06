// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:movies_clean_architecture_mvvm/domain/usecase/popular_usecase.dart';
import 'package:movies_clean_architecture_mvvm/domain/usecase/top_rated_usecase.dart';
import 'package:rxdart/subjects.dart';

import 'package:movies_clean_architecture_mvvm/domain/model/movie_object.dart';
import 'package:movies_clean_architecture_mvvm/domain/usecase/now_playing_usecase.dart';
import 'package:movies_clean_architecture_mvvm/presentation/base/base_viewmodel.dart';
import 'package:movies_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:movies_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';

class MainViewModel extends BaseViewModel
    with MainViewModelInputs, MainViewModelOutputs {
  final NowPlayingUseCase _nowPlayingUseCase;
  final PopularUseCase _popularUseCase;
  final TopRatedUseCase _topRatedUseCase;
  MainViewModel(
      this._nowPlayingUseCase, this._popularUseCase, this._topRatedUseCase);

  final StreamController _nowPlayingStreamController =
      BehaviorSubject<List<MovieObject>>();

  final StreamController _popularStreamController =
      BehaviorSubject<List<MovieObject>>();

  final StreamController _topRatedStreamController =
      BehaviorSubject<List<MovieObject>>();

  @override
  void start() {
    _getNowPlaying();
    _getPopular();
    _getTopRated();
  }

  _getNowPlaying() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _nowPlayingUseCase.execute()).fold(
      (failure) {
        inputState.add(
          ErrorState(
            StateRendererType.fullScreenErrorState,
            failure.message,
          ),
        );
        print("🛑error now playing failure🛑");
        print(failure.message);
      },
      (data) {
        inputState.add(
          ContentState(),
        );
        inputNowPlayingmovies.add(data);
        print("✅get now playing success✅");
        // for (var i = 0; i < data.length; i++) {
        //   print(data[i].title);
        // }
      },
    );
  }

  _getPopular() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _popularUseCase.execute()).fold(
      (failure) {
        print("🛑error popular failure🛑");

        inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      },
      (data) {
        print("✅get now popular success✅");

        inputPopular.add(data);
        inputState.add(ContentState());
      },
    );
  }

  _getTopRated() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _topRatedUseCase.execute()).fold(
      (failure) {
        print("🛑error top rated failure🛑");

        inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      },
      (data) {
        print("✅get top rated success✅");

        inputTopRated.add(data);
        inputState.add(ContentState());
      },
    );
  }

  @override
  void dispose() {
    _nowPlayingStreamController.close();
    _popularStreamController.close();
    _topRatedStreamController.close();
  }

  // INPUTS ::
  @override
  Sink get inputNowPlayingmovies => _nowPlayingStreamController.sink;

  @override
  Sink get inputPopular => _popularStreamController.sink;

  @override
  Sink get inputTopRated => _topRatedStreamController.sink;

  // OUTPUTS ::
  @override
  Stream<List<MovieObject>> get outputNowPlayingMovies =>
      _nowPlayingStreamController.stream.map((allMovies) => allMovies);

  @override
  Stream<List<MovieObject>> get outputPopularMovies =>
      _popularStreamController.stream.map((event) => event);

  @override
  Stream<List<MovieObject>> get outputRopRatedMovies =>
      _topRatedStreamController.stream.map((event) => event);
}

abstract class MainViewModelInputs {
  Sink get inputNowPlayingmovies;
  Sink get inputPopular;
  Sink get inputTopRated;
}

abstract class MainViewModelOutputs {
  Stream<List<MovieObject>> get outputNowPlayingMovies;
  Stream<List<MovieObject>> get outputPopularMovies;
  Stream<List<MovieObject>> get outputRopRatedMovies;
}
