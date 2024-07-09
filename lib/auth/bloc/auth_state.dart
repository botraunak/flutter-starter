part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.signedOut() = _SignedOut;
  const factory AuthState.signedIn({required User user}) = _SignedIn;
}
