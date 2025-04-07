import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// ------------------- REPOSITORY -------------------

abstract class AuthRepository {
  Future<User?> signIn(String email, String password);
  Future<User?> signUp(String email, String password);
  Future<void> signOut();
  Stream<User?> get authStateChanges;
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<User?> signIn(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<User?> signUp(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}

// ------------------- STATES -------------------

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUser extends AuthState {
  final User user;
  AuthUser(this.user);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object> get props => [message];
}

// ------------------- EVENTS -------------------

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  AuthSignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String rePassword;
  AuthSignUp(this.email, this.password, this.rePassword);

  @override
  List<Object> get props => [email, password, rePassword];
}

class AuthSignOut extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

// ------------------- BLOC -------------------

class AuthStore extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthStore(this.authRepository) : super(AuthInitial()) {
    on<CheckAuthStatus>((event, emit) async {
      final user = await authRepository.authStateChanges.first;
      if (user != null) {
        emit(AuthUser(user));
      } else {
        emit(AuthInitial());
      }
    });

    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signIn(event.email, event.password);
        if (user != null) {
          emit(AuthUser(user));
        } else {
          emit(AuthError("Failed to sign in"));
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthInitial());
      }
    });

    on<AuthSignUp>((event, emit) async {
      // If passwords are not the same
      if (event.password != event.rePassword) {
        emit(AuthError("Passwords are not the same!"));
        return;
      }

      emit(AuthLoading());
      try {
        final user = await authRepository.signUp(event.email, event.password);
        if (user != null) {
          emit(AuthUser(user));
        } else {
          emit(AuthError("Failed to sign up"));
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthInitial());
      }
    });


    on<AuthSignOut>((event, emit) async {
      await authRepository.signOut();
      emit(AuthInitial());
    });
  }
}
