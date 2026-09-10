import 'package:github_blog/data/entry_data.dart';
import 'package:github_blog/screens/desktop_details_screen.dart';
import 'package:github_blog/screens/desktop_list_screen.dart';
import 'package:github_blog/screens/not_found_screen.dart';
import 'package:github_blog/services/blog_service.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter({required this.blogService});
  final BlogService blogService;

  // Late delays the creation until use,
  // If not used, blogService would not be available.
  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) =>
            DesktopScreenList(blogService: blogService),
        routes: [
          GoRoute(
            path: 'post/:id',
            name: 'post-detail',
            builder: (context, state) {
              final postId = state.pathParameters['id'] ?? '';
              // If navigated from post list, the object can be passed in extra
              final post = state.extra is BlogPost
                  ? state.extra as BlogPost
                  : null;
              return DesktopDetailsScreen(
                postId: postId,
                blogService: blogService,
                initialPost: post,
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        NotFoundScreen(errorMessage: state.error?.message ?? 'Page not found'),
  );
}
