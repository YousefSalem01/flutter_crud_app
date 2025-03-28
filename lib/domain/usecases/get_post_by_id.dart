import 'package:dartz/dartz.dart';
import 'package:test_app/core/error/failures.dart';
import 'package:test_app/domain/entities/post.dart';
import 'package:test_app/domain/repositories/post_repository.dart';

class GetPostByIdUseCase {
  final PostRepository repository;

  GetPostByIdUseCase(this.repository);

  Future<Either<Failure, Post>> call(int id) async {
    return await repository.getPostById(id);
  }
}