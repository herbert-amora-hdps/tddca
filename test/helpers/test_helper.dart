import 'package:mockito/annotations.dart';
import 'package:sampletdd/data/data_sources/remote_data_source.dart';
import 'package:sampletdd/domain/repositories/movie_repository.dart';
import 'package:http/http.dart';
import 'package:sampletdd/domain/usecases/get_movie_details.dart';

@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
    GetMovieDetailsUseCase,
  ],
  // add this custom Mock for the http library
  customMocks: [MockSpec<Client>(as: #MockHttpClient)],
)
void main() {}
