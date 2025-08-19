import 'package:clean_architecture_mvvm_template/src/core/lib_core.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/presentation/screens/characters_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.root,
    routes: [
      GoRoute(
        name: RouteNames.characters,
        path: RoutePaths.root,
        builder: (context, state) => const CharactersScreen(),
      ),
    ],
  );
}
