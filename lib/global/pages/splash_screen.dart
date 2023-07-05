import 'package:flutter/material.dart';
import 'package:pet_keeper_front/features/pet-lover/presentation/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateForward();
  }

  _navigateForward() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ClipRRect(
              child: Image.asset(
                'assets/images/banner.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(195, 42, 34, 117),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 200 * fem,
                height: 200 * fem,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
