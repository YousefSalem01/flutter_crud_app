import 'package:dartz/dartz.dart';
import 'package:test_app/core/error/failures.dart';
import 'package:test_app/domain/entities/post.dart';
import 'package:test_app/domain/repositories/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure, Post>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
