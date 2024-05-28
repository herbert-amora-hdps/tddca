import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sampletdd/domain/entities/movie.dart';
import 'package:sampletdd/domain/usecases/get_movie_details.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  // To define the objects that we need in this USECASE test we define a late variable
  late GetMovieDetailsUseCase getMovieDetailsUseCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getMovieDetailsUseCase = GetMovieDetailsUseCase(mockMovieRepository);
  });

  // to test if the usecase gets the detail from the repository or not
  // the data doesnt matter since this is a mock data to be passed through the usecase
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

  test(
    'should get movie details from the movie repository',
    () async {
      // arrange
      when(mockMovieRepository.getMovieDetails(testMovieName))
          .thenAnswer((_) async => const Right(testMovieEntity));
      // act
      final result = await getMovieDetailsUseCase.execute(testMovieName);
      // assert
      expect(result, const Right(testMovieEntity));
    },
  );
}
