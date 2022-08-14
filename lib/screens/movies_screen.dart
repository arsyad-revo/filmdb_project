import 'package:filmdb_project/providers/movies_provider.dart';
import 'package:filmdb_project/screens/search_screen.dart';
import 'package:filmdb_project/themes/app_theme.dart';
import 'package:filmdb_project/widgets/alert_widget.dart';
import 'package:filmdb_project/widgets/movies_card.dart';
import 'package:filmdb_project/widgets/movies_slider.dart';
import 'package:filmdb_project/widgets/shimmer_card.dart';
import 'package:filmdb_project/widgets/shimmer_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    _loadNowPlay();
    _loadTopRated();
    _loadPopular();
  }

  _loadNowPlay() {
    context.read<MoviesNotifier>().getNowPlayingMovies();
  }

  _loadTopRated() {
    context.read<MoviesNotifier>().getTopRatedMovies();
  }

  _loadPopular() {
    context.read<MoviesNotifier>().getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Movies",
          style: TextStyle(color: Colors.green[300]),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.topToBottom,
                        child: const SearchScreen()));
              },
              icon: Icon(
                Icons.search_rounded,
                color: Colors.green[300],
              )),
          Consumer<AppTheme>(
            builder: (context, value, child) {
              if (value.isDarkMode) {
                return IconButton(
                    onPressed: () {
                      value.setThemeMode();
                    },
                    icon: Icon(
                      Icons.dark_mode_outlined,
                      color: Colors.green[300],
                    ));
              }
              return IconButton(
                  onPressed: () {
                    value.setThemeMode();
                  },
                  icon: Icon(
                    Icons.light_mode_outlined,
                    color: Colors.green[300],
                  ));
            },
          )
        ],
      ),
      body: ListView(
        physics: const ScrollPhysics(),
        children: [
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.movie_filter,
                        color: Colors.green[300],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "NOW PLAYING",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  )),
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Consumer<MoviesNotifier>(
                    builder: (context, value, child) {
                      if (value.loadNowPlaying!) {
                        return ShimmerSlider();
                      }
                      if (value.playNowResult.statusCode == 502 &&
                          !value.loadNowPlaying!) {
                        return AlertWidget(
                          onPressed: _loadNowPlay,
                        );
                      }
                      return MoviesSlider(data: value.nowPlayingMovies);
                    },
                  )),
            ],
          ),
          Container(
            color: Colors.green[300],
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "TOP RATED MOVIES",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
                AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Consumer<MoviesNotifier>(
                      builder: (context, value, child) {
                        if (value.loadTop!) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const ShimmerCard();
                            },
                          );
                        }
                        if (value.topRatedResult.statusCode == 502 &&
                            !value.loadTop!) {
                          return AlertWidget(
                            onPressed: _loadTopRated,
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: value.topRatedMovies?.length,
                          itemBuilder: (context, index) {
                            return MoviesCard(
                              data: value.topRatedMovies![index],
                            );
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                child: const Text(
                  "POPULAR MOVIES",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Consumer<MoviesNotifier>(
                    builder: (context, value, child) {
                      if (value.loadPopular!) {
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return const ShimmerCard();
                          },
                        );
                      }
                      if (value.popularResult.statusCode == 502 &&
                          !value.loadPopular!) {
                        return AlertWidget(
                          onPressed: _loadPopular,
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: value.popularMovies?.length,
                        itemBuilder: (context, index) {
                          return MoviesCard(
                            data: value.popularMovies![index],
                          );
                        },
                      );
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
