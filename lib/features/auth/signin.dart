// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/authprovider.dart';
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
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in all fields");
      return;
    }

    if (!email.contains('@') || !email.contains('.com')) {
      _showMessage('Enter a valid email containing "@" and ".com"');
      return;
    }

    if (password.length < 8) {
      _showMessage('Password must be minimum 8 characters');
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool loginSuccess = authProvider.signIn(email: email, password: password);

    if (loginSuccess) {
      _showMessage("Login Successful!");
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      _showMessage("Invalid email or password. Please try again or sign up.");
    }
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
                        keyboardType: TextInputType.emailAddress,
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
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((
                      Set<MaterialState> states,
                    ) {
                      if (states.contains(MaterialState.pressed)) {
                        return  Colors.blue; // Pressed color
                      }
                      return Colors.blue; // Default color
                    }),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(335, 48)),
                    shadowColor: MaterialStateProperty.all(
                      Colors.black.withOpacity(0.9),
                    ),
                    elevation: MaterialStateProperty.all(3),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white,fontFamily: 'poppins',fontWeight: FontWeight.w600,height: 1.375, fontSize: 16),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 3)),
    );
  }
}
