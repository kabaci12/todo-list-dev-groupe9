import 'package:flutter/material.dart';
import 'package:todos_project/presentation/screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) {
            return const HomePage();
          }),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/popo.png"),
            // const SizedBox(height: 30),
            // const CircularProgressIndicator(
            //   color: Colors.blue,
            // ),
          ],
        ),
      ),
    );
  }
}
