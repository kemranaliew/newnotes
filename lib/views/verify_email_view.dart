import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lokalektinger/services/auth/auth_service.dart';
import 'package:lokalektinger/services/auth/bloc/auth_bloc.dart';
import 'package:lokalektinger/services/auth/bloc/auth_event.dart';
import 'package:lokalektinger/views/notes/notes_view.dart';
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
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      await AuthService.firebase().reloadUser();
      final user = AuthService.firebase().currentUser;
      devtools.log(user.toString());
      if (user?.isEmailVerified ?? false) {
        timer.cancel();
        setState(() {
          _isEmailVerified = true;
        });
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Email Verification"),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
            future: AuthService.firebase().initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  return const NotesView();
                } else if (user == null) {
                  return Column(
                    children: [
                      const Text("You are not logged in!"),
                      TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterView()),
                          );
                        },
                        child: const Text("You need to Login or Register"),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      const Text(
                          "We've sent you an email verification. Please open it to verify your account!"),
                      const Text(
                          "If you haven't received any email yet, press the button below."),
                      TextButton(
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(const AuthEventSendEmailVerification());
                        },
                        child: const Text("Send email verification"),
                      ),
                      const Text("Your Email is not verified"),
                      TextButton(
                          onPressed: () async {
                            context.read<AuthBloc>().add(
                                  const AuthEventLogout(),
                                );
                          },
                          child: const Text("Restart"))
                    ],
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
