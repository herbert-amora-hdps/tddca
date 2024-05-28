import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampletdd/data/models/movie_model.dart';
import 'package:sampletdd/domain/entities/movie.dart';

const testMovieModel = MovieModel(
  title: "The Avengers",
  year: "2012",
  rated: "PG-13",
  released: "04 May 2012",
  runtime: "143 min",
  genre: "Action, Sci-Fi",
  director: "Joss Whedon",
  poster:
      "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
);

void main() {
  // will be added later when calling rootBundle
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'should be a subclass of movie entity',
    () {
      //Since we're only testing a class type, no need for a setup and action
      //we can only compare it through an expect method with an 'isA' typematcher

      //assert
      expect(testMovieModel, isA<MovieEntity>());
    },
  );

  test(
    'should return a valid model from json',
    () async {
      // We'll use a dummy json data that we will create as a test asset
      // we need to add and declare the dummy_data folder as an asset in the pubspec.yaml file
      // for use to load the jsonDate and convert to map, we'll use the loadstring method of flutter services

      // arrange
      final String jsonString = await rootBundle
          .loadString('test/helpers/dummy_data/dummy_movie_response.json');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      // act
      final result = MovieModel.fromJson(jsonMap);

      // assert
      expect(result, testMovieModel);
    },
  );

  test(
    'should return a json map with the proper data',
    () {
      // arrange
      final testMovieJsonMap = {
        'Title': "The Avengers",
        'Year': "2012",
        'Rated': "PG-13",
        'Released': "04 May 2012",
        'Runtime': "143 min",
        'Genre': "Action, Sci-Fi",
        'Director': "Joss Whedon",
        'Poster':
            "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
      };

      // act
      final result = testMovieModel.toJson();

      // assert
      expect(result, testMovieJsonMap);
    },
  );
}
