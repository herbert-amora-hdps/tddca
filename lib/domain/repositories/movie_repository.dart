import 'package:dartz/dartz.dart';
import 'package:sampletdd/core/error/failure.dart';
import 'package:sampletdd/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieEntity>> getMovieDetails(String movieName);
}
