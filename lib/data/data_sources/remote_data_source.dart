import 'dart:convert';

import 'package:http/http.dart';
import 'package:sampletdd/core/constants/exceptions.dart';
import 'package:sampletdd/core/constants/urls.dart';
import 'package:sampletdd/data/models/movie_model.dart';

//we're using abstraction because it makes testing easier

abstract class MovieRemoteDataSource {
  Future<MovieModel> getMovieDetails(String movieName);
}

// implementation
class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
// in this class we will send request to servers, we'll use http client

  final Client client;
  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<MovieModel> getMovieDetails(String movieName) async {
    final response =
        await client.get(Uri.parse(Urls.movieDetailsbyName(movieName)));

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
