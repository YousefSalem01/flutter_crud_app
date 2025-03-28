import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_app/core/api/api_consumer.dart';
import 'package:test_app/core/api/dio_consumer.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/data/datasources/post_remote_data_source.dart';
import 'package:test_app/data/repositories/post_repository_impl.dart';
import 'package:test_app/domain/repositories/post_repository.dart';
import 'package:test_app/domain/usecases/add_post.dart';
import 'package:test_app/domain/usecases/delete_post.dart';
import 'package:test_app/domain/usecases/get_all_posts.dart';
import 'package:test_app/domain/usecases/get_post_by_id.dart';
import 'package:test_app/domain/usecases/update_post.dart';
import 'package:test_app/presentation/cubit/posts_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(
    () => PostsCubit(
      getAllPosts: sl(),
      getPostById: sl(),
      addPost: sl(),
      updatePost: sl(),
      deletePost: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => GetPostByIdUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(apiConsumer: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
