import 'package:go_router/go_router.dart';
import 'package:music_app/presentation/view/favorites_screen.dart';
import 'package:music_app/presentation/view/home_screen.dart';
import 'package:music_app/presentation/view/main_screen.dart';
import 'package:music_app/presentation/view/search_screen.dart';
import 'package:music_app/splash_screen.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
            path: "main",
            name: 'main',
            builder: (context, state) => const MainScreen()),
        GoRoute(
            path: 'home',
            name: 'home',
            builder: (context, state) => const HomeScreen()),
        GoRoute(
            path: 'search',
            name: 'search',
            builder: (context, state) => const SearchScreen()),
        GoRoute(
            path: 'favour',
            name: 'favour',
            builder: (context, state) => const FavourScreen()),
      ]),
]);
