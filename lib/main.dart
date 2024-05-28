import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:sampletdd/data/data_sources/remote_data_source.dart';
import 'package:sampletdd/data/repositories/movie_repository_impl.dart';
import 'package:sampletdd/domain/usecases/get_movie_details.dart';
import 'package:sampletdd/presentation/bloc/movie_bloc.dart';
import 'package:sampletdd/presentation/screens/movie_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => MovieRepositoryImpl(
            movieRemoteDataSource: MovieRemoteDataSourceImpl(client: Client()),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MovieBloc(
              GetMovieDetailsUseCase(
                RepositoryProvider.of<MovieRepositoryImpl>(context),
              ),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MovieScreen(),
        ),
      ),
    );
  }
}
