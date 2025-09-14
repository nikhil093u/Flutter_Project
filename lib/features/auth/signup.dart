// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/authprovider.dart';
import 'package:flutter_application/routes/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final storage = FlutterSecureStorage();
  bool isEmailSignUp = true;
  bool isOTPVerified = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_validateFields()) return;

    final newUser = User(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      dob: _dobController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool signUpSuccess = authProvider.signUp(newUser);

    if (signUpSuccess) {
      _showMessage("Sign up successful! Welcome to Oceana Positive!");
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      _showMessage(
        "User with this email already exists. Please try logging in.",
      );
      await Future.delayed(Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  bool _validateFields() {
    if (_firstNameController.text.trim().isEmpty) {
      _showMessage("Please enter your first name");
      return false;
    }

    if (_lastNameController.text.trim().isEmpty) {
      _showMessage("Please enter your last name");
      return false;
    }

    if (_dobController.text.trim().isEmpty) {
      _showMessage("Please enter your date of birth");
      return false;
    }

    if (_emailController.text.trim().isEmpty) {
      _showMessage("Please enter your email");
      return false;
    }

    if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      _showMessage("Please enter a valid email address");
      return false;
    }

    if (_phoneController.text.trim().isEmpty) {
      _showMessage("Please enter your phone number");
      return false;
    }

    if (_passwordController.text.trim().isEmpty) {
      _showMessage("Please enter a password");
      return false;
    }

    if (_passwordController.text.length < 8) {
      _showMessage("Password must be at least 8 characters");
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage("Passwords do not match");
      return false;
    }

    if (!isOTPVerified) {
      _showMessage("Please verify your OTP first");
      return false;
    }

    return true;
  }

  Future<void> _handleOTPVerification() async {
    String contactMethod = isEmailSignUp
        ? _emailController.text.trim()
        : _phoneController.text.trim();

    if (contactMethod.isEmpty) {
      _showMessage(
        isEmailSignUp
            ? "Please enter your email"
            : "Please enter your phone number",
      );
      return;
    }

    if (isEmailSignUp &&
        (!contactMethod.contains('@') || !contactMethod.contains('.'))) {
      _showMessage("Please enter a valid email address");
      return;
    }

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isOTPVerified = true;
    });
    _showMessage("OTP verified successfully!");
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
                'Sign Up',
                style: TextStyle(
                  color: Color(0xFF030303),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEmailSignUp = true;
                        isOTPVerified = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEmailSignUp
                          ? Colors.blue
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.black.withOpacity(0.9),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Sign Up with Email',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEmailSignUp = false;
                        isOTPVerified = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isEmailSignUp
                          ? Colors.blue
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.black.withOpacity(0.9),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Sign Up with Phone',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (isEmailSignUp) ...[
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
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 335,
                        height: 48,
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email@gmail.com',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Phone Number*",
                        style: TextStyle(
                          color: Color(0xFF030303),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 335,
                        height: 48,
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              SizedBox(
                width: 335,
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleOTPVerification,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (isOTPVerified) {
                        return Colors.green;
                      }
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.blue;
                      }
                      return Colors.blue; 
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
                    elevation: MaterialStateProperty.all(2),
                  ),

                  child: Text(
                    isOTPVerified ? 'OTP Verified ✓' : 'Verify OTP',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "First Name*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Last Name*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Date of Birth*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _dobController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          hintText: 'DD/MM/YYYY',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Email*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email@example.com',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Phone Number*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Enter Password*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: '**********',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Confirm Password*",
                      style: TextStyle(
                        color: Color(0xFF030303),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 335,
                      height: 48,
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: '**********',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 335,
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((
                      Set<MaterialState> states,
                    ) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.blue; 
                      }
                      return Colors.blue;
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
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
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
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
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
