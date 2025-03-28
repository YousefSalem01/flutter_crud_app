import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/core/widgets/loading_widget.dart';
import 'package:test_app/domain/entities/post.dart';
import 'package:test_app/presentation/cubit/posts_cubit.dart';
import 'package:test_app/presentation/cubit/posts_state.dart';
import 'package:test_app/presentation/widgets/post_form_widget.dart';

class PostAddUpdatePage extends StatefulWidget {
  final int? postId;

  const PostAddUpdatePage({
    super.key,
    this.postId,
  });

  @override
  State<PostAddUpdatePage> createState() => _PostAddUpdatePageState();
}

class _PostAddUpdatePageState extends State<PostAddUpdatePage> {
  Post? post;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.postId != null) {
      isEditing = true;
      _loadPost(widget.postId!);
    }
  }

  void _loadPost(int id) {
    context.read<PostsCubit>().fetchPost(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Post' : 'Add Post'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          if (state is PostAdded || state is PostUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditing
                      ? 'Post updated successfully'
                      : 'Post added successfully',
                ),
              ),
            );
            context.read<PostsCubit>().fetchAllPosts();
            context.go('/');
          } else if (state is PostsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is PostLoaded) {
            post = state.post;
          }
        },
        builder: (context, state) {
          if (isEditing && (state is PostLoading || post == null)) {
            return const LoadingWidget();
          }

          if (state is PostsLoading) {
            return const LoadingWidget();
          }

          return SingleChildScrollView(
            child: PostFormWidget(
              post: post,
              isEditing: isEditing,
              onSubmit: (post) {
                if (isEditing) {
                  context.read<PostsCubit>().modifyPost(post);
                } else {
                  context.read<PostsCubit>().createPost(post);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
