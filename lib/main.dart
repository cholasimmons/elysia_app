import 'package:elysia_app/models/auth_model.dart';
import 'package:elysia_app/models/province_model.dart';
import 'package:elysia_app/models/user_model.dart';
import 'package:elysia_app/providers/auth_provider.dart';
import 'package:elysia_app/providers/home_provider.dart';
import 'package:elysia_app/screens/start_screen.dart';
import 'package:elysia_app/services/toast_service.dart';
import 'package:elysia_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/connect_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the adapters
  Hive.registerAdapter(ProvinceAdapter()); Hive.registerAdapter(DistrictAdapter());

  Hive.registerAdapter(LoginAdapter()); Hive.registerAdapter(SignupAdapter());

  Hive.registerAdapter(UserAdapter());

  runApp(MultiProvider(providers: [
    Provider<ToastService>(
      create: (context) => ToastService(),
      dispose: (_, service) => service.dispose(),
    ),
    ChangeNotifierProvider(
      create: (context) => ConnectProvider()
    ),
    ChangeNotifierProvider(
        create: (context) => AuthProvider()
    ),
    ChangeNotifierProvider(
        create: (context) => HomeProvider()
    ),
  ],
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elysia API',
      navigatorKey: ToastService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      themeMode: ThemeMode.dark,
      darkTheme: CustomTheme.darkTheme,
      home: const StartPage(title: 'Elysia Auth'),
    );
  }
}

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }