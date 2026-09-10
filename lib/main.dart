import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_blog/router/app_router.dart';
import 'package:github_blog/services/blog_service.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 0, 9, 131),
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(decoration: TextDecoration.underline),
  ),
);

void main() {
  // Removes the '#' symbol from web URLs (e.g. /post/123 instead of /#/post/123)
  usePathUrlStrategy();

  final blogService = BlogService();
  final appRouter = AppRouter(blogService: blogService);
  runApp(ProviderScope(child: BlogWebApp(appRouter: appRouter)));
}

class BlogWebApp extends StatelessWidget {
  const BlogWebApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      title: 'Portfolio Blog',
      routerConfig: appRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

/* home: LayoutBuilder(
        builder: (context, constraints) {
          //desktop
          if (constraints.maxWidth < 600) {
            return MobileWidget();
          }

          return PostListScreen();
        },
      ), */
