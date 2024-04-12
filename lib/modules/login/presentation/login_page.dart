import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/admin_panel_page.dart';
import 'package:pothole_detection/modules/login/presentation/bloc/login_bloc.dart';
import 'package:pothole_detection/modules/registration/presentation/registration_page.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_page.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';
import 'package:pothole_detection/utils/common/app_input.dart';
import 'package:pothole_detection/utils/common/custom_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(CheckLoginData()),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (state.response?.userData?.role == 'admin') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminPanel(),
                  ),
                );
              } else if (state.response?.userData?.role == 'user') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserPanel(),
                  ),
                );
              }
            } else if (state is LoginFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: taskCancelledColor,
                content: Text('Please Enter Correct Details'),
              ));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Image.asset(
                    'assets/img/bg.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              height: 0,
                              color: kcPrimaryColorDark,
                            ),
                          ),
                          const Text(
                            'Enter your credentials to login',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: kcPrimaryColorDark,
                            ),
                          ),
                          const SizedBox(height: 100),
                          AppInputField(
                            controller: _emailController,
                            hint: 'Enter your Email-id',
                            label: 'Email-Id',
                          ),
                          const SizedBox(height: 30),
                          AppInputField(
                            password: passwordVisible == true ? true : false,
                            controller: _passwordController,
                            hint: 'Enter your Password',
                            label: 'Password',
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible!;
                                  });
                                },
                                icon: Icon(passwordVisible == true
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: const Text('Forget Password?',
                                    style: TextStyle(
                                        color: kcPrimaryColorDark,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                onPressed: () {},
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          CustomButton(
                            isLoading:
                                state is LoginLoadingState ? true : false,
                            width: double.infinity,
                            height: 50,
                            onPressed: () {
                              Provider.of<LoginBloc>(context, listen: false)
                                  .add(LoginInitialEvent(
                                      userName: _emailController.text,
                                      password: _passwordController.text));
                            },
                            text: 'Login',
                            fontSize: 20,
                            textColor: appWhite,
                            buttonColor: kcPrimaryColorDark,
                          ),
                          const SizedBox(height: 100),
                          const Text.rich(
                            TextSpan(
                              text: 'New to the app? ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: kcPrimaryColorDark, // Define your color
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        kcPrimaryColorDark, // Define your color
                                    decoration: TextDecoration
                                        .underline, // Add underline decoration
                                  ),
                                ),
                                TextSpan(
                                  text: ' now to connect!',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
