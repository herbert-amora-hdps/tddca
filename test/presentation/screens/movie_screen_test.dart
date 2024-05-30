import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sampletdd/domain/entities/movie.dart';
import 'package:sampletdd/presentation/bloc/movie_bloc.dart';
import 'package:sampletdd/presentation/bloc/movie_event.dart';
import 'package:sampletdd/presentation/bloc/movie_state.dart';
import 'package:sampletdd/presentation/screens/movie_screen.dart';
import 'package:sampletdd/presentation/widgets/detail_widget.dart';

// Using bloc_test's MockBloc class, we will be creating a MockMovieBloc
// that implements our MovieBloc class to be tested and created
class MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

void main() {
  late MockMovieBloc mockMovieBloc;

  setUp(() {
    mockMovieBloc = MockMovieBloc();

    // to fix 3rd test error
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieBloc>(
      create: (context) => mockMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

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

// start here
// we will describe our widget test based on the UI requirements and state changes

  testWidgets(
    'text field should trigger state to change from empty to loading',
    (widgetTester) async {
      //arrange
      when(() => mockMovieBloc.state).thenReturn(MovieEmpty());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const MovieScreen()));
      Finder textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);
      await widgetTester.enterText(textFieldFinder, 'Avengers');
      await widgetTester.pump();
      expect(find.text('Avengers'), findsOneWidget);
    },
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      //arrange
      when(() => mockMovieBloc.state).thenReturn(MovieLoading());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const MovieScreen()));

      //assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should show widget contain movie data when state is movie loaded',
    (widgetTester) async {
      //arrange
      when(() => mockMovieBloc.state)
          .thenReturn(const MovieLoaded(testMovieEntity));

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const MovieScreen()));

      await widgetTester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key('movie_data')), findsOneWidget);
    },
  );

  testWidgets(
    'should find the detail widgets showing the label and values from the movie data when state is movie loaded',
    (widgetTester) async {
      //arrange
      when(() => mockMovieBloc.state)
          .thenReturn(const MovieLoaded(testMovieEntity));

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const MovieScreen()));

      await widgetTester.pumpAndSettle();

      //assert
      expect(find.byType(DetailWidget), findsExactly(6));
      expect(find.byType(DetailWidget).at(2), findsOneWidget);

      Finder detailWidget2Finder = find.byType(DetailWidget).at(1); //index
      DetailWidget detailWidget2 = widgetTester.widget(detailWidget2Finder);
      expect(detailWidget2.label, 'Rated');
    },
  );

  testWidgets(
    'should show text widget with error message when state is movie load failed',
    (widgetTester) async {
      //arrange
      when(() => mockMovieBloc.state)
          .thenReturn(const MovieLoadFailed('Failed to load data'));

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const MovieScreen()));

      await widgetTester.pumpAndSettle();

      //assert
      Finder textFinder = find.byKey(const Key('failure_text'));
      Text text = widgetTester.widget(textFinder);
      expect(text.data, 'Failed to load data');
    },
  );
}
