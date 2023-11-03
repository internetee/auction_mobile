part of 'auth_cubit.dart';

enum AuthStatus {
  unknown,
  loading,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;
  final String message;

  const AuthState._({this.status = AuthStatus.unknown, this.user = User.empty, this.message = ''});

  const AuthState.unknown() : this._();

  const AuthState.loading() : this._();

  const AuthState.authenticated({required User user}) : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated({required String message}) : this._(status: AuthStatus.unauthenticated, user: User.empty, message: message);

  @override
  List<Object> get props => [status, user, message];
}

// abstract class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthSuccess extends AuthState {
//   final User user;

//   const AuthSuccess({required this.user});

//   @override
//   List<Object> get props => [user];
// }

// class AuthFailure extends AuthState {
//   final String message;

//   const AuthFailure(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class PassweordResetSuccess extends AuthState {}
