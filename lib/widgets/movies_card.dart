import 'package:filmdb_project/constants/url_constant.dart';
import 'package:filmdb_project/providers/movies_provider.dart';
import 'package:filmdb_project/widgets/cached_image.dart';
import 'package:filmdb_project/widgets/movies_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class MoviesCard extends StatelessWidget {
  final dynamic data;
  final bool? isMovies;
  const MoviesCard({Key? key, this.data, this.isMovies = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: InkWell(
        onTap: () {
          context.read<MoviesNotifier>().getDetailMovies(data.id.toString());
          context
              .read<MoviesNotifier>()
              .getRecommendationMovies(data.id.toString());

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const MoviesDetail()));
        },
        child: Ink(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              SizedBox(
                height: 160,
                child: CachedImage(
                    imgUrl: '${UrlConstant.imageUrl}/${data.posterPath}'),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isMovies! ? data.title : data.originalName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 16,
                            ),
                            Text(
                              "${data.voteAverage.toStringAsFixed(1)}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )
                          ]),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.green[300],
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              isMovies!
                                  ? data.releaseDate.substring(0, 4)
                                  : data.firstAirDate.substring(0, 4),
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
