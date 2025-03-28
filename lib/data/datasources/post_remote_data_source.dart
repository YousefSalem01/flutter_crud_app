import 'package:test_app/core/api/api_consumer.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:test_app/core/utils/constants.dart';
import 'package:test_app/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<PostModel> getPostById(int id);
  Future<PostModel> addPost(PostModel postModel);
  Future<PostModel> updatePost(PostModel postModel);
  Future<void> deletePost(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiConsumer apiConsumer;

  PostRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await apiConsumer.get(ApiEndpoints.posts);
    return List<PostModel>.from(
        (response as List).map((x) => PostModel.fromJson(x)));
  }

  @override
  Future<PostModel> getPostById(int id) async {
    final response = await apiConsumer.get('${ApiEndpoints.post}$id');
    return PostModel.fromJson(response);
  }

  @override
  Future<PostModel> addPost(PostModel postModel) async {
    final response = await apiConsumer.post(
      ApiEndpoints.posts,
      body: postModel.toJson(),
    );
    return PostModel.fromJson(response);
  }

  @override
  Future<PostModel> updatePost(PostModel postModel) async {
    final response = await apiConsumer.put(
      '${ApiEndpoints.post}${postModel.id}',
      body: postModel.toJson(),
    );
    return PostModel.fromJson(response);
  }

  @override
  Future<void> deletePost(int id) async {
    await apiConsumer.delete('${ApiEndpoints.post}$id');
  }
}
