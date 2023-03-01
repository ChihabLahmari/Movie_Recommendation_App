import 'package:movies_clean_architecture_mvvm/app/constants.dart';
import 'package:movies_clean_architecture_mvvm/app/extensions.dart';
import 'package:movies_clean_architecture_mvvm/data/response/movie_response.dart';
import 'package:movies_clean_architecture_mvvm/domain/model/movie_object.dart';

extension ListIntMapper on List<int>? {
  List<int> toDomain() {
    return this?.map((e) => e.orZero()).toList() ?? Constants.zeroList;
  }
}

extension MovieResponseMapper on MovieResponse? {
  MovieObject toDomain() {
    return MovieObject(
      id: this?.id.orZero() ?? Constants.zero,
      title: this?.title.orEmpty() ?? Constants.empty,
      image: this?.image.orEmpty() ?? Constants.empty,
      releaseDate: this?.releaseDate.orEmpty() ?? Constants.empty,
      rated: this?.rated.orZeroDouble() ?? Constants.zeroDouble,
      overview: this?.overview.orEmpty() ?? Constants.empty,
      genreIds: this?.genreIds.toDomain() ?? Constants.zeroList,
    );
  }
}
