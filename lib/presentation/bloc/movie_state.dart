import 'package:equatable/equatable.dart';
import 'package:sampletdd/domain/entities/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MovieEntity result;

  const MovieLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class MovieLoadFailed extends MovieState {
  final String message;

  const MovieLoadFailed(this.message);

  @override
  List<Object?> get props => [message];
}
