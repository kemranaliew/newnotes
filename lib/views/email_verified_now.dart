import 'package:flutter/material.dart';
import 'package:lokalektinger/views/login_view.dart';

class EmailVerifiedNow extends StatelessWidget {
  const EmailVerifiedNow({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const Text("Your Email is Verified"),
        TextButton(
          onPressed: () { 
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginView()),
  );
          },
          child: const Text("Back to Login"),
        ),
        const Text("Your Email is verified")
      ],
    );
  }
}