import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_state.dart';
import 'package:qol_ber/view/sign_in_page.dart';
import 'package:qol_ber/view/sign_up_page.dart';

import '../auth/bloc/auth_bloc.dart';
import '../auth/dialog/firebase_error_dialog.dart';
import 'home_page.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});
  @override
  Widget build(context) {
    return  BlocConsumer<AuthBloc, AuthState>(

        listener: (context, state) {
          if (state.isLoading == true) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state.authError != null) {
            showFirebaseErrorDialog(
                context: context, authError: state.authError!);
          }

          if (!state.isLoading) {
            Navigator.of(context, rootNavigator: true).pop();
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
