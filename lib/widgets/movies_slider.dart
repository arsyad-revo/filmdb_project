import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmdb_project/constants/url_constant.dart';
import 'package:filmdb_project/widgets/cached_image.dart';
import 'package:filmdb_project/widgets/movies_detail.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class MoviesSlider extends StatelessWidget {
  final List<dynamic>? data;
  MoviesSlider({Key? key, this.data}) : super(key: key);

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = data!
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  context
                      .read<MoviesNotifier>()
                      .getDetailMovies(item.id.toString());
                  context
                      .read<MoviesNotifier>()
                      .getRecommendationMovies(item.id.toString());

                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const MoviesDetail()));
                },
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        CachedImage(
                          imgUrl:
                              "${UrlConstant.imageUrl}/${item.backdropPath}",
                          radius: 5,
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '${item.title}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return Column(children: [
      Expanded(
        child: CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {}),
        ),
      ),
    ]);
  }
}
