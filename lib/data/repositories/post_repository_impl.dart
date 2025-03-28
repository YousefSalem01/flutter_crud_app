import 'package:dartz/dartz.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:test_app/core/error/failures.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/data/datasources/post_remote_data_source.dart';
import 'package:test_app/data/models/post_model.dart';
import 'package:test_app/domain/entities/post.dart';
import 'package:test_app/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        return Right(remotePosts);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, Post>> getPostById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePost = await remoteDataSource.getPostById(id);
        return Right(remotePost);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, Post>> addPost(Post post) async {
    final postModel = PostModel.fromPost(post);
    if (await networkInfo.isConnected) {
      try {
        final newPost = await remoteDataSource.addPost(postModel);
        return Right(newPost);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, Post>> updatePost(Post post) async {
    final postModel = PostModel.fromPost(post);
    if (await networkInfo.isConnected) {
      try {
        final updatedPost = await remoteDataSource.updatePost(postModel);
        return Right(updatedPost);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deletePost(id);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }
}
