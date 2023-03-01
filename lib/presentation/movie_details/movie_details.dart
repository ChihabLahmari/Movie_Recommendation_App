// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

import 'package:movies_clean_architecture_mvvm/data/network/offline_movies.dart';
import 'package:movies_clean_architecture_mvvm/domain/model/movie_object.dart';

import '../../app/constants.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class MovieDetailsView extends StatefulWidget {
  final MovieObject movieObject;
  final List<MovieObject> moviesList;

  const MovieDetailsView({
    Key? key,
    required this.movieObject,
    required this.moviesList,
  }) : super(key: key);

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  Widget build(BuildContext context) {
    MovieObject movie = widget.movieObject;
    List<MovieObject> list = widget.moviesList;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorManager.transparent,
        foregroundColor: ColorManager.white,
        elevation: AppSize.s0,
      ),
      body: Container(
        height: double.infinity,
        color: ColorManager.primary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: "${Constants.imageUrl}${movie.image}",
                height: AppSize.s350,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: AppSize.s150,
                    width: AppSize.s100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: AppSize.s150,
                    width: AppSize.s100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s12),
              Padding(
                padding: const EdgeInsets.all(AppSize.s10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                        fontSize: AppSize.s20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSize.s14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: AppSize.s25,
                          width: AppSize.s45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s5),
                            color: ColorManager.darkGrey,
                          ),
                          child: Center(
                            child: Text(
                              movie.releaseDate.substring(0, 4),
                              style: TextStyle(
                                color: ColorManager.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s12),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: AppSize.s18,
                        ),
                        const SizedBox(width: AppSize.s5),
                        Text(
                          movie.rated.toString(),
                          style: TextStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s14),
                    Text(
                      movie.overview,
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: FontSize.s14,
                        height: AppSize.s1_5,
                      ),
                    ),
                    const SizedBox(height: AppSize.s20),
                    Text(
                      "More Like This".toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                        fontSize: AppSize.s20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSize.s20),
                    GridView.count(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: (120 / 170),
                      controller: ScrollController(keepScrollOffset: false),
                      children: List.generate(
                        list.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.movieDetails,
                                arguments:
                                    MovieDetailsArguments(list[index], list),
                              );
                            },
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${Constants.imageUrl}${list[index].image}",
                                width: 120.0,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    height: 170.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    height: 170.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
