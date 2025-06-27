import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/auth/auth_error.dart';
import 'package:qol_ber/auth/bloc/auth_event.dart';
import 'package:qol_ber/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLoggedOut(isLoading: false)) {
    on<AuthEventSignIn>(_onSignIn);
    on<AuthEventSignUp>(_onSignUp);
    on<AuthEventGoToSignUp>(_goToSignUp);
    on<AuthEventGoToSignIn>(_goToSignIn);
  }

  void _goToSignUp(
      AuthEventGoToSignUp event ,
      Emitter<AuthState> emit
      ){
    emit(AuthStateRegistering(isLoading: false));
  }

  void _goToSignIn (
      AuthEventGoToSignIn event,
      Emitter<AuthState> emit
      ){
    emit(AuthStateLoggedOut(isLoading: false));
  }

  Future<void> _onSignUp(AuthEventSignUp event,
      Emitter<AuthState> emit,) async {
    final email = event.email;
    final password = event.password;
    emit(AuthStateRegistering(isLoading: true));

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user == null) {
        emit(AuthStateLoggedOut(isLoading: false));
        return;
      }


      emit(AuthStateLoggedIn(isLoading: false, user: user));
    } on FirebaseAuthException catch (e){
     emit( AuthStateRegistering(isLoading: false,authError: AuthError.from(e)));
    }
  }


  Future<void> _onSignIn(AuthEventSignIn event,
      Emitter<AuthState> emit,) async {
    final email = event.email;
    final password = event.password;

    emit(AuthStateLoggedOut(isLoading: true));

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user == null) {
        emit(AuthStateLoggedOut(isLoading: false));
        return;
      }


      emit(AuthStateLoggedIn(isLoading: false, user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthStateLoggedOut(isLoading: false, authError: AuthError.from(e)));
    }
  }
}
