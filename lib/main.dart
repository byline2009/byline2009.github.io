import 'package:bloc_login/app_routes.dart';
import 'package:bloc_login/provider/locator.dart';
import 'package:bloc_login/provider/providers.dart';
import 'package:bloc_login/screens/forgot_password_screen.dart';
import 'package:bloc_login/screens/home_screen.dart';
import 'package:bloc_login/screens/login_screen.dart';
import 'package:bloc_login/screens/category_list_screen.dart';
import 'package:bloc_login/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BlogLogin',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: AppRoutes.login,
          routes: <String, WidgetBuilder>{
            AppRoutes.login: (_) => const LoginScreen(),
            AppRoutes.home: (_) => const HomeScreen(),
            AppRoutes.signup: (_) => const SignUpScreen(),
            AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
            AppRoutes.categorylist: (_) => const CategoryListScreen(),
          }),
    );
  }
}
