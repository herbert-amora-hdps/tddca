import 'package:dartz/dartz.dart';
import 'package:sampletdd/core/constants/exceptions.dart';
import 'package:sampletdd/core/error/failure.dart';
import 'package:sampletdd/data/data_sources/remote_data_source.dart';
import 'package:sampletdd/domain/entities/movie.dart';
import 'package:sampletdd/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoryImpl({required this.movieRemoteDataSource});

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetails(String movieName) async {
    try {
      final result = await movieRemoteDataSource.getMovieDetails(movieName);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occured'));
    }
  }
}
