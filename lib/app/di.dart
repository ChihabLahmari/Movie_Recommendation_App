import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_clean_architecture_mvvm/data/data_source/remote_data_source.dart';
import 'package:movies_clean_architecture_mvvm/data/network/network_info.dart';
import 'package:movies_clean_architecture_mvvm/data/repository/repository_impl.dart';
import 'package:movies_clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:movies_clean_architecture_mvvm/domain/usecase/now_playing_usecase.dart';
import 'package:movies_clean_architecture_mvvm/domain/usecase/popular_usecase.dart';
import 'package:movies_clean_architecture_mvvm/domain/usecase/top_rated_usecase.dart';
import 'package:movies_clean_architecture_mvvm/presentation/main/viewmodel/main_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker()),
  );

  instance
      .registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initMainModel() {
  if (!GetIt.I.isRegistered<NowPlayingUseCase>()) {
    instance.registerFactory<NowPlayingUseCase>(
        () => NowPlayingUseCase(instance()));
    instance.registerFactory<PopularUseCase>(() => PopularUseCase(instance()));
    instance
        .registerFactory<TopRatedUseCase>(() => TopRatedUseCase(instance()));

    instance.registerFactory<MainViewModel>(
        () => MainViewModel(instance(), instance(), instance()));
  }
}
