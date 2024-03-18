import 'package:flutter/material.dart';
import 'package:pothole_detection/modules/admin_panel/presentation/admin_panel_page.dart';
import 'package:pothole_detection/modules/user_panel/presentation/user_panel_page.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';
import 'package:pothole_detection/utils/common/app_input.dart';
import 'package:pothole_detection/utils/common/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? passwordVisible = false;

  // Method to check credentials and navigate accordingly
  void _login() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email == 'user@gmail.com' && password == 'User@123') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UserPanel()),
      );
    } else if (email == 'admin@gmail.com' && password == 'Admin@123') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AdminPanel()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Credentials'),
          content: const Text('Please enter valid username and password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/img/bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
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
                            onPressed: () {
                              print('Password Forget Successfully');
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    width: double.infinity,
                    isLoading: true,
                    height: 50,
                    onPressed: _login,
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
      ),
    );
  }
}
