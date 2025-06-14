import 'package:tenant_api/admin_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:tenant_ui/providers/auth_provider.dart';
import 'package:tenant_ui/router.dart';
import 'package:web/web.dart' as web;

void main() {
  usePathUrlStrategy();
  runApp(ChangeNotifierProvider(create: (context) => AuthProvider(), child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final String basePath = (kDebugMode) ? 'http://192.168.1.31:3000' : web.window.location.origin;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()..init()),
        Provider(create: (context) => Api(basePath: basePath)),
      ],
      builder: (context, widget) {
        return MaterialApp.router(
          routerConfig: createRouter(context.read()),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Averta'),
        );
      },
    );
  }
}
