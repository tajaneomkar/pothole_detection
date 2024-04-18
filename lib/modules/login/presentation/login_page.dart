import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pothole_detection/config/router/app_router.dart';
import 'package:pothole_detection/config/router/app_router.gr.dart';
import 'package:pothole_detection/modules/login/presentation/bloc/login_bloc.dart';
import 'package:pothole_detection/services/service_locator.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';
import 'package:pothole_detection/utils/common/app_input.dart';
import 'package:pothole_detection/utils/common/custom_button.dart';
import 'package:provider/provider.dart';

@RoutePage()
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
                serviceLocator<AppRouter>().replace(const AdminPanelRoute());
              } else if (state.response?.userData?.role == 'user') {
                serviceLocator<AppRouter>().replace(const UserPanelRoute());
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
                          const SizedBox(height: 50),
                          CustomButton(
                            isLoading:
                                state is LoginLoadingState ? true : false,
                            width: double.infinity,
                            height: 50,
                            onPressed: () {
                              Provider.of<LoginBloc>(context, listen: false)
                                  .add(LoginInitialEvent(
                                      userName: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim()));
                            },
                            text: 'Login',
                            fontSize: 20,
                            textColor: appWhite,
                            buttonColor: kcPrimaryColorDark,
                          ),
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
