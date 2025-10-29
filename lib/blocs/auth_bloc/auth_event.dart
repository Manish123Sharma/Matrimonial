import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String profileId;
  final String password;
  final String relation;
  final bool rememberMe;

  LoginRequested({
    required this.profileId,
    required this.password,
    required this.relation,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [profileId, password, relation, rememberMe];
}

class LogoutRequested extends AuthEvent {}
