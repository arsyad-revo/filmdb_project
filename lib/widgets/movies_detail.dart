import 'package:filmdb_project/constants/url_constant.dart';
import 'package:filmdb_project/providers/movies_provider.dart';
import 'package:filmdb_project/widgets/cached_image.dart';
import 'package:filmdb_project/widgets/movies_card.dart';
import 'package:filmdb_project/widgets/shimmer_card.dart';
import 'package:filmdb_project/widgets/shimmer_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/convert_time_util.dart';

class MoviesDetail extends StatelessWidget {
  const MoviesDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.chevron_left,
              color: Colors.green[300]!,
            ),
          )),
      body: Consumer<MoviesNotifier>(
        builder: (context, value, child) {
          if (value.loadDetail!) {
            return const ShimmerDetail();
          }
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.height * 0.3,
                    child: CachedImage(
                      imgUrl:
                          "${UrlConstant.imageUrl}${value.movie!.posterPath}",
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "${value.movie!.title}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "${value.movie!.genre!.join(", ")}\n${value.movie!.releaseDate!.substring(0, 4)} | ${getTimeString(value.movie!.runtime!)}",
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 25,
                            ),
                            Text(
                              value.movie!.voteAverage!.toStringAsFixed(1),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${value.movie!.voteCount!} Ratings",
                              style: const TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            )
                          ]),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Overview",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("${value.movie!.overview}"),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              "RECOMMENDATIONS",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          AspectRatio(
                              aspectRatio: 7 / 6,
                              child: Consumer<MoviesNotifier>(
                                builder: (context, value, child) {
                                  if (value.loadRecommendation!) {
                                    return ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return const ShimmerCard();
                                      },
                                    );
                                  }
                                  return ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        value.recommendationMovies?.length,
                                    itemBuilder: (context, index) {
                                      return MoviesCard(
                                        data:
                                            value.recommendationMovies![index],
                                      );
                                    },
                                  );
                                },
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
