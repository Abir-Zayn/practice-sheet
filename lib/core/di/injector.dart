import 'package:mockai/core/database/app_database.dart';
import 'package:mockai/core/database/daos/favorite_dao.dart';
import 'package:mockai/core/router/app_router.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mockai/core/network/auth_interceptor.dart';
import 'package:mockai/core/network/dio_client.dart';
import 'package:mockai/core/storage/secure_storage_service.dart';
import 'package:mockai/features/auth/data/datasource/auth_api_service.dart';
import 'package:mockai/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:mockai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mockai/features/auth/domain/repositories/auth_repository.dart';
import 'package:mockai/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:mockai/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:mockai/features/auth/domain/usecases/login_usecase.dart';
import 'package:mockai/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mockai/features/recipes/data/datasource/local/recipe_local_data_source.dart';
import 'package:mockai/features/recipes/data/datasource/remote/recipe_api_service.dart';
import 'package:mockai/features/recipes/data/datasource/remote/recipe_remote_data_src.dart';
import 'package:mockai/features/recipes/data/repositories/recipe_repositories_impl.dart';
import 'package:mockai/features/recipes/domain/repositories/recipe_repositories.dart';
import 'package:mockai/features/recipes/domain/usecases/favorite_recipe.dart';
import 'package:mockai/features/recipes/domain/usecases/get_favorite_recipe.dart';
import 'package:mockai/features/recipes/domain/usecases/get_recipe_by_id.dart';

import 'package:mockai/features/recipes/domain/usecases/get_recipes.dart';
import 'package:mockai/features/recipes/domain/usecases/toggle_favorite_recipe.dart';

import 'package:mockai/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<AuthBloc>()));

  //database 
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  sl.registerLazySingleton<FavoritesDao>(() => sl<AppDatabase>().favoritesDao);


  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(),
  );

  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(storageService: sl<SecureStorageService>()),
  );


  sl.registerLazySingleton<Dio>(
    () => DioClient.createDio(authInterceptor: sl<AuthInterceptor>()),
  );


  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl<Dio>()));
  sl.registerLazySingleton<RecipeApiService>(() => RecipeApiService(sl<Dio>()));


  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<AuthApiService>()),
  );
  sl.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(sl<FavoritesDao>()),
  );
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSrcImpl(sl<RecipeApiService>()),
  );


  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<SecureStorageService>(),
    ),
  );
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoriesImpl(
      sl<RecipeRemoteDataSource>(),
      sl<RecipeLocalDataSource>(),
    ),
  );


  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<CheckAuthStatusUseCase>(
    () => CheckAuthStatusUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<ListRecipes>(
    () => ListRecipes(sl<RecipeRepository>()),
  );
  sl.registerLazySingleton<GetRecipeById>(
    () => GetRecipeById(sl<RecipeRepository>()),
  );
  sl.registerFactory<RecipeDetailBloc>(
    () => RecipeDetailBloc(getRecipeById: sl<GetRecipeById>()),
  );
  sl.registerLazySingleton<ToggleFavoriteRecipe>(
    () => ToggleFavoriteRecipe(sl<RecipeRepository>()),
  );
  sl.registerLazySingleton<IsRecipeFavorite>(
    () => IsRecipeFavorite(sl<RecipeRepository>()),
  );
  sl.registerLazySingleton<GetFavoriteRecipes>(
    () => GetFavoriteRecipes(sl<RecipeRepository>()),
  );

  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
      checkAuthStatusUseCase: sl<CheckAuthStatusUseCase>(),
      authInterceptor: sl<AuthInterceptor>(),
    ),
  );
  sl.registerFactory<RecipeBloc>(
    () => RecipeBloc(getRecipes: sl<ListRecipes>()),
  );
}
