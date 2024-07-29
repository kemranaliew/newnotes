import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lokalektinger/constants/routes.dart';
import 'package:lokalektinger/firebase_options.dart';
import 'package:lokalektinger/views/email_verified_now.dart';
import 'package:lokalektinger/views/register_view.dart';
import 'dart:developer' as devtools show log;

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  Timer? _timer;
  // ignore: unused_field
  bool _isEmailVerified = false;
  


  @override
  void initState() {
    super.initState();
    _startEmailVerificationCheck();
  }

  void _startEmailVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      devtools.log(user.toString());
      if (user?.emailVerified ?? false) {
        timer.cancel();
        setState(() {
          _isEmailVerified = true;
        
        });
        ;
      } else if (user == null) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Email Verification"),
    backgroundColor: Colors.green,),

    body: FutureBuilder(
        future: Firebase.initializeApp(
           options: DefaultFirebaseOptions.currentPlatform,
         ),
        builder: (context, snapshot) {
          
    final user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified ?? false) {
      return const EmailVerifiedNow();
       
         
  } else if(user?.emailVerified == null){
      
      return Column(
      children: [
        const Text("You are not logged in!"),
        TextButton(onPressed: () async {
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const RegisterView()),
  );
      }, 
      child: const Text("You need to Login or Register"),),
      ],
      );

  } else {
    return Column(
      children: [
        const Text("We've sent you an email verification. Please open it to verify your account!"),
        const Text("If you haven't received any email yet, press the button below."),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text("Send email verification"),
        ),
        const Text("Your Email is not verified"),
        TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (_) => false);
          },
          child: const Text("Restart"))
      ],
      );
  }
        }
  )
    );
  }
}