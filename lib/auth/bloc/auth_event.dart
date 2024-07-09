part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signedInwithProvider({
    required User user,
  }) = _SignedInWithProvider;
  const factory AuthEvent.signOut() = _SignOut;
}
