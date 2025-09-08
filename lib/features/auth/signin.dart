import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final storage = FlutterSecureStorage();
  bool isEmailSignUp = true;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _userIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    // Implement the API call to handle sign up.
  }

  Future<void> _handleOTPVerification() async {
    // Implement OTP verification logic
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
              // App Logo
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
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              image: DecorationImage(
                                image: AssetImage('assets/logo/login_image.png'),
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
                'Oceana',
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

              // Selection Buttons: Email or Phone
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEmailSignUp = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEmailSignUp ? Color(0xFFA4CDFD) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Sign Up with Email',style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEmailSignUp = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isEmailSignUp ? Color(0xFFA4CDFD) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Sign Up with Phone',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Input Fields based on Selection
              if (isEmailSignUp) ...[
                // Email Input
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
                          decoration: const InputDecoration(
                            hintText: 'Email@gmail.com',
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
              ] else ...[
                // Phone Number Input
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // OTP Button
              SizedBox(
                width: 335,
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleOTPVerification,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    backgroundColor: const Color(0xFFA4CDFD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(335, 48),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Form Fields for First Name, Last Name, DOB, etc.
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
                        controller: _dobController,
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
                        controller: _dobController,
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
                        controller: _dobController,
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
                      "Conform Password*",
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
                    // More fields here for User ID, Password, Confirm Password...
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: 335,
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    backgroundColor: const Color(0xFFA4CDFD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(335, 48),
                    elevation: 0,
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
            ],
          ),
        ),
      ),
    );
  }
}
