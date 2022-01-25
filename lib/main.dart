import 'package:bloc_login/helper/app_routes.dart';
import 'package:bloc_login/data_layer/provider/locator.dart';
import 'package:bloc_login/data_layer/provider/providers.dart';
import 'package:bloc_login/presentation_layer/screens/category_list_screen.dart';
import 'package:bloc_login/presentation_layer/screens/category_list_screen_1.dart';
import 'package:bloc_login/presentation_layer/screens/forgot_password_screen.dart';
import 'package:bloc_login/presentation_layer/screens/home_screen.dart';
import 'package:bloc_login/presentation_layer/screens/login_screen.dart';
import 'package:bloc_login/presentation_layer/screens/signup_screen.dart';
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
            AppRoutes.signUp: (_) => const SignUpScreen(),
            AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
            AppRoutes.categoryList: (_) => const CategoryListScreen(),
            AppRoutes.categoryList1: (_) => const CategoryListScreen1(),
          }),
    );
  }
}
