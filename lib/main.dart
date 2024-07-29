import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lokalektinger/constants/routes.dart';
import 'package:lokalektinger/firebase_options.dart';
import 'package:lokalektinger/views/email_verified_now.dart';
import 'package:lokalektinger/views/login_view.dart';
import 'package:lokalektinger/views/register_view.dart';
import 'package:lokalektinger/views/verify_email_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        emailVerifiedRoute: (context) => const EmailVerifiedNow(),
        notesRoute: (context) => const NotesView(),
        homePageRoute: (context) => const HomePage(),
      },
    ),
    );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    

    
    return FutureBuilder(
        future: Firebase.initializeApp(
           options: DefaultFirebaseOptions.currentPlatform,
         ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            
            case ConnectionState.done:            
            final user = FirebaseAuth.instance.currentUser;
            user?.reload();
            
            
            if (user !=  null){
              if(user.emailVerified){
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return  const LoginView();
            }
            
          default:
        
        return const Text("Loading...");
          }
          
        }
  
      );
  }
}

enum MenuAction {
  logout
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const  Text("Main UI!"),
      actions: [
        PopupMenuButton<MenuAction>( onSelected: (value) async {
            switch (value) {
              
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) 
                  => false,
                  );
                }
            } 
            
        }, itemBuilder: (context) {
          return const [
            PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text("Logout")
            ),
          ];          
        },)
      ],
      ),
      body: const Text("Hello World!"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
  context: context, 
  builder: (context) {
    return AlertDialog(
      title: const Text("Sign out"),
      content: const Text("Are you sure you want to sign out?"),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        }, child: const Text("Cancel")),
        TextButton(onPressed: () {
          Navigator.of(context).pop(true);
        }, child: const Text("Log out")),
        ]
      );
    }
  ).then((value) => value ?? false);
}
