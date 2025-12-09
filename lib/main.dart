import 'package:flutter/material.dart';
import 'package:go_route/screens/A.dart';
import 'package:go_route/screens/B.dart';
import 'package:go_route/screens/C.dart';
import 'package:go_router/go_router.dart';
void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ScreenA(),
    ),
    GoRoute(
      path: '/screenB',
      name: 'screenB',
      builder: (context, state) {
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
        return ScreenB(
          phrase: data?['phrase'] ?? '',
          hashtags: data?['hashtags'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/screenC',
      name: 'screenC',
      builder: (context, state) {
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
        return ScreenC(
          initialPhrase: data?['phrase'] ?? '',
          initialHashtags: data?['hashtags'] ?? '',
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Hashtag Formatter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}