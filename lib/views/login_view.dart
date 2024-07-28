import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lokalektinger/constants/routes.dart';
import 'package:lokalektinger/firebase_options.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
late final TextEditingController _password;

@override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"),
      
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ), 
        builder: (context, snapshot) { 
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            return Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter Your Email Here",
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: "Enter Your Password Here",
              ),
            ),
            TextButton(
              onPressed: () async {
              final email =_email.text;
              final password = _password.text;
              
              try{final userCredential = 
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email, 
                password: password);
                devtools.log(userCredential.toString());
                } on FirebaseAuthException catch (e) {
                  devtools.log(e.code);
                } 

                Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false,);
              
              
            }, child: const Text("Login"),
            
            ),
            TextButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute,
               (route) => false,);
            },
            child: const Text ("Not registered yet? Register here!"),
            
            )


          ],
        );

            default:
            return const Text("Loading...");
          }
         },
        ),
    
    );
  }  
}