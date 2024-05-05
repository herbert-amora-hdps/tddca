import 'package:dartz/dartz.dart';
import 'package:sampletdd/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Error, MovieEntity>> getMovieDetails(String movieName);
}
