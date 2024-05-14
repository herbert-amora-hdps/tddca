import 'package:mockito/annotations.dart';
import 'package:sampletdd/data/data_sources/remote_data_source.dart';
import 'package:sampletdd/domain/repositories/movie_repository.dart';
import 'package:http/http.dart';

@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
  ],
  // add this custom Mock for the http library
  customMocks: [MockSpec<Client>(as: #MockHttpClient)],
)
void main() {}
