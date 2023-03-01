// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieObject {
  int id;
  String title;
  String image;
  String releaseDate;
  double rated;
  String overview;
  List<int> genreIds;

  MovieObject({
    required this.id,
    required this.title,
    required this.image,
    required this.releaseDate,
    required this.rated,
    required this.overview,
    required this.genreIds,
  });
}
