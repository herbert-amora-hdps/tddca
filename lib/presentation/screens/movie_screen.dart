import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampletdd/presentation/bloc/movie_bloc.dart';
import 'package:sampletdd/presentation/bloc/movie_event.dart';
import 'package:sampletdd/presentation/bloc/movie_state.dart';
import 'package:sampletdd/presentation/widgets/detail_widget.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text(
          'MOVIE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                icon: const Icon(Icons.search),
                hintText: 'Enter movie name',
                fillColor: const Color(0xffF3F3F3),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (query) {
                context.read<MovieBloc>().add(OnMovieChanged(query));
              },
            ),
            const SizedBox(height: 32.0),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is MovieLoaded) {
                  return Column(
                    key: const Key('movie_data'),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: NetworkImage(
                              state.result.poster,
                              scale: 2.5,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.result.title,
                                style: const TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(height: 20),
                              DetailWidget(
                                label: 'Year',
                                value: state.result.year,
                              ),
                              DetailWidget(
                                label: 'Rated',
                                value: state.result.rated,
                              ),
                              DetailWidget(
                                label: 'Released',
                                value: state.result.released,
                              ),
                              DetailWidget(
                                label: 'Runtime',
                                value: state.result.runtime,
                              ),
                              DetailWidget(
                                label: 'Genre',
                                value: state.result.genre,
                              ),
                              DetailWidget(
                                label: 'Director',
                                value: state.result.director,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                }
                if (state is MovieLoadFailed) {
                  return Center(
                    child: Text(
                      key: const Key('failure_text'),
                      state.message,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
