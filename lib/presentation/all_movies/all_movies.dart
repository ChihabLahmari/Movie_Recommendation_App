// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:movies_clean_architecture_mvvm/domain/model/movie_object.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/color_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/font_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/constants.dart';

class AllMoviesView extends StatefulWidget {
  final List<MovieObject> list;
  final String titel;

  const AllMoviesView({
    Key? key,
    required this.list,
    required this.titel,
  }) : super(key: key);

  @override
  State<AllMoviesView> createState() => _AllMoviesViewState();
}

class _AllMoviesViewState extends State<AllMoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorManager.transparent,
        foregroundColor: ColorManager.white,
        elevation: AppSize.s0,
        title: Text(widget.titel),
      ),
      body: widget.list.isNotEmpty
          ? Container(
              color: ColorManager.primary,
              child: ListView.builder(
                itemCount: widget.list.length,
                itemBuilder: (context, index) {
                  MovieObject movie = widget.list[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.s6, horizontal: AppSize.s10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.movieDetails,
                          arguments: MovieDetailsArguments(movie, widget.list),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          color: ColorManager.darkGrey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSize.s6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                                  child: CachedNetworkImage(
                                    imageUrl: "${Constants.imageUrl}${movie.image}",
                                    height: 150.0,
                                    // width: 50,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Shimmer.fromColors(
                                      baseColor: Colors.grey[850]!,
                                      highlightColor: Colors.grey[800]!,
                                      child: Container(
                                        height: AppSize.s150,
                                        // width: AppSize.s150,
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
                                        // width: AppSize.s150,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSize.s14),
                              Expanded(
                                flex: 4,
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
                                    const SizedBox(height: AppSize.s12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: AppSize.s25,
                                          width: AppSize.s45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s5),
                                            color: ColorManager.red,
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.s14,
                                        height: AppSize.s1_5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(
              color: ColorManager.primary,
              child: Center(
                child: LottieBuilder.asset(
                  JsonAssets.empty,
                  width: AppSize.s250,
                ),
              ),
            ),
    );
  }
}
//
