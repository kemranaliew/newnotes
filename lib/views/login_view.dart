import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lokalektinger/services/auth/auth_exceptions.dart';
import 'package:lokalektinger/services/auth/auth_service.dart';
import 'package:lokalektinger/services/auth/bloc/auth_bloc.dart';
import 'package:lokalektinger/services/auth/bloc/auth_event.dart';
import 'package:lokalektinger/services/auth/bloc/auth_state.dart';
// import 'dart:developer' as devtools show log;

import 'package:lokalektinger/utilities/dialogs/error_dialog.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is WrongCredentialsAuthException) {
            await showErrorDialog(context, "Invalid Credentials");
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, "Error!");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: FutureBuilder(
          future: AuthService.firebase().initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text("Please log in to your account in order to interact with and create notes!"),
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
                          final email = _email.text;
                          final password = _password.text;
                  
                          context.read<AuthBloc>().add(
                                AuthEventLogin(
                                  email,
                                  password,
                                ),
                              );
                          //devtools.log(userCredential.toString());
                        },
                        child: const Text("Login"),
                      ),
                       TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEventForgotPassowrd(),
                              );
                        },
                        child: const Text("Forgot password?"),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                const AuthEventShouldRegister(),
                              );
                        },
                        child: const Text("Not registered yet? Register here!"),
                      ),
                     
                    ],
                  ),
                );

              default:
                return const Text("Loading...");
            }
          },
        ),
      ),
    );
  }
}
