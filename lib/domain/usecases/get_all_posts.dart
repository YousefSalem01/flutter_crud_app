import 'package:dartz/dartz.dart';
import 'package:test_app/core/error/failures.dart';
import 'package:test_app/domain/entities/post.dart';
import 'package:test_app/domain/repositories/post_repository.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}