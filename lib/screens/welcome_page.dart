import 'package:auppist_app/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'AUPPIST',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
            Text(
              'Order Smarter Not Harder',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20),

            Image.asset('assets/images/logo.png', height: 150),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
              child: Text('Login'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              ),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
