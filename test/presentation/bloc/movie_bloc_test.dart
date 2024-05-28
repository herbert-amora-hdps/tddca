import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sampletdd/core/error/failure.dart';
import 'package:sampletdd/domain/entities/movie.dart';
import 'package:sampletdd/presentation/bloc/movie_bloc.dart';
import 'package:sampletdd/presentation/bloc/movie_event.dart';
import 'package:sampletdd/presentation/bloc/movie_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetMovieDetailsUseCase mockGetMovieDetailsUseCase;
  late MovieBloc movieBloc;

  setUp(() {
    mockGetMovieDetailsUseCase = MockGetMovieDetailsUseCase();
    movieBloc = MovieBloc(mockGetMovieDetailsUseCase);
  });

  const testMovieEntity = MovieEntity(
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

  const testMovieName = 'Avengers';

  test('initial state should be empty', () {
    expect(movieBloc.state, MovieEmpty());
  });

  blocTest<MovieBloc, MovieState>(
      'should emit [MovieLoading, MovieLoaded] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetailsUseCase.execute(testMovieName))
            .thenAnswer((_) async => const Right(testMovieEntity));
        return movieBloc;
      },
      act: (bloc) => bloc.add(const OnMovieChanged(testMovieName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), const MovieLoaded(testMovieEntity)]);

  blocTest<MovieBloc, MovieState>(
      'should emit [MovieLoading, MovieLoadFailure] when get data is unsuccessful',
      build: () {
        when(mockGetMovieDetailsUseCase.execute(testMovieName)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return movieBloc;
      },
      act: (bloc) => bloc.add(const OnMovieChanged(testMovieName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            MovieLoading(),
            const MovieLoadFailure('Server failure'),
          ]);
}
