import 'package:go_router/go_router.dart';
import '../../features/mel_calculator/presentation/pages/main_screen.dart';

class AppRouter {
  static const String home = '/';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}
