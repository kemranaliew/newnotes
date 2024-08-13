import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lokalektinger/constants/routes.dart';
import 'package:lokalektinger/services/auth/auth_service.dart';
import 'package:lokalektinger/services/auth/bloc/auth_bloc.dart';
import 'package:lokalektinger/services/auth/bloc/auth_event.dart';
import 'package:lokalektinger/services/auth/bloc/auth_state.dart';
import 'package:lokalektinger/services/auth/firebase_auth_provider.dart';
import 'package:lokalektinger/views/email_verified_now.dart';
import 'package:lokalektinger/views/login_view.dart';
import 'package:lokalektinger/views/notes/create_update_note_view.dart';
import 'package:lokalektinger/views/notes/notes_view.dart';
import 'package:lokalektinger/views/register_view.dart';
import 'package:lokalektinger/views/verify_email_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.firebase().initialize();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        emailVerifiedRoute: (context) => const EmailVerifiedNow(),
        notesRoute: (context) => const NotesView(),
        homePageRoute: (context) => const HomePage(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return const NotesView();
      } if (state is AuthStateNeedsVerification){
        return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut){
        return const LoginView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });

  }
}
