import 'package:go_router/go_router.dart';
import 'package:go_router_practice/route/screens/1_basic_screen.dart';
import 'package:go_router_practice/route/screens/2_named_screen.dart';
import 'package:go_router_practice/route/screens/3_push_screen.dart';
import 'package:go_router_practice/route/screens/4_pop_base_screen.dart';
import 'package:go_router_practice/route/screens/5_pop_return_screen.dart';
import 'package:go_router_practice/route/screens/6_path_param_screen.dart';
import 'package:go_router_practice/route/screens/7_query_parameter_screen.dart';
import 'package:go_router_practice/route/screens/root_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const RootScreen();
      },
      routes: [
        GoRoute(
          path: 'basic',
          builder: (context, state) {
            return const BasicScreen();
          },
        ),
        GoRoute(
          path: 'named',
          name: 'named_screen',
          builder: (context, state) {
            return const NamedScreen();
          },
        ),
        GoRoute(
          path: 'push',
          builder: (context, state) {
            return const PushScreen();
          },
        ),
        GoRoute(
          path: 'pop',
          builder: (context, state) {
            return const PopBaseScreen();
          },
          routes: [
            GoRoute(
              path: 'return',
              builder: (context, state) {
                return const PopReturnScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'path_param/:id',
          builder: (context, state) {
            return const PathParamScreen();
          },
          routes: [
            GoRoute(
              path: ':name',
              builder: (context, state) {
                return const PathParamScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) {
            return const QueryParameterScreen();
          },
        ),
      ],
    ),
  ],
);
