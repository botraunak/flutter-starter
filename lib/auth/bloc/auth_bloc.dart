import 'dart:async';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.signedOut()) {
    authStateStreamSubscription =
        _firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        add(const AuthEvent.signOut());
      } else {
        add(AuthEvent.signedInwithProvider(user: user));
      }
    });
    // Handle Sign Out
    on<_SignOut>((event, emit) async {
      debugPrint('DEBUG: AuthStateChange: Sign Out');
      emit(const AuthState.signedOut());
    });
    // Handle Sign In
    on<_SignedInWithProvider>((event, emit) async {
      final token = await event.user.getIdToken();
      final user = event.user;
      log('DEBUG: AuthStateChange: Sign In: $token');
      await FirebaseCrashlytics.instance.setUserIdentifier(user.uid);
      await FirebaseAnalytics.instance.setUserId(id: user.uid);

      debugPrint(
        [
          'DEBUG: user details ${user.photoURL}, ${user.displayName},',
          ' ${user.email} ',
        ].join(),
      );
      emit(AuthState.signedIn(user: user));
    });
  }
  final _firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<User?>? authStateStreamSubscription;

  User? getUser() {
    if (state is _SignedIn) {
      final signedInState = state as _SignedIn;
      return signedInState.user;
    }
    return null;
  }

  bool isLoggedIn() {
    if (state is _SignedIn) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    authStateStreamSubscription?.cancel();
    return super.close();
  }
}
