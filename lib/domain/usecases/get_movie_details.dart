import 'package:dartz/dartz.dart';
import 'package:sampletdd/domain/entities/movie.dart';
import 'package:sampletdd/domain/repositories/movie_repository.dart';

class GetMovieDetailsUseCase {
  final MovieRepository movieRepository;

  const GetMovieDetailsUseCase(this.movieRepository);

  Future<Either<Error, MovieEntity>> execute(String movieName) {
    return movieRepository.getMovieDetails(movieName);
  }
}
