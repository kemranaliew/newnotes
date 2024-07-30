import 'package:flutter/material.dart';
import 'package:lokalektinger/main.dart';

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
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Text("Go to Notes!"),
        ),
        const Text("Your Email is verified")
      ],
    );
  }
}
