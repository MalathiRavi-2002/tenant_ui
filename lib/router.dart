import 'package:tenant_api/admin_api.dart';
import 'package:go_router/go_router.dart';
import 'package:tenant_ui/ui/screens/home_screen.dart';
import 'package:tenant_ui/ui/screens/info_screen.dart';
import 'package:tenant_ui/ui/screens/login_screen.dart';
import 'package:tenant_ui/ui/screens/register_screen.dart';

import 'providers/auth_provider.dart';

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    refreshListenable: authProvider,
    redirect: (context, state) {
      final isAuthenticated = authProvider.isAuthenticated;
      final isLoginPage = state.fullPath == '/login';
      if (!isAuthenticated && !isLoginPage) {
        return '/login';
      }
      if (isAuthenticated && isLoginPage) {
        return '/';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      // GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          final organization = state.extra as OrganizationResponseModel;
          return RegisterScreen(organization: organization);
        },
      ),

      // GoRoute(path: '/info', builder: (context, state) => InfoScreen(organization: org)),
      GoRoute(
        path: '/info',
        builder: (context, state) {
          final org = state.extra as OrganizationResponseModel; // Cast the extra data
          return InfoScreen(organization: org);
        },
      ),
    ],
  );
}
