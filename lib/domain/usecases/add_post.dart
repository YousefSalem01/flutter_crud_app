import 'package:dartz/dartz.dart';
import 'package:test_app/core/error/failures.dart';
import 'package:test_app/domain/entities/post.dart';
import 'package:test_app/domain/repositories/post_repository.dart';

class AddPostUseCase {
  final PostRepository repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Post>> call(Post post) async {
    return await repository.addPost(post);
  }
}