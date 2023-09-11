import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:middle_class/common/view/root_tab.dart';
import 'package:middle_class/common/view/splash_screen.dart';
import 'package:middle_class/restaurant/view/restaruant_detail_screen.dart';
import 'package:middle_class/user/model/user_model.dart';
import 'package:middle_class/user/provider/user_me_provider.dart';
import 'package:middle_class/user/view/login_screen.dart';

final authProvider = ChangeNotifierProvider(
  (ref) {
    return AuthProvider(ref: ref);
  },
);

class AuthProvider extends ChangeNotifier {
  final Ref ref;
  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (context, state) => const RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (context, state) => RestaurantDetailScreen(
                id: state.pathParameters['rid']!,
              ),
            ),
          ],
        ),
      ];

  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    final logingIn = state.location == '/login';

    if (user == null) {
      return logingIn ? null : '/login';
    }
    if (user is UserModel) {
      return logingIn || state.location == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !logingIn ? '/login' : null;
    }
    return null;
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }
}
