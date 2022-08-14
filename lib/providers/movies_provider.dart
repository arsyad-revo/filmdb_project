import 'package:filmdb_project/constants/url_constant.dart';
import 'package:filmdb_project/models/basic_response_model.dart';
import 'package:filmdb_project/models/movies_model.dart';
import 'package:filmdb_project/services/api_service.dart';
import 'package:flutter/foundation.dart';

class MoviesNotifier with ChangeNotifier {
  bool? loadRecommendation = false;
  bool? loadNowPlaying = false;
  bool? loadPopular = false;
  bool? loadTop = false;
  bool? loadDetail = false;
  bool? loadSearch = false;

  Movies? movie;
  List<Movies>? recommendationMovies = [];
  List<Movies>? popularMovies = [];
  List<Movies>? nowPlayingMovies = [];
  List<Movies>? topRatedMovies = [];
  List<Movies>? searchedMovies = [];

  BasicResponse playNowResult = BasicResponse();
  BasicResponse popularResult = BasicResponse();
  BasicResponse topRatedResult = BasicResponse();
  BasicResponse recommendationResult = BasicResponse();
  BasicResponse detailResult = BasicResponse();
  BasicResponse searchedResult = BasicResponse();

  Future<BasicResponse> getNowPlayingMovies() async {
    loadNowPlaying = true;
    playNowResult = BasicResponse();
    try {
      final response = await APIService.getData(
          "${UrlConstant.baseUrl}/movie/now_playing?api_key=${UrlConstant.apiKey}");

      nowPlayingMovies?.clear();
      playNowResult = response;
      if (response.statusCode == 200) {
        for (var item in response.data!['results']) {
          nowPlayingMovies?.add(Movies.fromJson(item));
        }
      }
      loadNowPlaying = false;
      notifyListeners();
      return playNowResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      loadNowPlaying = false;
      notifyListeners();
      return playNowResult;
    }
  }

  Future<BasicResponse> getPopularMovies() async {
    loadPopular = true;
    popularResult = BasicResponse();
    try {
      final response = await APIService.getData(
          "${UrlConstant.baseUrl}/movie/popular?api_key=${UrlConstant.apiKey}");

      popularMovies?.clear();
      popularResult = response;
      if (response.statusCode == 200) {
        for (var item in response.data!['results']) {
          popularMovies?.add(Movies.fromJson(item));
        }
      }
      loadPopular = false;
      notifyListeners();
      return popularResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      loadPopular = false;
      notifyListeners();
      return popularResult;
    }
  }

  Future<BasicResponse> getTopRatedMovies() async {
    loadTop = true;
    topRatedResult = BasicResponse();
    try {
      final response = await APIService.getData(
          "${UrlConstant.baseUrl}/movie/top_rated?api_key=${UrlConstant.apiKey}");

      topRatedMovies?.clear();
      topRatedResult = response;
      if (response.statusCode == 200) {
        for (var item in response.data!['results']) {
          topRatedMovies?.add(Movies.fromJson(item));
        }
      }
      loadTop = false;
      notifyListeners();
      return topRatedResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      loadTop = false;
      notifyListeners();
      return topRatedResult;
    }
  }

  Future<BasicResponse> getDetailMovies(String? movieId) async {
    loadDetail = true;
    detailResult = BasicResponse();
    try {
      final response = await APIService.getData(
          "${UrlConstant.baseUrl}/movie/$movieId?api_key=${UrlConstant.apiKey}");

      detailResult = response;
      if (response.statusCode == 200) {
        movie = Movies.fromJson(response.data!);
      }
      loadDetail = false;
      notifyListeners();
      return detailResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      loadDetail = false;
      notifyListeners();
      return detailResult;
    }
  }

  Future<BasicResponse> getRecommendationMovies(String? movieId) async {
    loadRecommendation = true;
    recommendationResult = BasicResponse();
    try {
      final response = await APIService.getData(
          "${UrlConstant.baseUrl}/movie/$movieId/recommendations?api_key=${UrlConstant.apiKey}");

      recommendationMovies?.clear();
      recommendationResult = response;
      if (response.statusCode == 200) {
        for (var item in response.data!['results']) {
          recommendationMovies?.add(Movies.fromJson(item));
        }
      }
      loadRecommendation = false;
      notifyListeners();
      return recommendationResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      loadRecommendation = false;
      notifyListeners();
      return recommendationResult;
    }
  }

  Future<BasicResponse> getSearchedMovies(String? query) async {
    loadSearch = true;
    searchedResult = BasicResponse();
    try {
      final response = await APIService.getData(
          "${UrlConstant.baseUrl}/search/movie?query=$query?api_key=${UrlConstant.apiKey}");

      searchedMovies?.clear();
      searchedResult = response;
      if (response.statusCode == 200) {
        for (var item in response.data!['results']) {
          searchedMovies?.add(Movies.fromJson(item));
        }
      }
      loadSearch = false;
      notifyListeners();
      return searchedResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      loadSearch = false;
      notifyListeners();
      return searchedResult;
    }
  }
}
