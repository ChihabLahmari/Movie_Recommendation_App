// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieResponse {
  int? id;
  String? title;
  String? image;
  String? releaseDate;
  double? rated;
  String? overview;
  List<int>? genreIds;

  MovieResponse({
    this.id,
    this.title,
    this.image,
    this.releaseDate,
    this.rated,
    this.overview,
    this.genreIds,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        id: json["id"],
        title: json["original_title"],
        image: json["backdrop_path"],
        releaseDate: json["release_date"],
        rated: json["vote_average"].toDouble(),
        overview: json["overview"],
        genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
      );
}
