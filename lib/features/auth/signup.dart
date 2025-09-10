// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/authprovider.dart';
// import 'package:cryptography/cryptography.dart';
// import 'dart:convert';
// import 'package:flutter_application/core/services/apiservice.dart';
// import 'package:flutter_application/core/services/encrypt.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Navigator.pushNamed(context, Routes.home);
      _showMessage("Login Successfull!");
    } else if (!email.contains('@') || !email.contains('.com')) {
      _showMessage('Enter a valid email containing "@" and ".com"');
    } else if (password.length<8) {
      _showMessage('PassWord must be min 8 characters');
    } else {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).login(email: email, password: password);
      Navigator.pushNamed(context, Routes.home);
    }

    // try {
    //   final response = await ApiService.login(email: email, password: password);
    //   if (response.statusCode == 200) {
    //     _showMessage("Loggin Successfull");
    //     Map<String, dynamic> data = json.decode(response.body);
    //     final token = data['access_token'];
    //     await storage.write(key: 'auth_token', value: token);

    //     // ignore: use_build_context_synchronously
    //     Navigator.pushNamed(context, Routes.home);
    //   } else {
    //     _showMessage("Sign-up failed. Please try again.");
    //   }
    // } catch (e) {
    //   _showMessage("An error occurred. Please try again.");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 335,
                height: 200,
                child: Stack(
                  children: const [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 72),
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.fromBorderSide(
                                BorderSide(color: Color(0xFFF68B1F), width: 4),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/logo/login_image.png',
                                ),
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Oceana Positive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF030303),
                  fontSize: 34,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  height: 1.41,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF030303),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.57,
                      ),
                    ),

                    const SizedBox(height: 6),

                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _emailController,
                        style: const TextStyle(
                          color: Color(0xFF171719),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          height: 1.43,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Email@gmail.com',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Color(0xFFD5D5DA)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Color(0xFFD5D5DA)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Color(0xFFD5D5DA)),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Password*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.57,
                      ),
                    ),

                    const SizedBox(height: 6),

                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(
                          color: Color(0xFF171719),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          height: 1.43,
                        ),
                        decoration: const InputDecoration(
                          hintText: '**********',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Color(0xFFD5D5DA)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Color(0xFFD5D5DA)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Color(0xFFD5D5DA)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: 335,
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    backgroundColor: const Color(0xFFA4CDFD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(335, 48),
                    shadowColor: Colors.black.withOpacity(0.9),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.375,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New to Oceana Positive? ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF030303),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      height: 1.57,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.signin);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        height: 1.57,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
