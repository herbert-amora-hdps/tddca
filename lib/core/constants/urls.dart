class Urls {
  static const String baseUrl = 'https://www.omdbapi.com';
  static const String apiKey = '2b2a87fe';
  static String movieDetailsbyName(String movie) =>
      '$baseUrl/?t=$movie&apikey=$apiKey';
}
