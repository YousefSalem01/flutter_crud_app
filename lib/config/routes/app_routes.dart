import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/presentation/pages/post_add_update_page.dart';
import 'package:test_app/presentation/pages/post_detail_page.dart';
import 'package:test_app/presentation/pages/posts_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const PostsPage();
        },
      ),
      GoRoute(
        path: '/post/:id',
        builder: (BuildContext context, GoRouterState state) {
          final id = int.parse(state.pathParameters['id']!);
          return PostDetailPage(postId: id);
        },
      ),
      GoRoute(
        path: '/add-post',
        builder: (BuildContext context, GoRouterState state) {
          return const PostAddUpdatePage();
        },
      ),
      GoRoute(
        path: '/edit-post/:id',
        builder: (BuildContext context, GoRouterState state) {
          final id = int.parse(state.pathParameters['id']!);
          return PostAddUpdatePage(postId: id);
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('No route defined for ${state.uri.path}'),
        ),
      );
    },
  );
}
