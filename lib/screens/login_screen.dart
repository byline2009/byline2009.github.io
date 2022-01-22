import 'package:bloc_login/app_routes.dart';
import 'package:bloc_login/constant.dart';
import 'package:bloc_login/bloc_cubit/auth_cubit.dart';
import 'package:bloc_login/screens/home_screen.dart';
import 'package:bloc_login/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  var isObscure = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
            body: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoginError) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(content: Text(state.errorMessage!)));
                  } else if (state is AuthLoginSuccess) {
                    formKey.currentState!.reset();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }
                },
                builder: (context, state) => _buildLoginScreen())),
      ),
    );
  }

  Widget _buildLoginScreen() {
    return SafeArea(
        child: FormBuilder(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Center(
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
              SizedBox(
                  child: Image.asset('assets/images/logo.png'),
                  height: 180,
                  width: 180),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: FormBuilderTextField(
                    textInputAction: TextInputAction.next,
                    name: "email",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: "Please insert valid email"),
                      FormBuilderValidators.email(context,
                          errorText: "Please insert valid email")
                    ]),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      prefixIcon: const Icon(Icons.mail),
                      hintText: 'Enter email',
                      hintStyle: kHintStyle,
                      fillColor: Colors.grey[200],
                      filled: true,
                      enabledBorder: kOutlineBorder,
                      focusedBorder: kOutlineBorder,
                      errorBorder: kOutlineBorderError,
                    )),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: FormBuilderTextField(
                    textInputAction: TextInputAction.done,
                    name: "password",
                    obscureText: isObscure,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Enter password',
                        hintStyle: kHintStyle,
                        fillColor: Colors.grey[200],
                        filled: true,
                        enabledBorder: kOutlineBorder,
                        focusedBorder: kOutlineBorder,
                        errorBorder: kOutlineBorderError,
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            child: Icon(isObscure
                                ? Icons.radio_button_off
                                : Icons.radio_button_checked)))),
              ),
              const SizedBox(height: 25),
              LoginButton(onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final authCubit = BlocProvider.of<AuthCubit>(context);
                  await authCubit.login(
                      formKey.currentState!.fields['email']!.value,
                      formKey.currentState!.fields['password']!.value);
                  // await authCubit.getCategorys(context);
                }
              }),
              TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.forgotPassword),
                  child: const Text("Forgot password")),
              Divider(height: 20, endIndent: 10, indent: 8),
              CustomButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.signup),
                  child: const Text("Create an account"))
            ])))));
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: Text('Exit app ?'),
                    content: Text("Are you sure ?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Ok",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Cancel",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]))) ??
        false;
  }
}

class LoginButton extends StatelessWidget {
  final Function onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        onPressed: onPressed,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AuthLoginLoading) {
              return kLoaderBtn;
            } else {
              return Text('Login');
            }
          },
        ));
  }
}
