import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

// ------------------- STATES -------------------
@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUser extends AuthState {
  final User user;
  AuthUser(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// ------------------- EVENTS -------------------
@immutable
abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}

// ------------------- STORE -------------------
class AuthStore extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthStore(this._firebaseAuth) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>((event, emit) {
      final User? user = _firebaseAuth.currentUser;

      if (user != null) {
        emit(AuthUser(user));
        print('Auth success');
      } else {
        emit(AuthInitial());
        print('Anon');
      }
    });

    on<SignInEvent>((event, emit) async {
      try {
        emit(AuthLoading());

        final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        final User? user = userCredential.user;

        if (user != null) {
          emit(AuthUser(user));
          print('User sign in');
        } else {
          emit(AuthError("Error"));
        }

      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignUpEvent>((event, emit) async {
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      await _firebaseAuth.signOut();
      emit(AuthInitial());
    });
  }
}