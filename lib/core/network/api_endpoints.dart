abstract class ApiEndpoints {
  // Base URL reading from --dart-define

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://dummyjson.com',
  );

  //Timeout
  static const Duration reciveTimeout = Duration(seconds: 10);
  static const Duration connectTimeout = Duration(seconds: 15);

  //recipe endpoints
  static const String recipes = '/recipes';
  static const String recipeSearch = '/recipes/search';

  //auth endpoints
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';

  static const String me = '/auth/me';
}
