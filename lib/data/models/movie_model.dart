import 'package:sampletdd/domain/entities/movie.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required String title,
    required String year,
    required String rated,
    required String released,
    required String runtime,
    required String genre,
    required String director,
  }) : super(
          title: title,
          year: year,
          rated: rated,
          released: released,
          runtime: runtime,
          genre: genre,
          director: director,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        title: json['Title'],
        year: json['Year'],
        rated: json['Rated'],
        released: json['Released'],
        runtime: json['Runtime'],
        genre: json['Genre'],
        director: json['Director'],
      );

  Map<String, dynamic> toJson() => {
        'Title': title,
        'Year': year,
        'Rated': rated,
        'Released': released,
        'Runtime': runtime,
        'Genre': genre,
        'Director': director,
      };

  MovieEntity toEntity() => MovieEntity(
        title: title,
        year: year,
        rated: rated,
        released: released,
        runtime: runtime,
        genre: genre,
        director: director,
      );
}
