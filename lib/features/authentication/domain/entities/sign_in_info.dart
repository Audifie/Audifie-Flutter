import 'package:equatable/equatable.dart';

class SignInInfo extends Equatable {
  final String email;
  final String password;

  const SignInInfo({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
