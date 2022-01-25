import 'package:bloc_login/helper/constant.dart';
import 'package:bloc_login/bloc_layer/bloc_cubit/auth_cubit.dart';
import 'package:bloc_login/presentation_layer/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
          body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthForgotPasswordError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.err!)));
        } else if (state is AuthForgotPasswordSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text('Reset link has been sent to your email')));
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        if (state is AuthDefault) {
          return _buildForgotPasswordScreen();
        } else if (state is AuthForgotPasswordLoading) {
          return loader();
        } else if (state is AuthForgotPasswordSuccess) {
          return _buildForgotPasswordScreen();
        } else {
          return _buildForgotPasswordScreen();
        }
      })),
    );
  }

  Widget _buildForgotPasswordScreen() {
    return SafeArea(
        child: FormBuilder(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: BackButton(
                                onPressed: () => Navigator.pop(context))),
                        Spacer(),
                        SizedBox(
                            height: 180,
                            width: 180,
                            child: Image.asset('assets/images/logo.png')),
                        Text("Forgot Password", style: kHeadingStyle),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: FormBuilderTextField(
                              textInputAction: TextInputAction.next,
                              name: "email",
                              validator: FormBuilderValidators.compose([
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
                        SizedBox(height: 25),
                        SendLinkButton(onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final authCubit =
                                BlocProvider.of<AuthCubit>(context);
                            await authCubit.forgotPassword(
                                formKey.currentState!.fields['email']!.value);
                          }
                        }),
                        Spacer(flex: 2)
                      ],
                    )))));
  }

  Widget loader() {
    return const Center(child: CircularProgressIndicator());
  }
}

class SendLinkButton extends StatelessWidget {
  final Function onPressed;
  const SendLinkButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(child: Text("Send Link"), onPressed: onPressed);
  }
}
