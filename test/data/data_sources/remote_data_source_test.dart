import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:sampletdd/core/constants/exceptions.dart';
import 'package:sampletdd/core/constants/urls.dart';
import 'package:sampletdd/data/data_sources/remote_data_source.dart';
import 'package:sampletdd/data/models/movie_model.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  // will be added later when calling rootBundle
  TestWidgetsFlutterBinding.ensureInitialized();

  // Calling live services or databases slows down test execution that's why we're utilizing mocking packages
  // A passing test might start failing if a web service returns unexpected results known as a "flaky test"

  late MockHttpClient mockHttpClient;
  // regenerate mock helpers using command [flutter pub run build_runner build]
  late MovieRemoteDataSourceImpl movieRemoteDateSourceImpl;

  //initialize instances
  setUp(() {
    mockHttpClient = MockHttpClient();
    movieRemoteDateSourceImpl =
        MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testMovieName = 'Avengers';

// use group method to put several tests related to each other
  group('get movie details', () {
    test(
      'should return movie model when response code is 200',
      () async {
        // arrange - Stub / stubbing means to create a fake object when a mock method is called
        // This is to make sure the mock client returns the right response data when we call the getMovieDetails endpoint

        final String jsonString = await rootBundle
            .loadString('test/helpers/dummy_data/dummy_movie_response.json');

        when(mockHttpClient
                .get(Uri.parse(Urls.movieDetailsbyName(testMovieName))))
            .thenAnswer((_) async => Response(jsonString, 200));

        // act
        final result =
            await movieRemoteDateSourceImpl.getMovieDetails(testMovieName);

        // assert
        expect(result, isA<MovieModel>());
      },
    );

    test(
      'should throw an exception when response code is 404 or other',
      () async {
        when(mockHttpClient
                .get(Uri.parse(Urls.movieDetailsbyName(testMovieName))))
            .thenAnswer((_) async => Response('Not found', 404));

        // act
        final result = movieRemoteDateSourceImpl.getMovieDetails(testMovieName);

        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
