import 'package:equatable/equatable.dart';
import 'package:test_app/domain/entities/post.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  const PostsLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class PostLoading extends PostsState {}

class PostLoaded extends PostsState {
  final Post post;

  const PostLoaded({required this.post});

  @override
  List<Object?> get props => [post];
}

class PostAdded extends PostsState {
  final Post post;

  const PostAdded({required this.post});

  @override
  List<Object?> get props => [post];
}

class PostUpdated extends PostsState {
  final Post post;

  const PostUpdated({required this.post});

  @override
  List<Object?> get props => [post];
}

class PostDeleted extends PostsState {
  final int id;

  const PostDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}

class PostsError extends PostsState {
  final String message;

  const PostsError({required this.message});

  @override
  List<Object?> get props => [message];
}
