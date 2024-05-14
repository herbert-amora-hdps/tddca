import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sampletdd/core/constants/exceptions.dart';
import 'package:sampletdd/core/error/failure.dart';
import 'package:sampletdd/data/models/movie_model.dart';
import 'package:sampletdd/data/repositories/movie_repository_impl.dart';
import 'package:sampletdd/domain/entities/movie.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late MovieRepositoryImpl movieRepositoryImpl;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    movieRepositoryImpl =
        MovieRepositoryImpl(movieRemoteDataSource: mockMovieRemoteDataSource);
  });

  const testMovieModel = MovieModel(
    title: "The Avengers",
    year: "2012",
    rated: "PG-13",
    released: "04 May 2012",
    runtime: "143 min",
    genre: "Action, Sci-Fi",
    director: "Joss Whedon",
  );

  const testMovieEntity = MovieEntity(
    title: "The Avengers",
    year: "2012",
    rated: "PG-13",
    released: "04 May 2012",
    runtime: "143 min",
    genre: "Action, Sci-Fi",
    director: "Joss Whedon",
  );

  const testMovieName = 'Avengers';

  group('get movie details', () {
    test(
      'should return movie details when a call to data source is successful',
      () async {
        // arrange
        when(mockMovieRemoteDataSource.getMovieDetails(testMovieName))
            .thenAnswer((_) async => testMovieModel);

        // act

        final result = await movieRepositoryImpl.getMovieDetails(testMovieName);

        // assert
        expect(result, const Right(testMovieEntity));
      },
    );

    test(
      'should return an exception when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockMovieRemoteDataSource.getMovieDetails(testMovieName))
            .thenThrow(ServerException());

        // act
        final result = await movieRepositoryImpl.getMovieDetails(testMovieName);

        // assert
        expect(result, const Left(ServerFailure('An error has occured')));
      },
    );
  });
}
