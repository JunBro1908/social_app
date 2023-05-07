import 'package:flutter/material.dart';
import 'package:social_app/resources/auth_methods.dart';
import 'package:social_app/screen/home_screen.dart';
import 'package:social_app/screen/signup_screen.dart';
import 'package:social_app/utils/colors.dart';
import 'package:social_app/utils/text_field_input.dart';
import 'package:social_app/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/reponsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayoutScreen(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
      // user state can not persist under code.
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const HomeScreen(),
      //   ),
      // );
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // control the display screen by using mediaquery, apply seperatly even can control keyboard on screen
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // make spacing
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // app logo
              Image.asset(
                'assets/social_app_logo.png',
                color: primaryColor,
                height: 130,
              ),
              const SizedBox(
                height: 48,
              ),
              // input email
              TextFieldInput(
                hintText: 'Enter you email',
                textInputType: TextInputType.emailAddress,
                textEdittingController: _emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              // input password
              TextFieldInput(
                hintText: 'Enter you password',
                textInputType: TextInputType.emailAddress,
                textEdittingController: _passwordController,
                isPass: true,
              ),
              // login button
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 24, 0, 12),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Log In'),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
