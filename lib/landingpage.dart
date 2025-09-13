// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/routes/routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
                height: 300,
                child: SizedBox(
                  width: 335,
                  height: 300,
                  child: Stack(
                    children: const [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 33),
                          child: SizedBox(
                            width: 236,
                            height: 236,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/logo/company_logo.png',
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
              ),
              const SizedBox(height: 100),
              const Text(
                'Oceana Positive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF030303),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.17,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'For Oceana Positive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF030303),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  height: 1.125,
                ),
              ),
              const SizedBox(height: 64),
              SizedBox(
                width: 335,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signup);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((
                      Set<MaterialState> states,
                    ) {
                      if (states.contains(MaterialState.pressed)) {
                        return Color(0xFF5BAAF8); // Pressed color
                      }
                      return const Color(0xFFA4CDFD); // Default color
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
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.375,
                      fontSize: 16,
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
