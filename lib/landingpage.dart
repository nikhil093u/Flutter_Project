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
                                  image: AssetImage('assets/logo/company_logo.png'),
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
                'Oceana',
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
                'For Oceana',
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
            ],
          ),
        ),
      ),
    );
  }
}
