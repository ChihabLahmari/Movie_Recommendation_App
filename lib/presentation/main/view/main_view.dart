
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_clean_architecture_mvvm/app/constants.dart';
import 'package:movies_clean_architecture_mvvm/app/di.dart';
import 'package:movies_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movies_clean_architecture_mvvm/presentation/main/viewmodel/main_viewmodel.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/constants.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:movies_clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/network/offline_movies.dart';
import '../../resources/color_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainViewModel _viewModel = instance<MainViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _getContentWidget(),
                () {
                  _bind();
                },
              ) ??
              _getContentWidget();
        },
      ),
    );
  }

  _getContentWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          carouselSliderWidget(),
          popularlistViewWidget(),
          topRatedlistViewWidget(),
        ],
      ),
    );
  }

  Widget carouselSliderWidget() {
    return StreamBuilder(
      stream: _viewModel.outputNowPlayingMovies,
      builder: (context, snapshot) {
        return CarouselSlider(
          options: CarouselOptions(
            height: AppSize.s400,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(
              seconds: AppConstants.autoPlayDelay,
            ),
            onPageChanged: (index, reason) {},
          ),
          items: snapshot.data?.map(
                (item) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.movieDetails,
                        arguments: MovieDetailsArguments(item, snapshot.data!),
                      );
                    },
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                // fromLTRB
                                Colors.transparent,
                                Colors.black,
                                Colors.black,
                                Colors.transparent,
                              ],
                              stops: [0, 0.3, 0.5, 1],
                            ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn, 
                          // child: Image.network(
                          //   '${Constants.imageUrl}${item.image}',
                          //   height: AppSize.s550,
                          //   fit: BoxFit.cover,
                          // ),
                          child: CachedNetworkImage(
                            imageUrl: "${Constants.imageUrl}${item.image}",
                            height: AppSize.s400,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: AppSize.s400,
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
                                height: AppSize.s400,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: ColorManager.red,
                                    size: 16.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    'Now Playing'.toUpperCase(),
                                    style: TextStyle(
                                      color: ColorManager.white,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                item.title,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ColorManager.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ).toList() ??
              offlineMovies.map(
                (item) {
                  return Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              // fromLTRB
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0, 0.3, 0.5, 1],
                          ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: CachedNetworkImage(
                          imageUrl: "${Constants.imageUrl}${item.image}",
                          height: AppSize.s400,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[850]!,
                            highlightColor: Colors.grey[800]!,
                            child: Container(
                              height: AppSize.s400,
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
                              height: AppSize.s400,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: ColorManager.red,
                                    size: 16.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    'Now Playing'.toUpperCase(),
                                    style: TextStyle(
                                      color: ColorManager.white,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorManager.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
        );
      },
    );
  }

  Widget popularlistViewWidget() {
    return StreamBuilder(
      stream: _viewModel.outputPopularMovies,
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 20.0, 8.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style: TextStyle(
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.allMovies,
                          arguments: SeeMoreArguments(
                            snapshot.data!,
                            "Popular Movies",
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'See More',
                            style: TextStyle(
                              color: ColorManager.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w100,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s1_5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: ColorManager.red,
                            size: 16.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 170.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final movie = snapshot.data?[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.movieDetails,
                        arguments:
                            MovieDetailsArguments(movie!, snapshot.data!),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        child: CachedNetworkImage(
                          imageUrl: "${Constants.imageUrl}${movie?.image}",
                          width: 120.0,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
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
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget topRatedlistViewWidget() {
    return StreamBuilder(
      stream: _viewModel.outputRopRatedMovies,
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 20.0, 8.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Rated",
                    style: TextStyle(
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.allMovies,
                          arguments: SeeMoreArguments(
                              snapshot.data!, "Top Rated Movies"),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'See More',
                            style: TextStyle(
                              color: ColorManager.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w100,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s1_5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: ColorManager.red,
                            size: 16.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 170.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final movie = snapshot.data?[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.movieDetails,
                        arguments:
                            MovieDetailsArguments(movie!, snapshot.data!),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        child: CachedNetworkImage(
                          imageUrl: "${Constants.imageUrl}${movie?.image}",
                          width: 120.0,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
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
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
