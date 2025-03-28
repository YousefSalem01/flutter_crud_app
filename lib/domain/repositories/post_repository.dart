import 'package:dartz/dartz.dart';
import 'package:test_app/core/error/failures.dart';
import 'package:test_app/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Post>> getPostById(int id);
  Future<Either<Failure, Post>> addPost(Post post);
  Future<Either<Failure, Post>> updatePost(Post post);
  Future<Either<Failure, Unit>> deletePost(int id);
}