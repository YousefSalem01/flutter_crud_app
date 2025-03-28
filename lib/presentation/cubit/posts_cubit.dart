import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/utils/constants.dart';
import 'package:test_app/domain/entities/post.dart';
import 'package:test_app/domain/usecases/add_post.dart';
import 'package:test_app/domain/usecases/delete_post.dart';
import 'package:test_app/domain/usecases/get_all_posts.dart';
import 'package:test_app/domain/usecases/get_post_by_id.dart';
import 'package:test_app/domain/usecases/update_post.dart';
import 'package:test_app/presentation/cubit/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetAllPostsUseCase getAllPosts;
  final GetPostByIdUseCase getPostById;
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;

  // Keep a local copy of the posts to prevent losing them during operations
  List<Post> _posts = [];

  PostsCubit({
    required this.getAllPosts,
    required this.getPostById,
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(PostsInitial());

  Future<void> fetchAllPosts() async {
    emit(PostsLoading());
    final result = await getAllPosts();
    result.fold(
      (failure) =>
          emit(PostsError(message: _mapFailureToMessage(failure.message))),
      (posts) {
        _posts = posts;
        emit(PostsLoaded(posts: posts));
      },
    );
  }

  Future<void> fetchPost(int id) async {
    emit(PostLoading());
    final result = await getPostById(id);
    result.fold(
      (failure) =>
          emit(PostsError(message: _mapFailureToMessage(failure.message))),
      (post) => emit(PostLoaded(post: post)),
    );
  }

  Future<void> createPost(Post post) async {
    emit(PostsLoading());
    final result = await addPost(post);
    result.fold(
      (failure) =>
          emit(PostsError(message: _mapFailureToMessage(failure.message))),
      (post) {
        _posts.add(post);
        emit(PostAdded(post: post));
        // Immediately update the UI with the new post list
        emit(PostsLoaded(posts: _posts));
      },
    );
  }

  Future<void> modifyPost(Post post) async {
    emit(PostsLoading());
    final result = await updatePost(post);
    result.fold(
      (failure) =>
          emit(PostsError(message: _mapFailureToMessage(failure.message))),
      (updatedPost) {
        // Update the post in the local list
        final index = _posts.indexWhere((p) => p.id == updatedPost.id);
        if (index != -1) {
          _posts[index] = updatedPost;
        }
        emit(PostUpdated(post: updatedPost));
        // Immediately update the UI with the updated post list
        emit(PostsLoaded(posts: _posts));
      },
    );
  }

  Future<void> removePost(int id) async {
    emit(PostsLoading());
    final result = await deletePost(id);
    result.fold(
      (failure) =>
          emit(PostsError(message: _mapFailureToMessage(failure.message))),
      (_) {
        // Remove the post from the local list
        _posts.removeWhere((post) => post.id == id);
        emit(PostDeleted(id: id));
        // Immediately update the UI with the filtered post list
        emit(PostsLoaded(posts: _posts));
      },
    );
  }

  String _mapFailureToMessage(String message) {
    switch (message) {
      case 'Server Failure':
        return AppConstants.serverFailure;
      case 'Connection Failure':
        return AppConstants.connectionFailure;
      default:
        return AppConstants.unexpectedError;
    }
  }
}
