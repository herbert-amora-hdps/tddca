import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class OnMovieChanged extends MovieEvent {
  final String movieName;

  const OnMovieChanged(this.movieName);

  @override
  List<Object?> get props => [movieName];
}
