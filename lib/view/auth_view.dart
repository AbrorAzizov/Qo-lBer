import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_state.dart';
import 'package:qol_ber/view/sign_in_page.dart';
import 'package:qol_ber/view/sign_up_page.dart';

import '../auth/bloc/auth_bloc.dart';
import '../auth/dialog/firebase_error_dialog.dart';
import 'home_page.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(context) {
    return  BlocConsumer<AuthBloc, AuthState>(

        listener: (context, state) {
          final error = state.authError;
          if (error != null) {
            showFirebaseErrorDialog(context: context, authError: error);
          }
           else if (state.isLoading == true) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            );
          }


        },

        builder: (context, state) {
          if (state is AuthStateLoggedIn) {
            return HomePage();
          }
          if (state is AuthStateLoggedOut) {
            return  LoginPage();
          }
          if (state is AuthStateRegistering) {
            return SignupPage();
          }
          return Container();
        },
    );
  }
}
