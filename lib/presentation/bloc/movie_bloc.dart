import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sampletdd/domain/usecases/get_movie_details.dart';
import 'package:sampletdd/presentation/bloc/movie_event.dart';
import 'package:sampletdd/presentation/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;
  MovieBloc(this._getMovieDetailsUseCase) : super(MovieEmpty()) {
    on<OnMovieChanged>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getMovieDetailsUseCase.execute(event.movieName);
        result.fold(
          (failure) {
            emit(MovieLoadFailure(failure.message));
          },
          (data) {
            emit(MovieLoaded(data));
          },
        );
      },
      // tip: we want to use Transformers in event handler
      // this dictate how the events are being processed within a bloc
      // They can help reduce boilerplate code and keep your code organized.
      // very useful for events that needs to be debounced
      // since they that are bound to be spammed with input characters like search functions or calling search APIs
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
