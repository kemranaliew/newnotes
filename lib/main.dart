import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lokalektinger/firebase_options.dart';
import 'package:lokalektinger/views/login_view.dart';
import 'package:lokalektinger/views/register_view.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        "/login/": (context) => const LoginView(),
        "/register/": (context) => const RegisterView(),
        "/emailverifiednow/": (context) => const EmailVerifiedNow(),
      },
    ),
    );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    

    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification"),
        backgroundColor: const Color.fromARGB(255, 97, 206, 101),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          },
        ),
      ),
      
      body: FutureBuilder(
        future: Firebase.initializeApp(
           options: DefaultFirebaseOptions.currentPlatform,
         ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            
            case ConnectionState.done:            
            final user = FirebaseAuth.instance.currentUser;
            user?.reload();
            print(user);
            print("hallo");
            
            if (user?.emailVerified ?? false) {
              
              return const EmailVerifiedNow();

              
            } else {
  
             return const VerifyEmailView();
            }
            
          default:
        
        return const Text("Loading...");
          }
          
        }
  
      )
    );
  }
}



class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  Timer? _timer;
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
      print(user);
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
        const Text("Please verify your email address:"),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text("Send email verification"),
        ),
        const Text("Your Email is not verified")
      ],
      );
  }
  }
}

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



//Class EmailVarifiedNow!
//Hello










